{% from "users/map.jinja" import users with context %}
{% set polkitusers = {} %}
{% set polkitusers = {'value': ''} %}

{% for name, user in pillar.get('users', {}).items() %}
  {% if user.absent is not defined or not user.absent %}
    {% if 'polkitadmin' in user and user['polkitadmin'] %}
      {% do polkitusers.update({'value': polkitusers.value + 'unix-user:' + name + ';'}) %}
    {% endif %}
  {% endif %}
{% endfor %}

{% if polkitusers.value != '' %}
users_{{ users.polkit_dir }}/99salt-users-formula.conf:
  file.managed:
    - replace: True
    - onlyif: 'test -d {{ users.polkit_dir }}'
    - name: {{ users.polkit_dir }}/99salt-users-formula.conf
    - contents: |
        ########################################################################
        # File managed by Salt (users-formula).
        # Your changes will be overwritten.
        ########################################################################
        #
        [Configuration]
        AdminIdentities={{ users.polkit_defaults }}{{ polkitusers.value }}
{% else %}
users_{{ users.polkit_dir }}/99salt-users-formula.conf_delete:
  file.absent:
    - name: {{ users.polkit_dir }}/99salt-users-formula.conf
{% endif %}
