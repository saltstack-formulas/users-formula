{% from "users/map.jinja" import users with context -%}

include:
  - users

{% set userfile_dirs = salt['cp.list_master_dirs'](prefix='users/files/user/') -%}
{%- for username, user in salt['pillar.get']('users', {}).items() if (user.absent is not defined or not user.absent) -%}
{%- set current = salt.user.info(username) -%}
{%- set user_files = salt['pillar.get'](('users:' ~ username ~ ':user_files'), {'enabled': False}) -%}
{%- set user_group = salt['pillar.get'](('users:' ~ username ~ ':prime_group:name'), username) -%}
{%- set user_home = salt['pillar.get'](('users:' ~ username ~ ':home'), current.get('home', '/home/' ~ username )) -%}
{%- set user_files_template = salt['pillar.get'](('users:' ~ username ~ ':user_files:template'), None) -%}
{%- set user_files_file_mode = salt['pillar.get'](('users:' ~ username ~ ':user_files:file_mode'), False) -%}
{%- set user_files_dir_mode = salt['pillar.get'](('users:' ~ username ~ ':user_files:dir_mode'), False) -%}
{%- set user_files_sym_mode = salt['pillar.get'](('users:' ~ username ~ ':user_files:sym_mode'), False) -%}
{%- set user_files_exclude_pat = salt['pillar.get'](('users:' ~ username ~ ':user_files:exclude_pat'), False) -%}
{%- if user_files.enabled -%}

{%- if user_files.source is defined -%}
    {%- if user_files.source.startswith('salt://') -%}
        {%- set file_source = user_files.source -%}
    {%- else -%}
        {%- set file_source = ('salt://' ~ user.user_files.source) -%}
    {%- endif -%}
    {%- set skip_user = False -%}
{%- else -%}
    {%- if ('users/files/user/' ~ username) in userfile_dirs -%}
        {%- set file_source = ('salt://users/files/user/' ~ username) -%}
        {%- set skip_user = False -%}
    {%- else -%}
        {%- set skip_user = True -%}
    {%- endif -%}
{%- endif -%}

{%- if not skip_user %}
users_userfiles_{{ username }}_recursive:
  file.recurse:
    - name: {{ user_home }}
    - source: {{ file_source }}
    - user: {{ username }}
    - group: {{ user_group }}
    {% if user_files_template -%}
    - template: {{ user_files_template }}
    {% endif -%}
    - clean: False
    {% if user_files_file_mode -%}
    - file_mode: {{ user_files_file_mode }}
    {% endif -%}
    {% if user_files_dir_mode -%}
    - dir_mode: {{ user_files_dir_mode }}
    {% endif -%}
    {% if user_files_sym_mode -%}
    - sym_mode: {{ user_files_sym_mode }}
    {% endif -%}
    {% if user_files_exclude_pat -%}
    - exclude_pat: "{{ user_files_exclude_pat }}"
    {% endif -%}
    - include_empty: True
    - keep_symlinks: True
    - require:
      - user: users_{{ username }}_user
      - file: users_{{ username }}_user
{% endif -%}

{%- endif -%}
{%- endfor -%}
