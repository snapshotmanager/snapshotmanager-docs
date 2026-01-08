+++
title = "snapm 0.7.0 Release Notes"
date = 2026-01-06
weight = 50
template = "page.html"
render = true
[taxonomies]
tags = ["release"]
categories = ["release notes"]
+++

# Overview
This release introduces significant new features, fixes, and quality of life improvements. These include enhancements to the [Difference Engine](https://snapm.readthedocs.io/en/latest/user_guide.html#difference-engine): support for multiple `-s|--start-path` arguments, cache fixes, better file type detection when not using `--file-types`, and improved move detection behaviour when multiple destinations exist, as well as support for plugin priorities in `Manager` and the in-tree plugins (for example, allowing the administrator to choose between `lvm2-thin`, and `lvm2-cow` snapshot providers where both can snapshot the same volume), better documentation for the Mount Manager in the [*User Guide*](https://snapm.readthedocs.io/en/latest/user_guide.html), and a new, user-visible timeline categorization ("yearly", "monthly", "weekly", "daily", etc.) that is available for all snapshot sets. This release also includes a fix for the `snapm` / `podman` netns mount issue [documented](https://github.com/snapshotmanager/snapm/wiki/Known-issue:-snapm-snapset-%7Bmount,umount%7D-and-podman-netfs-mounts) in earlier releases ([#586](https://github.com/snapshotmanager/snapm/issues/586)) and stronger validation for `schedule create` name arguments ([#906](https://github.com/snapshotmanager/snapm/issues/906)).

Users should upgrade to [v0.7.0](https://github.com/snapshotmanager/snapm/releases/tag/v0.7.0) as soon as possible to take advantage of these enhancements.

## Notes
* It is now possible to specify the `-s|--start` path multiple times when invoking the `snapset diff` and `snapset diffreport` commands. This allows the user to compare multiple independent subtrees in a single `diff` operation.
* The path based file type detection has been improved to support more common file extensions, text and binary path locations, and categorisations.
* A new `BINARY_LOG` file type categorisation has been added to describe files such as `wtmp`, SAR logs, and the journal.
* Plugins now support a `PluginPriority` configuration that specifies a positive integer priority level. The plugin with the greatest priority is chosen when multiple plugins can snapshot the same device. This allows the user to prefer `lvm2-cow` snapshots over `lvm2-thin` where both are possible and will in future allow support for file system level snapshots (for example, Btrfs). Refer to `snapm(8)`, and `snapm-plugins.d(5)` for further information on configuring plugin priorities.
* The Mount Manager is now described in the on-line and in-package [*User Guide*](https://snapm.readthedocs.io/en/latest/user_guide.html).
* The Mount Manager now handles unmounting of duplicate `/run/netns` mounts via a targeted workaround.
* The timeline classification algorithm used by the `Timeline` garbage collection policy has been generalised and is now available for all snapshot sets via the "Categories" snapshot set property and "categories" report field.
* The static file type classifier now uses a broader set of rules for classifying likely text or binary content types.
* The `tree` output format of the `snapset diff` command now displays separate nodes for paths that have both been moved and modified (for example, a file that was backed up and then changed in-place).

## What's Changed
* doc: add new snapm logo to README.md by [@bmr-cymru](https://github.com/bmr-cymru/) in [#823](https://github.com/snapshotmanager/snapm/pull/823)
* doc: update `README.md` and `user_guide.rst` with mount manager and difference engine  by [@bmr-cymru](https://github.com/bmr-cymru/) in [#830](https://github.com/snapshotmanager/snapm/pull/830)
* snapm: btrfs plugin pre-requisite features and fixes by [@bmr-cymru](https://github.com/bmr-cymru/) in [#843](https://github.com/snapshotmanager/snapm/pull/843)
* Fixes for progress log interleaving and text-like best-guess file type detection by [@bmr-cymru](https://github.com/bmr-cymru/) in [#851](https://github.com/snapshotmanager/snapm/pull/851)
* fsdiff: add `BINARY_LOG` file type category and fix `TEXT_FILE_PATHS` prefixing by [@bmr-cymru](https://github.com/bmr-cymru/) in [#855](https://github.com/snapshotmanager/snapm/pull/855)
* fsdiff: ctrl char glitches when diff -o tree --color=always | less -R by [@bmr-cymru](https://github.com/bmr-cymru/) in [#857](https://github.com/snapshotmanager/snapm/pull/857)
* fsdiff: tolerate missing `python-file-magic` and work around `Magic.close()` bug by [@bmr-cymru](https://github.com/bmr-cymru/) in [#859](https://github.com/snapshotmanager/snapm/pull/859)
* fsdiff: make `include_system_dirs` more robust and disable in next release by [@bmr-cymru](https://github.com/bmr-cymru/) in [#871](https://github.com/snapshotmanager/snapm/pull/871)
* fsdiff: implement cheap sibbling proximity heuristic for moves by [@bmr-cymru](https://github.com/bmr-cymru/) in [#874](https://github.com/snapshotmanager/snapm/pull/874)
* fsdiff: support `DiffOptions.from_path` as list by [@bmr-cymru](https://github.com/bmr-cymru/) in [#875](https://github.com/snapshotmanager/snapm/pull/875))
* plugins: bump plugin versions for prio support by [@bmr-cymru](https://github.com/bmr-cymru/) in [#876](https://github.com/snapshotmanager/snapm/pull/876)
* tests: improve `snapm.fsdiff` coverage by [@bmr-cymru](https://github.com/bmr-cymru/) in [#991](https://github.com/snapshotmanager/snapm/pull/881)
* snapm: lift timeline classification logic up to `SnapshotSet` by [@bmr-cymru](https://github.com/bmr-cymru/) in [#885](https://github.com/snapshotmanager/snapm/pull/885)
* snapm: don't alpha sort categories in reports by [@bmr-cymru](https://github.com/bmr-cymru/) in [#892](https://github.com/snapshotmanager/snapm/pull/892)
* mounts: container mount workarounds by [@bmr-cymru](https://github.com/bmr-cymru/) in [#900](https://github.com/snapshotmanager/snapm/pull/900)
* snapm: schedule name checks by [@bmr-cymru](https://github.com/bmr-cymru/) in [#910](https://github.com/snapshotmanager/snapm/pull/910)
* fsdiff: add `DiffOptions.no_mem_check` / `--no-mem-check` option by [@bmr-cymru](https://github.com/bmr-cymru/) in [#912](https://github.com/snapshotmanager/snapm/pull/912)
* snapm: broaden file type heuristics for suffix paths and support multiple change records in tree rendering by [@bmr-cymru](https://github.com/bmr-cymru/) in [#913](https://github.com/snapshotmanager/snapm/pull/913)

**Full Changelog**: [v0.6.0..v0.7.0](https://github.com/snapshotmanager/snapm/compare/v0.6.0...v0.7.0)
