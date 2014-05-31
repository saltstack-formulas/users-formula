# vim: sts=2 ts=2 sw=2 et ai
{% from "users/map.jinja" import users with context %}

# Ensure availability of bash
bash-package:
  pkg.installed:
    - name: {{ users.bash_package }}

sudo-group:
  group.present:
    - name: sudo
    - system: True

sudo-package:
  pkg.installed:
    - name: {{ users.sudo_package }}
    - require:
      - group: sudo-group
      - file: {{ users.sudoers_dir }} 

{{ users.sudoers_dir }}:
  file:
    - directory

sudoer-defaults:
    file.append:
        - name: {{ users.sudoers_file }} 
        - require:
          - pkg: sudo-package
        - text:
          - Defaults   env_reset
          - Defaults   secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
          - '#includedir {{ users.sudoers_dir }}'
