# vim: sts=2 ts=2 sw=2 et ai
{% from "users/map.jinja" import users with context %}
{% set used_sudo = [] %}
{% set used_googleauth = [] %}
{% set used_user_files = [] %}

{%- for name, user in pillar.get('users', {}).items()
        if user.absent is not defined or not user.absent %}
{%- if user == None -%}
{%- set user = {} -%}
{%- endif -%}
{%- if 'sudouser' in user and user['sudouser'] %}
{%- do used_sudo.append(1) %}
{%- endif %}
{%- if 'google_auth' in user %}
{%- do used_googleauth.append(1) %}
{%- endif %}
{%- if salt['pillar.get']('users:' ~ name ~ ':user_files:enabled', False) %}
{%- do used_user_files.append(1) %}
{%- endif %}
{%- endfor %}

{%- if used_sudo or used_googleauth or used_user_files %}
include:
{%- if used_sudo %}
  - users.sudo
{%- endif %}
{%- if used_googleauth %}
  - users.googleauth
{%- endif %}
{%- if used_user_files %}
  - users.user_files
{%- endif %}
{%- endif %}

{% for name, user in pillar.get('users', {}).items()
        if user.absent is not defined or not user.absent %}
{%- if user == None -%}
{%- set user = {} -%}
{%- endif -%}
{%- set current = salt.user.info(name) -%}
{%- set home = user.get('home', current.get('home', "/home/%s" % name)) -%}

{%- if 'prime_group' in user and 'name' in user['prime_group'] %}
{%- set user_group = user.prime_group.name -%}
{%- else -%}
{%- set user_group = name -%}
{%- endif %}

{% for group in user.get('groups', []) %}
users_{{ name }}_{{ group }}_group:
  group.present:
    - name: {{ group }}
    {% if group == 'sudo' %}
    - system: True
    {% endif %}
{% endfor %}

users_{{ name }}_user:
  {% if user.get('createhome', True) %}
  file.directory:
    - name: {{ home }}
    - user: {{ user.get('homedir_owner', name) }}
    - group: {{ user.get('homedir_group', user_group) }}
    - mode: {{ user.get('user_dir_mode', '0750') }}
    - require:
      - user: users_{{ name }}_user
      - group: {{ user_group }}
  {%- endif %}
  group.present:
    - name: {{ user_group }}
    {%- if 'prime_group' in user and 'gid' in user['prime_group'] %}
    - gid: {{ user['prime_group']['gid'] }}
    {%- elif 'uid' in user %}
    - gid: {{ user['uid'] }}
    {%- endif %}
    {% if 'system' in user and user['system'] %}
    - system: True
    {% endif %}
  user.present:
    - name: {{ name }}
    - home: {{ home }}
    - shell: {{ user.get('shell', current.get('shell', users.get('shell', '/bin/bash'))) }}
    {% if 'uid' in user -%}
    - uid: {{ user['uid'] }}
    {% endif -%}
    {% if 'password' in user -%}
    - password: '{{ user['password'] }}'
    {% endif -%}
    {% if user.get('empty_password') -%}
    - empty_password: {{ user.get('empty_password') }}
    {% endif -%}
    {% if 'enforce_password' in user -%}
    - enforce_password: {{ user['enforce_password'] }}
    {% endif -%}
    {% if 'hash_password' in user -%}
    - hash_password: {{ user['hash_password'] }}
    {% endif -%}
    {% if user.get('system', False) -%}
    - system: True
    {% endif -%}
    {% if 'prime_group' in user and 'gid' in user['prime_group'] -%}
    - gid: {{ user['prime_group']['gid'] }}
    {% elif 'prime_group' in user and 'name' in user['prime_group'] %}
    - gid: {{ user['prime_group']['name'] }}
    {% else -%}
    - gid_from_name: True
    {% endif -%}
    {% if 'fullname' in user %}
    - fullname: {{ user['fullname'] }}
    {% endif -%}
    {% if 'roomnumber' in user %}
    - roomnumber: {{ user['roomnumber'] }}
    {% endif %}
    {% if 'workphone' in user %}
    - workphone: {{ user['workphone'] }}
    {% endif %}
    {% if 'homephone' in user %}
    - homephone: {{ user['workphone'] }}
    {% endif %}
    {% if not user.get('createhome', True) %}
    - createhome: False
    {% endif %}
    {% if 'expire' in user -%}
        {% if grains['kernel'].endswith('BSD') and
            user['expire'] < 157766400 %}
        {# 157762800s since epoch equals 01 Jan 1975 00:00:00 UTC #}
    - expire: {{ user['expire'] * 86400 }}
        {% elif grains['kernel'] == 'Linux' and
            user['expire'] > 84006 %}
        {# 2932896 days since epoch equals 9999-12-31 #}
    - expire: {{ (user['expire'] / 86400) | int}}
        {% else %}
    - expire: {{ user['expire'] }}
        {% endif %}
    {% endif -%}
    - remove_groups: {{ user.get('remove_groups', 'False') }}
    - groups:
      - {{ user_group }}
      {% for group in user.get('groups', []) -%}
      - {{ group }}
      {% endfor %}
    {% if 'optional_groups' in user %}
    - optional_groups:
      {% for optional_group in user['optional_groups'] -%}
      - {{optional_group}}
      {% endfor %}
    {% endif %}
    - require:
      - group: {{ user_group }}
      {% for group in user.get('groups', []) -%}
      - group: {{ group }}
      {% endfor %}


  {% if 'ssh_keys' in user or
      'ssh_auth' in user or
      'ssh_auth_file' in user or
      'ssh_auth_pillar' in user or
      'ssh_auth.absent' in user or
      'ssh_config' in user %}
user_keydir_{{ name }}:
  file.directory:
    - name: {{ home }}/.ssh
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
  {% endif %}

  {% if 'ssh_keys' in user %}
  {% set key_type = 'id_' + user.get('ssh_key_type', 'rsa') %}
users_user_{{ name }}_private_key:
  file.managed:
    - name: {{ home }}/.ssh/{{ key_type }}
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
    - name: {{ home }}/.ssh/{{ key_type }}.pub
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

{% if 'ssh_auth_file' in user or 'ssh_auth_pillar' in user %}
users_authorized_keys_{{ name }}:
  file.managed:
    - name: {{ home }}/.ssh/authorized_keys
    - user: {{ name }}
    - group: {{ user_group }}
    - mode: 600
{% if 'ssh_auth_file' in user %}
    - contents: |
        {% for auth in user.ssh_auth_file -%}
        {{ auth }}
        {% endfor -%}
{% else %}
        {%- for key_name, pillar_name in user['ssh_auth_pillar'].items() %}
    - contents_pillar: {{ pillar_name }}:{{ key_name }}:pubkey
        {%- endfor %}
{% endif %}
{% endif %}

{% if 'ssh_auth' in user %}
{% for auth in user['ssh_auth'] %}
users_ssh_auth_{{ name }}_{{ loop.index0 }}:
  ssh_auth.present:
    - user: {{ name }}
    - name: {{ auth }}
    - require:
        - file: user_keydir_{{ name }}
        - user: users_{{ name }}_user
{% endfor %}
{% endif %}

{% if 'ssh_keys_pillar' in user %}
{% for key_name, pillar_name in user['ssh_keys_pillar'].items() %}
user_ssh_keys_files_{{ name }}_{{ key_name }}_private_key:
  file.managed:
    - name: {{ home }}/.ssh/{{ key_name }}
    - user: {{ name }}
    - group: {{ user_group }}
    - mode: 600
    - show_diff: False
    - contents_pillar: {{ pillar_name }}:{{ key_name }}:privkey
    - require:
      - user: users_{{ name }}_user
      {% for group in user.get('groups', []) %}
      - group: users_{{ name }}_{{ group }}_group
      {% endfor %}
user_ssh_keys_files_{{ name }}_{{ key_name }}_public_key:
  file.managed:
    - name: {{ home }}/.ssh/{{ key_name }}.pub
    - user: {{ name }}
    - group: {{ user_group }}
    - mode: 644
    - show_diff: False
    - contents_pillar: {{ pillar_name }}:{{ key_name }}:pubkey
    - require:
      - user: users_{{ name }}_user
      {% for group in user.get('groups', []) %}
      - group: users_{{ name }}_{{ group }}_group
      {% endfor %}
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

{% if 'ssh_auth_sources.absent' in user %}
{% for pubkey_file in user['ssh_auth_sources.absent'] %}
users_ssh_auth_source_delete_{{ name }}_{{ loop.index0 }}:
  ssh_auth.absent:
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
        # Do Not Edit
        {% for label, setting in user.ssh_config.items() %}
        # {{ label }}
        Host {{ setting.get('hostname') }}
          {%- for opts in setting.get('options') %}
          {{ opts }}
          {%- endfor %}
        {% endfor -%}
{% endif %}

{% if 'ssh_known_hosts' in user %}
{% for hostname, host in user['ssh_known_hosts'].items() %}
users_ssh_known_hosts_{{ name }}_{{ loop.index0 }}:
  ssh_known_hosts.present:
    - user: {{ name }}
    - name: {{ hostname }}
    {% if 'port' in host %}
    - port: {{ host['port'] }}
    {% endif -%}
    {% if 'fingerprint' in host %}
    - fingerprint: {{ host['fingerprint'] }}
    {% endif -%}
    {% if 'key' in host %}
    - key: {{ host['key'] }}
    {% endif -%}
    {% if 'enc' in host %}
    - enc: {{ host['enc'] }}
    {% endif -%}
    {% if 'hash_hostname' in host %}
    - hash_hostname: {{ host['hash_hostname'] }}
    {% endif -%}
{% endfor %}
{% endif %}

{% if 'ssh_known_hosts.absent' in user %}
{% for host in user['ssh_known_hosts.absent'] %}
users_ssh_known_hosts_delete_{{ name }}_{{ loop.index0 }}:
  ssh_known_hosts.absent:
    - user: {{ name }}
    - name: {{ host }}
{% endfor %}
{% endif %}

{% set sudoers_d_filename = name|replace('.','_') %}
{% if 'sudouser' in user and user['sudouser'] %}

users_sudoer-{{ name }}:
  file.managed:
    - replace: False
    - name: {{ users.sudoers_dir }}/{{ sudoers_d_filename }}
    - user: root
    - group: {{ users.root_group }}
    - mode: '0440'
{% if 'sudo_rules' in user or 'sudo_defaults' in user %}
#{#%
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
#%#}

users_{{ users.sudoers_dir }}/{{ name }}:
  file.managed:
    - replace: True
    - name: {{ users.sudoers_dir }}/{{ sudoers_d_filename }}
    - contents: |
      {%- if 'sudo_defaults' in user %}
      {%- for entry in user['sudo_defaults'] %}
        Defaults:{{ name }} {{ entry }}
      {%- endfor %}
      {%- endif %}
      {%- if 'sudo_rules' in user %}
        ########################################################################
        # File managed by Salt (users-formula).
        # Your changes will be overwritten.
        ########################################################################
        #
      {%- for rule in user['sudo_rules'] %}
        {{ name }} {{ rule }}
      {%- endfor %}
      {%- endif %}
    - require:
      - file: users_sudoer-defaults
      - file: users_sudoer-{{ name }}
  cmd.wait:
    - name: visudo -cf {{ users.sudoers_dir }}/{{ sudoers_d_filename }} || ( rm -rvf {{ users.sudoers_dir }}/{{ sudoers_d_filename }}; exit 1 )
    - watch:
      - file: {{ users.sudoers_dir }}/{{ sudoers_d_filename }}
{% endif %}
{% else %}
users_{{ users.sudoers_dir }}/{{ sudoers_d_filename }}:
  file.absent:
    - name: {{ users.sudoers_dir }}/{{ sudoers_d_filename }}
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
    - mode: 400
    - require:
      - pkg: users_googleauth-package
{%- endfor %}
{%- endif %}

#
# if not salt['cmd.has_exec']('git')
# fails even if git is installed
#
# this doesn't work (Salt bug), therefore need to run state.apply twice
#include:
#  - users
#
#git:
#  pkg.installed:
#    - require_in:
#      - sls: users
#
{% if 'gitconfig' in user %}
{% for key, value in user['gitconfig'].items() %}
users_{{ name }}_user_gitconfig_{{ loop.index0 }}:
  {% if grains['saltversioninfo'] >= (2015, 8, 0, 0) %}
  git.config_set:
  {% else %}
  git.config:
  {% endif %}
    - name: {{ key }}
    - value: "{{ value }}"
    - user: {{ name }}
    {% if grains['saltversioninfo'] >= (2015, 8, 0, 0) %}
    - global: True
    {% else %}
    - is_global: True
    {% endif %}
{% endfor %}
{% endif %}

{% endfor %}


{% for name, user in pillar.get('users', {}).items()
        if user.absent is defined and user.absent %}
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
  user.absent:
    - name: {{ user }}
users_2_{{ users.sudoers_dir }}/{{ user }}:
  file.absent:
    - name: {{ users.sudoers_dir }}/{{ user }}
{% endfor %}

{% for group in pillar.get('absent_groups', []) %}
users_absent_group_{{ group }}:
  group.absent:
    - name: {{ group }}
{% endfor %}
