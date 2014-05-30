# vim: sts=2 ts=2 sw=2 et ai
{% from "users/map.jinja" import users with context %}

#Support bash in FreeBSD
bash:
  pkg:
    - installed

sudo:
  group:
    - present
    - system: True
  pkg:
    - installed
    - require:
      - group: sudo
      - file: {{ users.sudoers_dir }} 

{{ users.sudoers_dir }}:
  file:
    - directory

sudoer-defaults:
    file.append:
        - name: {{ users.sudoers_file }} 
        - require:
          - pkg: sudo
        - text:
          - Defaults   env_reset
          - Defaults   secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
          - '#includedir {{ users.sudoers_dir }}'
