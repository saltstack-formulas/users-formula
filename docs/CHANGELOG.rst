
Changelog
=========

`0.48.8 <https://github.com/saltstack-formulas/users-formula/compare/v0.48.7...v0.48.8>`_ (2022-06-09)
----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **googleauth:** ensure newline is preserved in ``repl`` of ``file.replace`` (\ `1dd5f32 <https://github.com/saltstack-formulas/users-formula/commit/1dd5f32a52b2e20b1fd58b23b260217b0144ad63>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* update ``pre-commit`` configuration inc. for pre-commit.ci [skip ci] (\ `8dce714 <https://github.com/saltstack-formulas/users-formula/commit/8dce714dcd6205bebf903be01acf2d99a892c9d8>`_\ )
* **kitchen+gitlab:** update for new pre-salted images [skip ci] (\ `6ebb05a <https://github.com/saltstack-formulas/users-formula/commit/6ebb05a00289a3f27de3f24995610e7659f450f3>`_\ )

Tests
^^^^^


* **system:** add ``build_platform_codename`` [skip ci] (\ `95cefb3 <https://github.com/saltstack-formulas/users-formula/commit/95cefb36ab62ea2bca792cf4080f69b4cef2697c>`_\ )
* **system.rb:** add support for ``mac_os_x`` [skip ci] (\ `321fdcf <https://github.com/saltstack-formulas/users-formula/commit/321fdcfd975faae3ae08b3df3d5d0a6bd6d39e6b>`_\ )

`0.48.7 <https://github.com/saltstack-formulas/users-formula/compare/v0.48.6...v0.48.7>`_ (2022-02-13)
----------------------------------------------------------------------------------------------------------

Code Refactoring
^^^^^^^^^^^^^^^^


* **salt-lint:** fix violation (\ `696139a <https://github.com/saltstack-formulas/users-formula/commit/696139a841b4984e0a20965c6156752d9de79941>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* update linters to latest versions [skip ci] (\ `a4fb2c6 <https://github.com/saltstack-formulas/users-formula/commit/a4fb2c638070a36d9cd7b48406a00e2bfd1611e7>`_\ )
* **3003.1:** update inc. AlmaLinux, Rocky & ``rst-lint`` [skip ci] (\ `ec9506d <https://github.com/saltstack-formulas/users-formula/commit/ec9506da14f4bfb089b90b87fb3144d07fa6f2e7>`_\ )
* **commitlint:** ensure ``upstream/master`` uses main repo URL [skip ci] (\ `2f0db66 <https://github.com/saltstack-formulas/users-formula/commit/2f0db666e49838ab58dd644a0f76201f8a24b2e8>`_\ )
* **gemfile:** allow rubygems proxy to be provided as an env var [skip ci] (\ `47cfe0e <https://github.com/saltstack-formulas/users-formula/commit/47cfe0ecd7ff697562da5a37e046ce1d18a105b6>`_\ )
* **gemfile+lock:** use ``ssf`` customised ``inspec`` repo [skip ci] (\ `6ad3c6a <https://github.com/saltstack-formulas/users-formula/commit/6ad3c6a1482a24b24bef33aab14808003852e560>`_\ )
* **gemfile+lock:** use ``ssf`` customised ``kitchen-docker`` repo [skip ci] (\ `8698fa5 <https://github.com/saltstack-formulas/users-formula/commit/8698fa535f294d1165549fc41998e2a124e78cc8>`_\ )
* **gitlab-ci:** add ``rubocop`` linter (with ``allow_failure``\ ) [skip ci] (\ `9b8b6e6 <https://github.com/saltstack-formulas/users-formula/commit/9b8b6e6a82aa300933ea2d3e0c05fc265fa53195>`_\ )
* **gitlab-ci:** use GitLab CI as Travis CI replacement (\ `3c879df <https://github.com/saltstack-formulas/users-formula/commit/3c879df9535578edbca4a6592571ccd16aff6148>`_\ )
* **kitchen:** move ``provisioner`` block & update ``run_command`` [skip ci] (\ `72c64ad <https://github.com/saltstack-formulas/users-formula/commit/72c64adbea8f2e31c3b6d6bb54b5f6f9e6e9437d>`_\ )
* **kitchen+ci:** update with ``3004`` pre-salted images/boxes [skip ci] (\ `4a8452a <https://github.com/saltstack-formulas/users-formula/commit/4a8452a266300d5c40429b7c1a4276c96afb1519>`_\ )
* **kitchen+ci:** update with latest ``3003.2`` pre-salted images [skip ci] (\ `6de2acb <https://github.com/saltstack-formulas/users-formula/commit/6de2acbe93aba57bdfb5be6c45049796f1f0e3a9>`_\ )
* **kitchen+ci:** update with latest CVE pre-salted images [skip ci] (\ `22c21e4 <https://github.com/saltstack-formulas/users-formula/commit/22c21e490e7f693c9a12c4d2b996f263c9ebe5c0>`_\ )
* **kitchen+ci:** use latest pre-salted images (after CVE) [skip ci] (\ `dabc4b7 <https://github.com/saltstack-formulas/users-formula/commit/dabc4b742ada383a7e5f6c4f376381380106e6d2>`_\ )
* **kitchen+gitlab:** adjust matrix to add ``3003`` [skip ci] (\ `34c757a <https://github.com/saltstack-formulas/users-formula/commit/34c757a9bb9967530168a3f4892c7c8c8d5b79ba>`_\ )
* **kitchen+gitlab:** remove Ubuntu 16.04 & Fedora 32 (EOL) [skip ci] (\ `3935693 <https://github.com/saltstack-formulas/users-formula/commit/3935693b589ead4b4a479a10c5a0216ab5b39f7f>`_\ )
* **kitchen+gitlab:** update for new pre-salted images [skip ci] (\ `0bff9fb <https://github.com/saltstack-formulas/users-formula/commit/0bff9fba4cf56154e5e5247639da90870d837c0a>`_\ )
* add ``arch-master`` to matrix and update ``.travis.yml`` [skip ci] (\ `632dc3c <https://github.com/saltstack-formulas/users-formula/commit/632dc3cc4b0d957bdb6bc51b942e37688163cb5e>`_\ )
* add Debian 11 Bullseye & update ``yamllint`` configuration [skip ci] (\ `0c49302 <https://github.com/saltstack-formulas/users-formula/commit/0c493020eef811bc95beea9674ecdbc229a1e7a8>`_\ )
* **kitchen+gitlab-ci:** use latest pre-salted images [skip ci] (\ `c260fe7 <https://github.com/saltstack-formulas/users-formula/commit/c260fe712669632c3f25c3cd1d778d70f9c7f88a>`_\ )
* **pre-commit:** add to formula [skip ci] (\ `d0e7c0a <https://github.com/saltstack-formulas/users-formula/commit/d0e7c0a19e940fecefd0df5c2061cf50d733da73>`_\ )
* **pre-commit:** enable/disable ``rstcheck`` as relevant [skip ci] (\ `013b2cd <https://github.com/saltstack-formulas/users-formula/commit/013b2cd3b84b80b32fae966d10b92f9da979ecf0>`_\ )
* **pre-commit:** finalise ``rstcheck`` configuration [skip ci] (\ `89c3c8f <https://github.com/saltstack-formulas/users-formula/commit/89c3c8f80606fd9266267c35a34e907b214ebca3>`_\ )
* **pre-commit:** update hook for ``rubocop`` [skip ci] (\ `0e7c6a3 <https://github.com/saltstack-formulas/users-formula/commit/0e7c6a38969aea06d1b2c9e9c0135e71717dca5c>`_\ )

Documentation
^^^^^^^^^^^^^


* **readme:** fix headings [skip ci] (\ `7d06cd5 <https://github.com/saltstack-formulas/users-formula/commit/7d06cd56dd2ed355f5117a88d91749a0639dca64>`_\ )

Tests
^^^^^


* standardise use of ``share`` suite & ``_mapdata`` state [skip ci] (\ `2a7c0de <https://github.com/saltstack-formulas/users-formula/commit/2a7c0de4aaf287a56ff96cabd900531740f097f5>`_\ )

`0.48.6 <https://github.com/saltstack-formulas/users-formula/compare/v0.48.5...v0.48.6>`_ (2020-10-02)
----------------------------------------------------------------------------------------------------------

Styles
^^^^^^


* quote numbers and file modes (\ `db30289 <https://github.com/saltstack-formulas/users-formula/commit/db302890460c6ac079bacb34a5c4f0b304fffe69>`_\ )

`0.48.5 <https://github.com/saltstack-formulas/users-formula/compare/v0.48.4...v0.48.5>`_ (2020-07-25)
----------------------------------------------------------------------------------------------------------

Bug Fixes
^^^^^^^^^


* **macos:** gid must be numeric on macos (\ `9517e4b <https://github.com/saltstack-formulas/users-formula/commit/9517e4b069d130b442562ed28fa9641cfebeb698>`_\ )

Continuous Integration
^^^^^^^^^^^^^^^^^^^^^^


* **gemfile:** restrict ``train`` gem version until upstream fix [skip ci] (\ `40f8e2d <https://github.com/saltstack-formulas/users-formula/commit/40f8e2d181f6ab345d205da95013bab8370afaf0>`_\ )
* **gemfile.lock:** add to repo with updated ``Gemfile`` [skip ci] (\ `ad7e8f7 <https://github.com/saltstack-formulas/users-formula/commit/ad7e8f7cab43fb01b8a3a6651e1adf96241e63cf>`_\ )
* **kitchen:** avoid using bootstrap for ``master`` instances [skip ci] (\ `4441c59 <https://github.com/saltstack-formulas/users-formula/commit/4441c597bd6425b5e5d79ced23d2c43790ec184e>`_\ )
* **kitchen:** use ``saltimages`` Docker Hub where available [skip ci] (\ `c12272e <https://github.com/saltstack-formulas/users-formula/commit/c12272eaae0440808f8c00ac5ac2f66ea5174f17>`_\ )
* **kitchen+travis:** remove ``master-py2-arch-base-latest`` [skip ci] (\ `892868f <https://github.com/saltstack-formulas/users-formula/commit/892868f3b52dfb1f3aaa2760bf37635b94eb2d29>`_\ )
* **travis:** add notifications => zulip [skip ci] (\ `628a430 <https://github.com/saltstack-formulas/users-formula/commit/628a4306814bb69af750f35c7fa077662033a19b>`_\ )
* **travis:** apply changes from build config validation [skip ci] (\ `9f76672 <https://github.com/saltstack-formulas/users-formula/commit/9f766728d4f8c44ed791dcc28e049c890331746d>`_\ )
* **travis:** opt-in to ``dpl v2`` to complete build config validation [skip ci] (\ `9a983a4 <https://github.com/saltstack-formulas/users-formula/commit/9a983a4c2aee5e097f16378885ab7d6cad490509>`_\ )
* **travis:** quote pathspecs used with ``git ls-files`` [skip ci] (\ `f9f8f13 <https://github.com/saltstack-formulas/users-formula/commit/f9f8f13693307695d6b6d8ca0aa2a9dcaa82c0c0>`_\ )
* **travis:** run ``shellcheck`` during lint job [skip ci] (\ `e09c822 <https://github.com/saltstack-formulas/users-formula/commit/e09c8221657338baabf73c97902174513009f63b>`_\ )
* **travis:** use ``major.minor`` for ``semantic-release`` version [skip ci] (\ `0afebc6 <https://github.com/saltstack-formulas/users-formula/commit/0afebc6fc36e1df818640bdddf6136841611243e>`_\ )
* **travis:** use build config validation (beta) [skip ci] (\ `0ddb90e <https://github.com/saltstack-formulas/users-formula/commit/0ddb90e6b546215e4de07b8257a89fc874f80d8b>`_\ )
* **workflows/commitlint:** add to repo [skip ci] (\ `7419dda <https://github.com/saltstack-formulas/users-formula/commit/7419dda3a4791044b8dd637cfcb8daedc637a2a8>`_\ )

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
