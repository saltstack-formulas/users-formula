# -*- coding: utf-8 -*-
# vim: ft=sls
{##
  Name: users/addusers.sls
  Description:
    This file removes users
#}

{% from "users/map.jinja" import users_settings with context %}

{% for name, user in users_settings.items() %}
  {% if user.absent is not defined or not user.absent  or user != None  %}
    {% set home = user.get('home', "/home/%s" % name) %}
    {%- if 'prime_group' in user and 'name' in user['prime_group'] %}
      {%- set user_group = user.prime_group.name -%}
    {%- else -%}
      {%- set user_group = name -%}
    {%- endif %}
    {% for group in user.get('groups', []) %}
users-{{ name }}-{{ group }}-group:
  group:
    - name: {{ group }}
    - present
    {% endfor %}
users-{{ name }}-user:
  {% if user.get('createhome', True) %}
  file.directory:
    - name: {{ home }}
    - user: {{ name }}
    - group: {{ user_group }}
    - mode: {{ user.get('user_dir_mode', '0750') }}
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
    {% if 'enforce_password' in user -%}
    - enforce_password: {{ user['enforce_password'] }}
    {% endif -%}
    {% if user.get('system', False) -%}
    - system: True
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
users_user_{{ name }}_public_key:
  file.managed:
    - name: {{ user.get('home', '/home/{0}'.format(name)) }}/.ssh/{{ key_type }}.pub
    - user: {{ name }}
    - group: {{ user_group }}
    - mode: 644
    - show_diff: False
    - contents_pillar: users:{{ name }}:ssh_keys:pubkey

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
      {% endfor %}
    {% endif %}

    {% if 'ssh_keys_pillar' in user %}
      {% for key_name, pillar_name in user['ssh_keys_pillar'].items() %}
user_ssh_keys_files_{{ name }}_{{ key_name }}_private_key:
  file.managed:
    - name: {{ user.get('home', '/home/{0}'.format(name)) }}/.ssh/{{ key_name }}
    - user: {{ name }}
    - group: {{ user_group }}
    - mode: 600
    - show_diff: False
    - contents_pillar: {{ pillar_name }}:{{ key_name }}:privkey
user_ssh_keys_files_{{ name }}_{{ key_name }}_public_key:
  file.managed:
    - name: {{ user.get('home', '/home/{0}'.format(name)) }}/.ssh/{{ key_name }}.pub
    - user: {{ name }}
    - group: {{ user_group }}
    - mode: 644
    - show_diff: False
    - contents_pillar: {{ pillar_name }}:{{ key_name }}:pubkey
      {% endfor %}
    {% endif %}

    {% if 'ssh_auth_sources' in user %}
      {% for pubkey_file in user['ssh_auth_sources'] %}
users_ssh_auth_source_{{ name }}_{{ loop.index0 }}:
  ssh_auth.present:
    - user: {{ name }}
    - source: {{ pubkey_file }}
      {% endfor %}
    {% endif %}

    {% if 'ssh_auth.absent' in user %}
      {% for auth in user['ssh_auth.absent'] %}
users_ssh_auth_delete_{{ name }}_{{ loop.index0 }}:
  ssh_auth.absent:
    - user: {{ name }}
    - name: {{ auth }}
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
  {%- endif %}
{% endfor %}
