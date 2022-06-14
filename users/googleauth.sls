# vim: sts=2 ts=2 sw=2 et ai
{%- from "users/map.jinja" import users with context %}

{%- if not grains['os_family'] in ['Suse'] %}
{%-   if salt['grains.get']('osfinger', '') in ['Amazon Linux-2'] %}
users_epel_repo:
  pkgrepo.managed:
    - name: epel
    - humanname: Extra Packages for Enterprise Linux 7 - $basearch
    - mirrorlist: https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
    - failovermethod: priority
    - require_in:
      - pkg: users_googleauth-package
{%-   endif %}

users_googleauth-package:
  pkg.installed:
    - name: {{ users.googleauth_package }}
    - require:
      - file: {{ users.googleauth_dir }}

users_{{ users.googleauth_dir }}:
  file.directory:
    - name: {{ users.googleauth_dir }}
    - user: root
    - group: {{ users.root_group }}
    - mode: '0700'

{%-   if grains['os_family'] == 'RedHat' and "selinux" in grains and grains.selinux.enabled %}
policycoreutils-package:
  pkg.installed:
    - pkgs:
      - policycoreutils
{%-     if grains['osmajorrelease']|int <= 7 %}
      - policycoreutils-python
{%-     else %}
      - policycoreutils-python-utils
{%-     endif %}
users_googleauth_selinux_present:
  selinux.fcontext_policy_present:
    - name: "{{ users.googleauth_dir }}(/.*)?"
    - filetype: 'a'
    - sel_user: unconfined_u
    - sel_type: ssh_home_t
    - sel_level: s0
    - require:
        - pkg: policycoreutils-package
{%-   endif %}

{%-   for name, user in pillar.get('users', {}).items() if user.absent is not defined or not user.absent %}
{%-     if 'google_auth' in user %}
{%-       for svc in user['google_auth'] %}
{%-         if user.get('google_2fa', True) %}
{%-           set repl = '{0}       {1}   {2} {3} {4}{5}/{6}_{7} {8}'.format(
                             'auth',
                             '[success=done new_authtok_reqd=done default=die]',
                             'pam_google_authenticator.so',
                             'user=root',
                             'secret=',
                             users.googleauth_dir,
                             '${USER}',
                             svc,
                             'echo_verification_code',
                         ) %}
users_googleauth-pam-{{ svc }}-{{ name }}:
  file.replace:
    - name: /etc/pam.d/{{ svc }}
{%- if grains['os_family'] == 'RedHat' %}
    - pattern: '^(auth[ \t]*substack[ \t]*password-auth)'
{%- else %}
    - pattern: '^(@include[ \t]*common-auth)'
{%- endif %}
    - repl: '{{ repl }}\n\1'
    - unless: grep pam_google_authenticator.so /etc/pam.d/{{ svc }}
    - backup: .bak
{%-         endif %}
{%-       endfor %}
{%-     endif %}
{%-   endfor %}

{%-   if grains['os_family'] == 'RedHat' and "selinux" in grains and grains.selinux.enabled %}
users_googleauth_selinux_applied:
  selinux.fcontext_policy_applied:
    - name: {{ users.googleauth_dir }}
{%-   endif %}

sshd:
  service.running:
    - watch:
      - file: /etc/ssh/sshd_config

sshd_config:
  file.replace:
    - name: /etc/ssh/sshd_config
    - pattern: '^(ChallengeResponseAuthentication|KbdInteractiveAuthentication).*'
    - repl: '\1 yes'

{%- endif %}
