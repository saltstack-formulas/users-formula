# -*- coding: utf-8 -*-
# vim: ft=sls
{##
  Name: users/sudo.sls
  Description:
    This file sets up sudoers
#}

{% from "users/map.jinja" import users_settings with context %}

# Ensure availability of bash
users-bashpackage-group-dir:
  pkg.installed:
    - name: {{ users_settings.bash_package }}
  group.present:
    - name: sudo
    - system: True
  file.directory:
    - name: {{ users_settings.sudoers_dir }}

users-sudo-package:
  pkg.installed:
    - name: {{ users_settings.sudo_package }}
    - require:
      - group: users_sudo-group
      - file: {{ users_settings.sudoers_dir }} 
  file.append:
    - name: {{ users_settings.sudoers_file }} 
    - text:
      - Defaults   env_reset
      - Defaults   secure_path="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
      - '#includedir {{ users_settings.sudoers_dir }}'
{% for name, user in users_settings.items() %}
  {% if user.absent is not defined or not user.absent  or user != None  %}
    {% if 'sudouser' in user and user['sudouser'] %}
users-sudoer-{{ name }}:
  file.managed:
    - name: {{ users.sudoers_dir }}/{{ name }}
    - user: root
    - group: {{ users.root_group }}
    - mode: '0440'
      {% if 'sudo_rules' in user or 'sudo_defaults' in user %}
        {% if 'sudo_rules' in user %}
          {% for rule in user['sudo_rules'] %}
"validate {{ name }} sudo rule {{ loop.index0 }} {{ name }} {{ rule }}":
  cmd.run:
    - name: 'visudo -cf - <<<"$rule" | { read output; if [[ $output != "stdin: parsed OK" ]] ; then echo $output ; fi }'
    - stateful: True
    - shell: {{ users.visudo_shell }}
    - env:
      # Specify the rule via an env var to avoid shell quoting issues.
      - rule: "{{ name }} {{ rule }}"
          {% endfor %}
        {% endif %}
        {% if 'sudo_defaults' in user %}
          {% for entry in user['sudo_defaults'] %}
"validate {{ name }} sudo Defaults {{ loop.index0 }} {{ name }} {{ entry }}":
  cmd.run:
    - name: 'visudo -cf - <<<"$rule" | { read output; if [[ $output != "stdin: parsed OK" ]] ; then echo $output ; fi }'
    - stateful: True
    - shell: {{ users.visudo_shell }}
    - env:
      # Specify the rule via an env var to avoid shell quoting issues.
      - rule: "Defaults:{{ name }} {{ entry }}"
          {% endfor %}
        {% endif %}

users_{{ users.sudoers_dir }}/{{ name }}:
  file.managed:
    - name: {{ users.sudoers_dir }}/{{ name }}
    - contents: |
      {%- if 'sudo_defaults' in user %}
      {%- for entry in user['sudo_defaults'] %}
        Defaults:{{ name }} {{ entry }}
      {%- endfor %}
      {%- endif %}
      {%- if 'sudo_rules' in user %}
      {%- for rule in user['sudo_rules'] %}
        {{ name }} {{ rule }}
      {%- endfor %}
      {%- endif %}
  {% endif %}
  {% else %}
users_{{ users.sudoers_dir }}/{{ name }}:
  file.absent:
    - name: {{ users.sudoers_dir }}/{{ name }}
    {% endif %}
  {% endif %}
{% endfor %}
