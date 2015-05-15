# vim: sts=2 ts=2 sw=2 et ai
{% from "users/map.jinja" import users with context %}
{% set used_sudo = [] %}
{% set used_googleauth = [] %}

{%- for name, user in pillar.get('users', {}).items() if user.absent is not defined or not user.absent %}
{%- if user == None -%}
{%- set user = {} -%}
{%- endif -%}
{%- if 'sudouser' in user and user['sudouser'] %}
{%- do used_sudo.append(1) %}
{%- endif %}
{%- if 'google_auth' in user %}
{%- do used_googleauth.append(1) %}
{%- endif %}
{%- endfor %}

{%- if used_sudo or used_googleauth %}
include:
{%- if used_sudo %}
  - users.sudo
{%- endif %}
{%- if used_googleauth %}
  - users.googleauth
{%- endif %}
{%- endif %}

{% for name, user in pillar.get('users', {}).items() if user.absent is not defined or not user.absent %}
{%- if user == None -%}
{%- set user = {} -%}
{%- endif -%}
{%- set home = user.get('home', "/home/%s" % name) -%}

{%- if 'prime_group' in user and 'name' in user['prime_group'] %}
{%- set user_group = user.prime_group.name -%}
{%- else -%}
{%- set user_group = name -%}
{%- endif %}

{% for group in user.get('groups', []) %}
users_{{ name }}_{{ group }}_group:
  group:
    - name: {{ group }}
    - present
{% endfor %}

users_{{ name }}_user:
  {% if user.get('createhome', True) %}
  file.directory:
    - name: {{ home }}
    - user: {{ name }}
    - group: {{ user_group }}
    - mode: {{ user.get('user_dir_mode', '0750') }}
    - require:
      - user: {{ name }}
      - group: {{ user_group }}
  {%- endif %}
  group.present:
    - name: {{ user_group }}
    {%- if 'prime_group' in user and 'gid' in user['prime_group'] %}
    - gid: {{ user['prime_group']['gid'] }}
    {%- elif 'uid' in user %}
    - gid: {{ user['uid'] }}
    {%- endif %}
  user.present:
    - name: {{ name }}
    - home: {{ home }}
    - shell: {{ user.get('shell', users.get('shell', '/bin/bash')) }}
    {% if 'uid' in user -%}
    - uid: {{ user['uid'] }}
    {% endif -%}
    {% if 'password' in user -%}
    - password: '{{ user['password'] }}'
    {% endif -%}
    {% if 'prime_group' in user and 'gid' in user['prime_group'] -%}
    - gid: {{ user['prime_group']['gid'] }}
    {% else -%}
    - gid_from_name: True
    {% endif -%}
    {% if 'fullname' in user %}
    - fullname: {{ user['fullname'] }}
    {% endif -%}
    {% if not user.get('createhome', True) %}
    - createhome: False
    {% endif %}
    {% if 'expire' in user -%}
    - expire: {{ user['expire'] }}
    {% endif -%}
    - remove_groups: {{ user.get('remove_groups', 'False') }}
    - groups:
      - {{ user_group }}
      {% for group in user.get('groups', []) -%}
      - {{ group }}
      {% endfor %}
    - require:
      - group: {{ user_group }}
      {% for group in user.get('groups', []) -%}
      - group: {{ group }}
      {% endfor %}

users_user_keydir_{{ name }}:
  file.directory:
    - name: {{ user.get('home', '/home/{0}'.format(name)) }}/.ssh
    - user: {{ name }}
    - group: {{ user_group }}
    - makedirs: True
    - mode: 700
    - require:
      - user: {{ name }}
      - group: {{ user_group }}
      {%- for group in user.get('groups', []) %}
      - group: {{ group }}
      {%- endfor %}

  {% if 'ssh_keys' in user %}
  {% set key_type = 'id_' + user.get('ssh_key_type', 'rsa') %}
users_user_{{ name }}_private_key:
  file.managed:
    - name: {{ user.get('home', '/home/{0}'.format(name)) }}/.ssh/{{ key_type }}
    - user: {{ name }}
    - group: {{ user_group }}
    - mode: 600
    - show_diff: False
    - contents_pillar: users:{{ name }}:ssh_keys:privkey
    - require:
      - user: users_{{ name }}_user
      {% for group in user.get('groups', []) %}
      - group: users_{{ name }}_{{ group }}_group
      {% endfor %}
users_user_{{ name }}_public_key:
  file.managed:
    - name: {{ user.get('home', '/home/{0}'.format(name)) }}/.ssh/{{ key_type }}.pub
    - user: {{ name }}
    - group: {{ user_group }}
    - mode: 644
    - show_diff: False
    - contents_pillar: users:{{ name }}:ssh_keys:pubkey
    - require:
      - user: users_{{ name }}_user
      {% for group in user.get('groups', []) %}
      - group: users_{{ name }}_{{ group }}_group
      {% endfor %}
  {% endif %}

{% if 'ssh_auth_file' in user %}
users_authorized_keys_{{ name }}:
  file.managed:
    - name: {{ home }}/.ssh/authorized_keys
    - user: {{ name }}
    - group: {{ name }}
    - mode: 600
    - contents: |
        {% for auth in user.ssh_auth_file -%}
        {{ auth }}
        {% endfor -%}
{% endif %}

{% if 'ssh_auth' in user %}
{% for auth in user['ssh_auth'] %}
users_ssh_auth_{{ name }}_{{ loop.index0 }}:
  ssh_auth.present:
    - user: {{ name }}
    - name: {{ auth }}
    - require:
        - file: users_{{ name }}_user
        - user: users_{{ name }}_user
{% endfor %}
{% endif %}

{% if 'ssh_keys_pillar' in user %}
{% for key_name, pillar_name in user['ssh_keys_pillar'].iteritems()  %}
users_ssh_keys_files_{{ name }}_{{ key_name }}_pub:
  file.managed:
    - name: {{ user.get('home', '/home/{0}'.format(name)) }}/.ssh/{{ key_name
    }}.pub
    - contents: |
        {{ pillar[pillar_name][key_name]['pubkey'] }}
users_ssh_keys_files_{{ name }}_{{ key_name }}_priv:
  file.managed:
    - name: {{ user.get('home', '/home/{0}'.format(name)) }}/.ssh/{{ key_name
    }}
    - contents: |
        {{ pillar[pillar_name][key_name]['privkey'] | indent(8) }}
{% endfor %}
{% endif %}

{% if 'ssh_auth_sources' in user %}
{% for pubkey_file in user['ssh_auth_sources'] %}
users_ssh_auth_source_{{ name }}_{{ loop.index0 }}:
  ssh_auth.present:
    - user: {{ name }}
    - source: {{ pubkey_file }}
    - require:
        - file: users_{{ name }}_user
        - user: users_{{ name }}_user
{% endfor %}
{% endif %}

{% if 'ssh_auth.absent' in user %}
{% for auth in user['ssh_auth.absent'] %}
users_ssh_auth_delete_{{ name }}_{{ loop.index0 }}:
  ssh_auth.absent:
    - user: {{ name }}
    - name: {{ auth }}
    - require:
        - file: users_{{ name }}_user
        - user: users_{{ name }}_user
{% endfor %}
{% endif %}

{% if 'ssh_config' in user %}
users_ssh_config_{{ name }}:
  file.managed:
    - name: {{ home }}/.ssh/config
    - user: {{ name }}
    - group: {{ user_group }}
    - mode: 640
    - contents: |
        # Managed by Saltstack
        {% for label, setting in user.ssh_config.items() %}
        # {{ label }}
        Host {{ setting.get('hostname') }}
          {%- for opts in setting.get('options') %}
          {{ opts }}
          {%- endfor %}
        {% endfor -%}
{% endif %}

{% if 'sudouser' in user and user['sudouser'] %}

users_sudoer-{{ name }}:
  file.managed:
    - name: {{ users.sudoers_dir }}/{{ name }}
    - user: root
    - group: {{ users.root_group }}
    - mode: '0440'
{% if 'sudo_rules' in user or 'sudo_defaults' in user %}
{% if 'sudo_rules' in user %}
{% for rule in user['sudo_rules'] %}
"validate {{ name }} sudo rule {{ loop.index0 }} {{ name }} {{ rule }}":
  cmd.run:
    - name: 'visudo -cf - <<<"$rule" | { read output; if [[ $output != "stdin: parsed OK" ]] ; then echo $output ; fi }'
    - stateful: True
    - shell: {{ users.visudo_shell }}
    - env:
      # Specify the rule via an env var to avoid shell quoting issues.
      - rule: "{{ name }} {{ rule }}"
    - require_in:
      - file: users_{{ users.sudoers_dir }}/{{ name }}
{% endfor %}
{% endif %}
{% if 'sudo_defaults' in user %}
{% for entry in user['sudo_defaults'] %}
"validate {{ name }} sudo Defaults {{ loop.index0 }} {{ name }} {{ entry }}":
  cmd.run:
    - name: 'visudo -cf - <<<"$rule" | { read output; if [[ $output != "stdin: parsed OK" ]] ; then echo $output ; fi }'
    - stateful: True
    - shell: {{ users.visudo_shell }}
    - env:
      # Specify the rule via an env var to avoid shell quoting issues.
      - rule: "Defaults:{{ name }} {{ entry }}"
    - require_in:
      - file: users_{{ users.sudoers_dir }}/{{ name }}
{% endfor %}
{% endif %}

users_{{ users.sudoers_dir }}/{{ name }}:
  file.managed:
    - name: {{ users.sudoers_dir }}/{{ name }}
    - contents: |
      {%- if 'sudo_defaults' in user %}
      {%- for entry in user['sudo_defaults'] %}
        Defaults:{{ name }} {{ entry }}
      {%- endfor %}
      {%- endif %}
      {%- if 'sudo_rules' in user %}
      {%- for rule in user['sudo_rules'] %}
        {{ name }} {{ rule }}
      {%- endfor %}
      {%- endif %}
    - require:
      - file: users_sudoer-defaults
      - file: users_sudoer-{{ name }}
{% endif %}
{% else %}
users_{{ users.sudoers_dir }}/{{ name }}:
  file.absent:
    - name: {{ users.sudoers_dir }}/{{ name }}
{% endif %}

{%- if 'google_auth' in user %}
{%- for svc in user['google_auth'] %}
users_googleauth-{{ svc }}-{{ name }}:
  file.managed:
    - replace: false
    - name: {{ users.googleauth_dir }}/{{ name }}_{{ svc }}
    - contents_pillar: 'users:{{ name }}:google_auth:{{ svc }}'
    - user: root
    - group: {{ users.root_group }}
    - mode: 600
    - require:
      - pkg: users_googleauth-package
{%- endfor %}
{%- endif %}

{% endfor %}

{% for name, user in pillar.get('users', {}).items() if user.absent is defined and user.absent %}
users_absent_user_{{ name }}:
{% if 'purge' in user or 'force' in user %}
  user.absent:
    - name: {{ name }}
    {% if 'purge' in user %}
    - purge: {{ user['purge'] }}
    {% endif %}
    {% if 'force' in user %}
    - force: {{ user['force'] }}
    {% endif %}
{% else %}
  user.absent:
    - name: {{ name }}
{% endif -%}
users_{{ users.sudoers_dir }}/{{ name }}:
  file.absent:
    - name: {{ users.sudoers_dir }}/{{ name }}
{% endfor %}

{% for user in pillar.get('absent_users', []) %}
users_absent_user_2_{{ user }}:
  user.absent
users_2_{{ users.sudoers_dir }}/{{ user }}:
  file.absent:
    - name: {{ users.sudoers_dir }}/{{ user }}
{% endfor %}

{% for group in pillar.get('absent_groups', []) %}
users_absent_group_{{ group }}:
  group.absent:
    - name: {{ group }}
{% endfor %}

