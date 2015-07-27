# -*- coding: utf-8 -*-
# vim: ft=sls
{##
  Name: users/bashrc.sls
  Description:
    This file sets up bashrcs
#}

{% from "users/map.jinja" import users_settings with context %}

users-googleauth-package:
  file.directory:
    - name: {{ users_settings.googleauth_dir }}
    - user: root
    - group: {{ users_settings.root_group }}
    - mode: 600
  pkg.installed:
    - name: {{ users_settings.googleauth_package }}
{% for name, user in users_settings.items() %}
  {% if user.absent is not defined or not user.absent  or user != None  %}
    {% if 'google_auth' in user %}
      {% for svc in user.get('google_auth') %}
        {% if user.get('google_2fa', True) %}
users_googleauth-pam-{{ svc }}-{{ name }}:
  file.replace:
    - name: /etc/pam.d/{{ svc }}
    - pattern: "^@include common-auth"
    - repl: "auth       [success=done new_authtok_reqd=done default=die]   pam_google_authenticator.so user=root secret={{ users_settings.googleauth_dir }}/${USER}_{{ svc }} echo_verification_code\n@include common-auth"
    - unless: grep pam_google_authenticator.so /etc/pam.d/{{ svc }}
    - backup: .bak
        {% endif %}
      {% endfor %}
    {% endif %}
  {% endif %}
{% endfor %}
