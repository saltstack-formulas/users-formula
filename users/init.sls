include:
  - users.sudo

{% for name, user in pillar.get('users', {}).items() %}
{% if user == None %}
{% set user = {} %}
{% endif %}
{% set home = user.get('home', "/home/%s" % name) %}

{% for group in user.get('groups', []) %}
{{ group }}_group:
  group:
    - name: {{ group }}
    - present
{% endfor %}

{{ name }}_user:
  file.directory:
    - name: {{ home }}
    - user: {{ name }}
    - group: {{ name }}
    - mode: 0755
    - require:
      - user: {{ name }}
      - group: {{ name }}
  group.present:
    - name: {{ name }}
  user.present:
    - name: {{ name }}
    - home: {{ home }}
    - shell: {{ user.get('shell', '/bin/bash') }}
    {% if 'uid' in user -%}
    - uid: {{ user['uid'] }}
    {% endif %}
    - gid_from_name: True
    {% if 'fullname' in user %}
    - fullname: {{ user['fullname'] }}
    {% endif %}
    - groups:
        - {{ name }}
      {% for group in user.get('groups', []) %}
        - {{ group }}
      {% endfor %}
    - require:
        - group: {{ name }}
      {% for group in user.get('groups', []) %}
        - group: {{ group }}
      {% endfor %}

user_keydir_{{ name }}:
  file.directory:
    - name: {{ user.get('home', '/home/{0}'.format(name)) }}/.ssh
    - user: {{ name }}
    - group: {{ name }}
    - makedirs: True
    - mode: 744
    - require:
      - user: {{ name }}
      - group: {{ name }}
      {% for group in user.get('groups', []) %}
      - group: {{ group }}
      {% endfor %}

  {% if 'privkey' in user %}
user_{{ name }}_private_key:
  file.managed:
    - name: {{ user.get('home', '/home/{0}'.format(name)) }}/.ssh/id_rsa
    - user: {{ name }}
    - group: {{ name }}
    - mode: 600
    - source: salt://keys/{{ user['privkey'] }}
    - require:
      - user: {{ name }}_user
      {% for group in user.get('groups', []) %}
      - group: {{ group }}_group
      {% endfor %}
user_{{ name }}_public_key:
  file.managed:
    - name: {{ user.get('home', '/home/{0}'.format(name)) }}/.ssh/id_rsa.pub
    - user: {{ name }}
    - group: {{ name }}
    - mode: 644
    - source: salt://keys/{{ user['privkey'] }}.pub
    - require:
      - user: {{ name }}_user
      {% for group in user.get('groups', []) %}
      - group: {{ group }}_group
      {% endfor %}
  {% endif %}


  {% if 'ssh_auth' in user %}
  {% for auth in user['ssh_auth'] %}
ssh_auth_{{ name }}_{{ loop.index0 }}:
  ssh_auth.present:
    - user: {{ name }}
    - name: {{ auth }}
    - require:
        - file: {{ name }}_user
        - user: {{ name }}_user
{% endfor %}
{% endif %}

{% if 'sudouser' in user %}
sudoer-{{ name }}:
    file.append:
        - name: /etc/sudoers
        - text:
          - "{{ name }}    ALL=(ALL)  NOPASSWD: ALL"
        - require:
          - file: sudoer-defaults

{% endif %}

{% endfor %}

{% for user in pillar.get('absent_users', []) %}
{{ user }}:
  user.absent
{% endfor %}
