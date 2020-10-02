# Changelog

## [0.48.6](https://github.com/saltstack-formulas/users-formula/compare/v0.48.5...v0.48.6) (2020-10-02)


### Styles

* quote numbers and file modes ([db30289](https://github.com/saltstack-formulas/users-formula/commit/db302890460c6ac079bacb34a5c4f0b304fffe69))

## [0.48.5](https://github.com/saltstack-formulas/users-formula/compare/v0.48.4...v0.48.5) (2020-07-25)


### Bug Fixes

* **macos:** gid must be numeric on macos ([9517e4b](https://github.com/saltstack-formulas/users-formula/commit/9517e4b069d130b442562ed28fa9641cfebeb698))


### Continuous Integration

* **gemfile:** restrict `train` gem version until upstream fix [skip ci] ([40f8e2d](https://github.com/saltstack-formulas/users-formula/commit/40f8e2d181f6ab345d205da95013bab8370afaf0))
* **gemfile.lock:** add to repo with updated `Gemfile` [skip ci] ([ad7e8f7](https://github.com/saltstack-formulas/users-formula/commit/ad7e8f7cab43fb01b8a3a6651e1adf96241e63cf))
* **kitchen:** avoid using bootstrap for `master` instances [skip ci] ([4441c59](https://github.com/saltstack-formulas/users-formula/commit/4441c597bd6425b5e5d79ced23d2c43790ec184e))
* **kitchen:** use `saltimages` Docker Hub where available [skip ci] ([c12272e](https://github.com/saltstack-formulas/users-formula/commit/c12272eaae0440808f8c00ac5ac2f66ea5174f17))
* **kitchen+travis:** remove `master-py2-arch-base-latest` [skip ci] ([892868f](https://github.com/saltstack-formulas/users-formula/commit/892868f3b52dfb1f3aaa2760bf37635b94eb2d29))
* **travis:** add notifications => zulip [skip ci] ([628a430](https://github.com/saltstack-formulas/users-formula/commit/628a4306814bb69af750f35c7fa077662033a19b))
* **travis:** apply changes from build config validation [skip ci] ([9f76672](https://github.com/saltstack-formulas/users-formula/commit/9f766728d4f8c44ed791dcc28e049c890331746d))
* **travis:** opt-in to `dpl v2` to complete build config validation [skip ci] ([9a983a4](https://github.com/saltstack-formulas/users-formula/commit/9a983a4c2aee5e097f16378885ab7d6cad490509))
* **travis:** quote pathspecs used with `git ls-files` [skip ci] ([f9f8f13](https://github.com/saltstack-formulas/users-formula/commit/f9f8f13693307695d6b6d8ca0aa2a9dcaa82c0c0))
* **travis:** run `shellcheck` during lint job [skip ci] ([e09c822](https://github.com/saltstack-formulas/users-formula/commit/e09c8221657338baabf73c97902174513009f63b))
* **travis:** use `major.minor` for `semantic-release` version [skip ci] ([0afebc6](https://github.com/saltstack-formulas/users-formula/commit/0afebc6fc36e1df818640bdddf6136841611243e))
* **travis:** use build config validation (beta) [skip ci] ([0ddb90e](https://github.com/saltstack-formulas/users-formula/commit/0ddb90e6b546215e4de07b8257a89fc874f80d8b))
* **workflows/commitlint:** add to repo [skip ci] ([7419dda](https://github.com/saltstack-formulas/users-formula/commit/7419dda3a4791044b8dd637cfcb8daedc637a2a8))

## [0.48.4](https://github.com/saltstack-formulas/users-formula/compare/v0.48.3...v0.48.4) (2019-11-08)


### Bug Fixes

* **vimrc:** ensure `vimrc` state runs ([a1ef7e5](https://github.com/saltstack-formulas/users-formula/commit/a1ef7e57d9627f59000962111478d0846ab25d5c))


### Continuous Integration

* **kitchen:** use `develop` image until `master` is ready (`amazonlinux`) [skip ci] ([852dff2](https://github.com/saltstack-formulas/users-formula/commit/852dff2aac5216e5ebf3f03cfa8f2559a35bdf9c))
* **kitchen+travis+inspec:** add `vimrc` suite ([a263a62](https://github.com/saltstack-formulas/users-formula/commit/a263a62e7570d32d4a796538fc1720e20fa008a1))


### Tests

* **inspec:** add test to check `.vimrc` file is generated properly ([569e927](https://github.com/saltstack-formulas/users-formula/commit/569e9276dbeea38f4920596502db75d64abbdc5e))
* **pillar:** add test pillar to generate `.vimrc` file ([86144be](https://github.com/saltstack-formulas/users-formula/commit/86144befb9f98597464d9a10d45d820077a171e4))

## [0.48.3](https://github.com/saltstack-formulas/users-formula/compare/v0.48.2...v0.48.3) (2019-11-02)


### Bug Fixes

* **pillars:** ensure `addusers` & `delusers` are lists ([b31c592](https://github.com/saltstack-formulas/users-formula/commit/b31c592147a4831f3800b80fa6d11025c5372f4c))
* **release.config.js:** use full commit hash in commit link [skip ci] ([8df4d39](https://github.com/saltstack-formulas/users-formula/commit/8df4d39060dfaa1d3e8bce4d2cc7afd9c15d7dfd))


### Continuous Integration

* **kitchen:** use `debian-10-master-py3` instead of `develop` [skip ci] ([9ee7636](https://github.com/saltstack-formulas/users-formula/commit/9ee7636477e20ad6597da2dd41375e858f644e4d))
* **kitchen+travis:** upgrade matrix after `2019.2.2` release [skip ci] ([1d9a5ef](https://github.com/saltstack-formulas/users-formula/commit/1d9a5ef5be4bf0c66d6471effa32a2953637b031))
* **travis:** update `salt-lint` config for `v0.0.10` [skip ci] ([60ee61d](https://github.com/saltstack-formulas/users-formula/commit/60ee61dd66bb3ab53b5dabb8c252e8725b1f0b04))


### Documentation

* **contributing:** remove to use org-level file instead [skip ci] ([7c55ef0](https://github.com/saltstack-formulas/users-formula/commit/7c55ef0c0dba8fbdb34b3882d2b1f8d78c93720d))
* **readme:** update link to `CONTRIBUTING` [skip ci] ([2a88765](https://github.com/saltstack-formulas/users-formula/commit/2a887654fcffb2ea6870967007f6d8cd096ed1a0))


### Performance Improvements

* **travis:** improve `salt-lint` invocation [skip ci] ([b45914e](https://github.com/saltstack-formulas/users-formula/commit/b45914e063e3ac7462b31efa0b187d13cb8ee81a))

## [0.48.2](https://github.com/saltstack-formulas/users-formula/compare/v0.48.1...v0.48.2) (2019-10-11)


### Bug Fixes

* **rubocop:** add fixes using `rubocop --safe-auto-correct` ([](https://github.com/saltstack-formulas/users-formula/commit/13dd7f9))


### Continuous Integration

* merge travis matrix, add `salt-lint` & `rubocop` to `lint` job ([](https://github.com/saltstack-formulas/users-formula/commit/99136b5))
* **travis:** merge `rubocop` linter into main `lint` job ([](https://github.com/saltstack-formulas/users-formula/commit/96999c2))

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
