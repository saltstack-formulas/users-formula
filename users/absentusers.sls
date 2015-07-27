# -*- coding: utf-8 -*-
# vim: ft=sls
{##
  Name: users/absentusers.sls
  Description:
    This file removes users
#}

{% from "users/map.jinja" import users_settings with context %}

{% for name, user in users_settings.items() %}
  {% if user.absent is defined and user.absent %}
users-absent_user-{{ name }}:
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
users_{{ users_settings.sudoers_dir }}/{{ name }}:
  file.absent:
    - name: {{ users_settings.sudoers_dir }}/{{ name }}
  {% endif %}
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
