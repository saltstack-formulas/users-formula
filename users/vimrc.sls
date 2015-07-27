# -*- coding: utf-8 -*-
# vim: ft=sls
{##
    Name: users/vimrc.sls
    Description:
        This file sets up vimrc for users
#}
{% from "users/map.jinja" import users_settings with context %}
include:
  - vim

{% for name, user in users_settings.items() %}
    {% if user.absent is not defined or not user.absent  or user != None  %}
        {% set home = user.get('home', "/home/%s" % name) %}
        {% set manage = user.get('manage_vimrc', False) %}
        {% if 'prime_group' in user and 'name' in user['prime_group'] %}
            {% set user_group = user.prime_group.name %}
        {% else %}
            {% set user_group = name %}
        {% endif %}
        {% if manage %}
            users_{{ name }}_user_vimrc:
              file.managed:
                - name: {{ home }}/.vimrc
                - user: {{ name }}
                - group: {{ user_group }}
                - mode: 644
                - source: 
                  - salt://users/files/vimrc/{{ name }}/vimrc
                  - salt://users/files/vimrc/vimrc
        {% endif %}
    {% endif %}
{% endfor %}
