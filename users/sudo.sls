sudo:
  group:
    - present
    - system: True
  pkg:
    - installed
    - require:
      - group: sudo
      - file: /etc/sudoers.d

/etc/sudoers.d:
  file:
    - directory

sudoer-defaults:
    file.append:
        - name: /etc/sudoers
        - require:
          - pkg: sudo
        - text:
          - Defaults   env_reset
          - Defaults   secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
