# vim: sts=2 ts=2 sw=2 et ai
{% from "users/map.jinja" import users with context %}
{% set used_sudo = False %}

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
{{ name }}_{{ group }}_group:
  group:
    - name: {{ group }}
    - present
{% endfor %}

{{ name }}_user:
  file.directory:
    - name: {{ home }}
    - user: {{ name }}
    - group: {{ user_group }}
    - mode: {{ user.get('user_dir_mode', '0750') }}
    - require:
      - user: {{ name }}
      - group: {{ user_group }}
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
    - shell: {{ users.get('visudo_shell', '/bin/bash') }}
    {% if 'uid' in user -%}
    - uid: {{ user['uid'] }}
    {% endif -%}
    {% if 'password' in user -%}
    - password: {{ user['password'] }}
    {% endif -%}
    {% if 'prime_group' in user and 'gid' in user['prime_group'] -%}
    - gid: {{ user['prime_group']['gid'] }}
    {% else -%}
    - gid_from_name: True
    {% endif -%}
    {% if 'fullname' in user %}
    - fullname: {{ user['fullname'] }}
    {% endif -%}
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

user_keydir_{{ name }}:
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
user_{{ name }}_private_key:
  file.managed:
    - name: {{ user.get('home', '/home/{0}'.format(name)) }}/.ssh/{{ key_type }}
    - user: {{ name }}
    - group: {{ user_group }}
    - mode: 600
    - show_diff: False
    - contents_pillar: users:{{ name }}:ssh_keys:privkey
    - require:
      - user: {{ name }}_user
      {% for group in user.get('groups', []) %}
      - group: {{ name }}_{{ group }}_group
      {% endfor %}
user_{{ name }}_public_key:
  file.managed:
    - name: {{ user.get('home', '/home/{0}'.format(name)) }}/.ssh/{{ key_type }}.pub
    - user: {{ name }}
    - group: {{ user_group }}
    - mode: 644
    - show_diff: False
    - contents_pillar: users:{{ name }}:ssh_keys:pubkey
    - require:
      - user: {{ name }}_user
      {% for group in user.get('groups', []) %}
      - group: {{ name }}_{{ group }}_group
      {% endfor %}
  {% endif %}


{% if 'ssh_auth' in user %}
{% for auth in user['ssh_auth'] %}
ssh_auth_{{ name }}_{{ loop.index0 }}:
  ssh_auth.present:
    - user: {{ name }}
    - name: {{ auth }}
    - require:
        - file: {{ name }}_user
        - user: {{ name }}_user
{% endfor %}
{% endif %}

{% if 'ssh_auth.absent' in user %}
{% for auth in user['ssh_auth.absent'] %}
ssh_auth_delete_{{ name }}_{{ loop.index0 }}:
  ssh_auth.absent:
    - user: {{ name }}
    - name: {{ auth }}
    - require:
        - file: {{ name }}_user
        - user: {{ name }}_user
{% endfor %}
{% endif %}

{% if 'sudouser' in user and user['sudouser'] %}
{% if not used_sudo %}
{% set used_sudo = True %}
include:
  - users.sudo
{% endif %}

sudoer-{{ name }}:
  file.managed:
    - name: {{ users.sudoers_dir }}{{ name }}
    - user: root
    - group: {{ users.root_group }} 
    - mode: '0440'
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
      - file: {{ users.sudoers_dir }}{{ name }}
{% endfor %}

{{ users.sudoers_dir }}{{ name }}:
  file.managed:
    - contents: |
      {%- for rule in user['sudo_rules'] %}
        {{ name }} {{ rule }}
      {%- endfor %}
    - require:
      - file: sudoer-defaults
      - file: sudoer-{{ name }}
{% endif %}
{% else %}
{{ users.sudoers_dir }}{{ name }}:
  file.absent:
    - name: {{ users.sudoers_dir }}{{ name }}
{% endif %}

{% endfor %}

{% for name, user in pillar.get('users', {}).items() if user.absent is defined and user.absent %}
{{ name }}:
{% if 'purge' in user or 'force' in user %}
  user.absent:
    {% if 'purge' in user %}
    - purge: {{ user['purge'] }}
    {% endif %}
    {% if 'force' in user %}
    - force: {{ user['force'] }}
    {% endif %}
{% else %}
  user.absent
{% endif -%}
{{ users.sudoers_dir }}{{ name }}:
  file.absent:
    - name: {{ users.sudoers_dir }}{{ name }}
{% endfor %}

{% for user in pillar.get('absent_users', []) %}
{{ user }}:
  user.absent
{{ users.sudoers_dir }}{{ user }}:
  file.absent:
    - name: {{ users.sudoers_dir }}{{ user }}
{% endfor %}

{% for group in pillar.get('absent_groups', []) %}
{{ group }}:
  group.absent
{% endfor %}

