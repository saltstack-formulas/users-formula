# vim: sts=2 ts=2 sw=2 et ai
{% from "users/map.jinja" import users with context %}

googleauth-package:
  pkg.installed:
    - name: {{ users.googleauth_package }}
    - require:
      - file: {{ users.googleauth_dir }} 

{{ users.googleauth_dir }}:
  file:
    - directory
    - user: root
    - group: {{ users.root_group }}
    - mode: 600
