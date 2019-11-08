
Changelog
=========

`0.48.4 <https://github.com/saltstack-formulas/users-formula/compare/v0.48.3...v0.48.4>`_ (2019-11-08)
----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **vimrc:** ensure ``vimrc`` state runs (\ `a1ef7e5 <https://github.com/saltstack-formulas/users-formula/commit/a1ef7e57d9627f59000962111478d0846ab25d5c>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen:** use ``develop`` image until ``master`` is ready (\ ``amazonlinux``\ ) [skip ci] (\ `852dff2 <https://github.com/saltstack-formulas/users-formula/commit/852dff2aac5216e5ebf3f03cfa8f2559a35bdf9c>`_\ )
* **kitchen+travis+inspec:** add ``vimrc`` suite (\ `a263a62 <https://github.com/saltstack-formulas/users-formula/commit/a263a62e7570d32d4a796538fc1720e20fa008a1>`_\ )

Tests
^^^^^


* **inspec:** add test to check ``.vimrc`` file is generated properly (\ `569e927 <https://github.com/saltstack-formulas/users-formula/commit/569e9276dbeea38f4920596502db75d64abbdc5e>`_\ )
* **pillar:** add test pillar to generate ``.vimrc`` file (\ `86144be <https://github.com/saltstack-formulas/users-formula/commit/86144befb9f98597464d9a10d45d820077a171e4>`_\ )

`0.48.3 <https://github.com/saltstack-formulas/users-formula/compare/v0.48.2...v0.48.3>`_ (2019-11-02)
----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **pillars:** ensure ``addusers`` & ``delusers`` are lists (\ `b31c592 <https://github.com/saltstack-formulas/users-formula/commit/b31c592147a4831f3800b80fa6d11025c5372f4c>`_\ )
* **release.config.js:** use full commit hash in commit link [skip ci] (\ `8df4d39 <https://github.com/saltstack-formulas/users-formula/commit/8df4d39060dfaa1d3e8bce4d2cc7afd9c15d7dfd>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen:** use ``debian-10-master-py3`` instead of ``develop`` [skip ci] (\ `9ee7636 <https://github.com/saltstack-formulas/users-formula/commit/9ee7636477e20ad6597da2dd41375e858f644e4d>`_\ )
* **kitchen+travis:** upgrade matrix after ``2019.2.2`` release [skip ci] (\ `1d9a5ef <https://github.com/saltstack-formulas/users-formula/commit/1d9a5ef5be4bf0c66d6471effa32a2953637b031>`_\ )
* **travis:** update ``salt-lint`` config for ``v0.0.10`` [skip ci] (\ `60ee61d <https://github.com/saltstack-formulas/users-formula/commit/60ee61dd66bb3ab53b5dabb8c252e8725b1f0b04>`_\ )

Documentation
^^^^^^^^^^^^^


* **contributing:** remove to use org-level file instead [skip ci] (\ `7c55ef0 <https://github.com/saltstack-formulas/users-formula/commit/7c55ef0c0dba8fbdb34b3882d2b1f8d78c93720d>`_\ )
* **readme:** update link to ``CONTRIBUTING`` [skip ci] (\ `2a88765 <https://github.com/saltstack-formulas/users-formula/commit/2a887654fcffb2ea6870967007f6d8cd096ed1a0>`_\ )

Performance Improvements
^^^^^^^^^^^^^^^^^^^^^^^^


* **travis:** improve ``salt-lint`` invocation [skip ci] (\ `b45914e <https://github.com/saltstack-formulas/users-formula/commit/b45914e063e3ac7462b31efa0b187d13cb8ee81a>`_\ )

`0.48.2 <https://github.com/saltstack-formulas/users-formula/compare/v0.48.1...v0.48.2>`_ (2019-10-11)
----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **rubocop:** add fixes using ``rubocop --safe-auto-correct`` (\ ` <https://github.com/saltstack-formulas/users-formula/commit/13dd7f9>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* merge travis matrix, add ``salt-lint`` & ``rubocop`` to ``lint`` job (\ ` <https://github.com/saltstack-formulas/users-formula/commit/99136b5>`_\ )
* **travis:** merge ``rubocop`` linter into main ``lint`` job (\ ` <https://github.com/saltstack-formulas/users-formula/commit/96999c2>`_\ )

`0.48.1 <https://github.com/saltstack-formulas/users-formula/compare/v0.48.0...v0.48.1>`_ (2019-10-10)
----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **googleauth.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/users-formula/commit/bb27b94>`_\ )
* **init.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/users-formula/commit/4cec0ef>`_\ )
* **sudo.sls:** fix ``salt-lint`` errors (\ ` <https://github.com/saltstack-formulas/users-formula/commit/560f5e1>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **kitchen:** change ``log_level`` to ``debug`` instead of ``info`` (\ ` <https://github.com/saltstack-formulas/users-formula/commit/1726e0f>`_\ )
* **kitchen:** install required packages to bootstrapped ``opensuse`` [skip ci] (\ ` <https://github.com/saltstack-formulas/users-formula/commit/0ed662d>`_\ )
* **kitchen:** use bootstrapped ``opensuse`` images until ``2019.2.2`` [skip ci] (\ ` <https://github.com/saltstack-formulas/users-formula/commit/f2e1b66>`_\ )
* **platform:** add ``arch-base-latest`` (commented out for now) [skip ci] (\ ` <https://github.com/saltstack-formulas/users-formula/commit/1790bae>`_\ )
* **yamllint:** add rule ``empty-values`` & use new ``yaml-files`` setting (\ ` <https://github.com/saltstack-formulas/users-formula/commit/af2d2c0>`_\ )
* merge travis matrix, add ``salt-lint`` & ``rubocop`` to ``lint`` job (\ ` <https://github.com/saltstack-formulas/users-formula/commit/f17d156>`_\ )
* use ``dist: bionic`` & apply ``opensuse-leap-15`` SCP error workaround (\ ` <https://github.com/saltstack-formulas/users-formula/commit/4d3228b>`_\ )

`0.48.0 <https://github.com/saltstack-formulas/users-formula/compare/v0.47.0...v0.48.0>`_ (2019-08-17)
----------------------------------------------------------------------------------------------------------

Features
^^^^^^^^


* **yamllint:** include for this repo and apply rules throughout (\ `fa6210d <https://github.com/saltstack-formulas/users-formula/commit/fa6210d>`_\ )

`0.47.0 <https://github.com/saltstack-formulas/users-formula/compare/v0.46.1...v0.47.0>`_ (2019-08-07)
----------------------------------------------------------------------------------------------------------

Features
^^^^^^^^


* **semantic-release:** implement for this formula (\ `3bcdc90 <https://github.com/saltstack-formulas/users-formula/commit/3bcdc90>`_\ ), closes `#203 <https://github.com/saltstack-formulas/users-formula/issues/203>`_
