# Changelog

## [0.48.1](https://github.com/saltstack-formulas/users-formula/compare/v0.48.0...v0.48.1) (2019-10-10)


### Bug Fixes

* **googleauth.sls:** fix `salt-lint` errors ([](https://github.com/saltstack-formulas/users-formula/commit/bb27b94))
* **init.sls:** fix `salt-lint` errors ([](https://github.com/saltstack-formulas/users-formula/commit/4cec0ef))
* **sudo.sls:** fix `salt-lint` errors ([](https://github.com/saltstack-formulas/users-formula/commit/560f5e1))


### Continuous Integration

* **kitchen:** change `log_level` to `debug` instead of `info` ([](https://github.com/saltstack-formulas/users-formula/commit/1726e0f))
* **kitchen:** install required packages to bootstrapped `opensuse` [skip ci] ([](https://github.com/saltstack-formulas/users-formula/commit/0ed662d))
* **kitchen:** use bootstrapped `opensuse` images until `2019.2.2` [skip ci] ([](https://github.com/saltstack-formulas/users-formula/commit/f2e1b66))
* **platform:** add `arch-base-latest` (commented out for now) [skip ci] ([](https://github.com/saltstack-formulas/users-formula/commit/1790bae))
* **yamllint:** add rule `empty-values` & use new `yaml-files` setting ([](https://github.com/saltstack-formulas/users-formula/commit/af2d2c0))
* merge travis matrix, add `salt-lint` & `rubocop` to `lint` job ([](https://github.com/saltstack-formulas/users-formula/commit/f17d156))
* use `dist: bionic` & apply `opensuse-leap-15` SCP error workaround ([](https://github.com/saltstack-formulas/users-formula/commit/4d3228b))

# [0.48.0](https://github.com/saltstack-formulas/users-formula/compare/v0.47.0...v0.48.0) (2019-08-17)


### Features

* **yamllint:** include for this repo and apply rules throughout ([fa6210d](https://github.com/saltstack-formulas/users-formula/commit/fa6210d))

# [0.47.0](https://github.com/saltstack-formulas/users-formula/compare/v0.46.1...v0.47.0) (2019-08-07)


### Features

* **semantic-release:** implement for this formula ([3bcdc90](https://github.com/saltstack-formulas/users-formula/commit/3bcdc90)), closes [#203](https://github.com/saltstack-formulas/users-formula/issues/203)
