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

Configure a user's home directory, group, the user itself, secondary groups,
and associated keys. Also configures sudo access, and absent users.

``users.sudo``
--------------

Ensures the sudo group exists, the sudo package is installed and the sudo file
is configured.
