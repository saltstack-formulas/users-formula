# -*- coding: utf-8 -*-
# vim: ft=sls
{##
  Name: users/init.sls
  Description:
    This file sets up users, sudo, google auth, flight control, bashrc, vimrc
#}
include:
  - users.adduser
  - users.sudo
  - users.googleauth
  - users.absentusers
