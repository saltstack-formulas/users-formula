
Changelog
=========

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
