+++
title = "snapm 0.5.3 Release Notes"
date = 2026-01-05
weight = 42
template = "page.html"
render = true
[taxonomies]
tags = ["release"]
categories = ["release notes"]
+++

# Overview
This is a maintenance release for [snapm-0.5-stable](https://github.com/snapshotmanager/snapm/tree/snapm-0.5-stable) that includes two bug fixes.

Users of snapm-0.5.x who are unable to upgrade to a later y-stream release
should update to
[v0.5.3](https://github.com/snapshotmanager/snapm/releases/tag/v0.5.3) as soon
as possible to take advantage of these fixes.

## What's Changed
* Timeline index fix for v0.5.2 by [@bmr-cymru](https://github.com/bmr-cymru/) in
  [#609](https://github.com/snapshotmanager/snapm/pull/609)
* boot: hex escape literal ':' in values passed to systemd.{mount,swap}-extra
  by [@bmr-cymru](https://github.com/bmr-cymru/) in [#894](https://github.com/snapshotmanager/snapm/pull/894)


**Full Changelog**: [v0.5.2..v0.5.3](https://github.com/snapshotmanager/snapm/compare/v0.5.2...v0.5.3)
