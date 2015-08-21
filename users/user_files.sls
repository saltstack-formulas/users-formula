{% from "users/map.jinja" import users with context -%}

include:
  - users

{%- for username, user in pillar.get('users', {}).items() if (user.absent is not defined or not user.absent) -%}
{%- set user_files = pillar.get('users:' + username + ':user_files', {'enabled': False}) -%}

{%- if user_files.enabled -%}
{%- set user_group = pillar.get(('users:' + username + ':prime_group:name'), username) -%}

{%- if user_files.source is defined -%}
{%- if user_files.source.startswith('salt://') -%}
{%- set file_source = user_files.source -%}
{%- else -%}
{%- set file_source = ('salt://' + user.user_files.source) -%}
{%- endif -%}
{%- else -%}
{%- set file_source = ('salt://users/files/user/' + username) -%}
{%- endif -%}

users_userfiles_{{ username }}_recursive:
  file.recurse:
    - name: {{ user.home }}
    - source: {{ file_source }}
    - user: {{ username }}
    - group: {{ user_group }}
    - clean: False
    - include_empty: True
    - keep_symlinks: True
    - require:
      - user: users_{{ username }}_user
      - file: users_{{ username }}_user

{% endif -%}
{% endfor -%}
