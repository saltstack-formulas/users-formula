users
=====

Configure users via pillar

Using this state, you can configure users entirely via pillar:

    users:
      auser:
        sudouser: True
        shell: /bin/zsh
        groups:
          - admin
        ssh_auth:
          - ssh-rsa PUBLICKEYKEYKEY