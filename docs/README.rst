.. _readme:

users
=====

|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/users-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/users-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

Formula to configure users via pillar.

.. contents:: **Table of Contents**

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see `How to contribute <https://github.com/saltstack-formulas/.github/blob/master/CONTRIBUTING.rst>`_ for more details.

Available states
----------------

.. contents::
   :local:

``users``
^^^^^^^^^

Configures a user's home directory, group, the user itself, secondary groups,
and associated keys. Also configures sudo access, and absent users.

``users.sudo``
^^^^^^^^^^^^^^

Ensures the sudo group exists, the sudo package is installed and the sudo file
is configured.

``users.bashrc``
^^^^^^^^^^^^^^^^

Ensures the bashrc file exists in the users home directory. Sets 'manage_bashrc:
True' in pillar per user. Defaults to False.

``users.profile``
^^^^^^^^^^^^^^^^

Ensures the profile file exists in the users home directory. Sets 'manage_profile:
True' in pillar per user. Defaults to False.

``users.vimrc``
^^^^^^^^^^^^^^^

Ensures the vimrc file exists in the users home directory. Sets 'manage_vimrc:
True' in pillar per user. Defaults to False.
This depends on the vim-formula being available and pillar `users:use_vim_formula: True`.

``users.user_files``
^^^^^^^^^^^^^^^^^^^^

Permits the abitrary management of files. See pillar.example for configuration details.

Overriding default values
-------------------------

In order to separate actual user account definitions from configuration the pillar ``users-formula`` was introduced:

.. code-block:: yaml

    users:
      myuser:
        # stuff

    users-formula:
      lookup:
        root_group: toor
        shell: '/bin/zsh'

Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``template`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.
