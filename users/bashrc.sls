# -*- coding: utf-8 -*-
# vim: ft=sls
{##
  Name: users/bashrc.sls
  Description:
    This file sets up bashrcs
#}

{% from "users/map.jinja" import users_settings with context %}

{% for name, user in users_settings.items() %}
  {% if user.absent is not defined or not user.absent  or user != None  %}
    {% set home = user.get('home', "/home/%s" % name) %}
    {% set manage = user.get('manage_bashrc', False) %}
    {% if 'prime_group' in user and 'name' in user.get('prime_group', []) %}
      {% set user_group = user.prime_group.name %}
    {% else %}
      {% set user_group = name %}
    {% endif %}
    {% if manage %}
      users-{{ name }}-user-bashrc:
        file.managed:
          - name: {{ home }}/.bashrc
          - user: {{ name }}
          - group: {{ user_group }}
          - mode: 644
          - source: 
            - salt://users/files/bashrc/{{ name }}/bashrc
            - salt://users/files/bashrc/bashrc
    {% endif %}
  {% endif %}
{% endfor %}
