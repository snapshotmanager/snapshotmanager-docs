+++
title = "snapm 0.6.0 Release Notes"
date = 2025-12-22
weight = 42
template = "page.html"
render = true
[taxonomies]
tags = ["release"]
categories = ["release notes"]
+++


# Overview
This release introduces significant new features and fixes, including the [Difference Engine](https://snapm.readthedocs.io/en/latest/user_guide.html#difference-engine) for efficiently computing changes between two snapshot sets, or the system root file system and a snapshot set. Users should upgrade to [v0.6.0](https://github.com/snapshotmanager/snapm/releases/tag/v0.6.0) as soon as possible to take advantage of these enhancements.

## Notes
* The fsdiff API is considered unstable and may be subject to change in a future release.
* The `snapset diff` `--output-format=json` JSON schema is also potentially subject to change and will be formalised in a future release.
* The `snapset diff`/`snapset diffreport` command syntax is stable but output and formatting may change in future releases.
* Future releases may include new content differs for specific file types and more comprehensive file type detection when libmagic is disabled.
* Generating content diffs of large file system trees with many content changes may consume large amounts of memory: `snapm` will refuse to diff trees if `VmRSS` exceeds 33% of system memory after walking the filesystem. Caching is disabled if `VmRSS` exceeds 60% of system memory after computing diffs.

## What's Changed
* lvm2: Fix "no device" case for _is_lvm_device() and avoid no provider test if /boot is not a mount point by [@bmr-cymru](https://github.com/bmr-cymru/) in [#589](https://github.com/snapshotmanager/snapm/pull/589)
* Add mount manager by [@bmr-cymru](https://github.com/bmr-cymru/) in [#541](https://github.com/snapshotmanager/snapm/pull/541)
* snapm: fix renaming of snapshot sets with boot entries by [@bmr-cymru](https://github.com/bmr-cymru/) in [#591](https://github.com/snapshotmanager/snapm/pull/591)
* schedule: fix timeline garbage collection by [@bmr-cymru](https://github.com/bmr-cymru/) in [#596](https://github.com/snapshotmanager/snapm/pull/596)
* schedule: fix TIMELINE policy retention indexing when `keep_x > len(x)` by [@bmr-cymru](https://github.com/bmr-cymru/) in [#607](https://github.com/snapshotmanager/snapm/pull/607)
* stratis: re-use initial DBus query for StratisSnapshot cache by [@bmr-cymru](https://github.com/bmr-cymru/) in [#615](https://github.com/snapshotmanager/snapm/pull/615)
* container_tests: fix GcPolicyParamsTimeline.evaluate() tests edge case by [@bmr-cymru](https://github.com/bmr-cymru/) in [#628](https://github.com/snapshotmanager/snapm/pull/628)
* Clean up and enhance progress implementation by [@bmr-cymru](https://github.com/bmr-cymru/) in [#646](https://github.com/snapshotmanager/snapm/pull/646)
* doc: add missing snapm.manager._mounts to Sphinx docs by [@bmr-cymru](https://github.com/bmr-cymru/) in [#661](https://github.com/snapshotmanager/snapm/pull/661)
* Fix progress message overflow, bar width, and BrokenPipeError handling by [@bmr-cymru](https://github.com/bmr-cymru/) in [#662](https://github.com/snapshotmanager/snapm/pull/662)
* progress: clean up Progress and add Throbber classes by [@bmr-cymru](https://github.com/bmr-cymru/) in [#675](https://github.com/snapshotmanager/snapm/pull/675)
* progress: Fix `Throbber` `no_clear` bug and add styles by [@bmr-cymru](https://github.com/bmr-cymru/) in [#679](https://github.com/snapshotmanager/snapm/pull/679)
* mounts: fix incorrect SnapshotSet instead of name in name_map by [@bmr-cymru](https://github.com/bmr-cymru/) in [#684](https://github.com/snapshotmanager/snapm/pull/684)
* snapm: add fsdiff snapshot set comparison facility by [@bmr-cymru](https://github.com/bmr-cymru/) in [#620](https://github.com/snapshotmanager/snapm/pull/620)
* progress: cleanups and log integration by [@bmr-cymru](https://github.com/bmr-cymru/) in [#698](https://github.com/snapshotmanager/snapm/pull/698)
* snapm: implement snapshot set comparison UI (snapm snapset diff) by [@bmr-cymru](https://github.com/bmr-cymru/) in [#707](https://github.com/snapshotmanager/snapm/pull/707)
* snapm: address v0.6.0 feature/fix release blockers by [@bmr-cymru](https://github.com/bmr-cymru/) in [#759](https://github.com/snapshotmanager/snapm/pull/759)
* snapm: fix "Computing diffs" progress bar flicker and at move detector progress by [@bmr-cymru](https://github.com/bmr-cymru/) in [#775](https://github.com/snapshotmanager/snapm/pull/775)
* doc: add missing links, summary format and clarify defaults for output formats by [@bmr-cymru](https://github.com/bmr-cymru/) in [#779](https://github.com/snapshotmanager/snapm/pull/779)
* fsdiff: catch EOFError on truncated cache file by [@bmr-cymru](https://github.com/bmr-cymru/) in [#782](https://github.com/snapshotmanager/snapm/pull/782)
* fsdiff: move detector may mis-detect identical files as moves by [@bmr-cymru](https://github.com/bmr-cymru/) in [#784](https://github.com/snapshotmanager/snapm/pull/784)
* fsdiff: optimize cache writing and add progress reporting by [@bmr-cymru](https://github.com/bmr-cymru/) in [#791](https://github.com/snapshotmanager/snapm/pull/791)
* fsdiff: implement best-effort file type detection and "always exclude" paths by [@bmr-cymru](https://github.com/bmr-cymru/) in [#810](https://github.com/snapshotmanager/snapm/pull/810)

## Known issues

There is one known issue for this release. Please see the wiki pages for more details, status, and workarounds:

* [snapm snapset {mount,umount} and podman netfs mounts](https://github.com/snapshotmanager/snapm/wiki/Known-issue:-snapm-snapset-%7Bmount,umount%7D-and-podman-netfs-mounts)

This will be addressed in a future release.

**Full Changelog**: [v0.5.2...v0.6.0](https://github.com/snapshotmanager/snapm/compare/v0.5.2...v0.6.0)
