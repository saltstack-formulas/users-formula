{% from "users/map.jinja" import users with context %}
include:
  - users

extend:
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
  users_{{ name }}_user:
    file.managed:
      - name: {{ home }}/.bashrc
      - owner: {{ name }}
      - group: {{ user_group }}
      - mode: 644
      - source: 
        - salt://users/files/bashrc/{{ name }}/bashrc
        - salt://users/files/bashrc/bashrc
{% endfor %}
