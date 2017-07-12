=====
users
=====

Formula to configure users via pillar.


.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``users``
---------

Configures a user's home directory, group, the user itself, secondary groups,
and associated keys. Also configures sudo access, and absent users.

``users.sudo``
--------------

Ensures the sudo group exists, the sudo package is installed and the sudo file
is configured.

``users.bashrc``
----------------

Ensures the bashrc file exists in the users home directory. Sets 'manage_bashrc:
True' in pillar per user. Defaults to False.

``users.profile``
----------------

Ensures the profile file exists in the users home directory. Sets 'manage_profile:
True' in pillar per user. Defaults to False.

``users.vimrc``
---------------

Ensures the vimrc file exists in the users home directory. Sets 'manage_vimrc:
True' in pillar per user. Defaults to False.
This depends on the vim-formula to be installed.

``users.user_files``
---------------

Permits the abitrary management of files. See pillar.example for configuration details.

Overriding default values
=========================

In order to separate actual user account definitions from configuration the pillar ``users-formula`` was introduced:

.. code-block:: yaml

    users:
      myuser:
        # stuff

    users-formula:
      lookup:
        root_group: toor
        shell: '/bin/zsh'
