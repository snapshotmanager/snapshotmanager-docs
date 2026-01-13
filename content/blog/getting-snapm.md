+++
title = "Getting snapm"
date = 2026-01-13
weight = 45
template = "page.html"
render = true
[taxonomies]
tags = ["tips","getting started"]
categories = ["blog posts", "tech tips"]
+++

# Getting `snapm`
Snapshot Manager is a Python application. It is simple to install whether you are working from distribution provided packages, or installing the latest source from git. For most users we recommend using distribution packages where available - you'll be able to take advantage of automatic updates and simplified configuration, but read on to discover how to install `snapm` using various methods, and where to obtain the Python packages and source code if required.

## 1. Installing distribution packages with `dnf` (recommended for most users).

What you'll need:

* A Linux system installed with a recent edition of [Fedora](https://fedoraproject.org) (F42+), [CentOS Stream](https://www.centos.org/download/) (c9s+), or [Red Hat Enterprise Linux](https://developers.redhat.com/products/rhel/download) (RHEL9.6 onward).

* Administrative privileges (or membership of the wheel group).

* A working internet connection.

Using the native dnf package management tool, open a terminal and either switch to the root account by running `su -` (if you have a root account password configured), or prefix the `dnf install` command with `sudo`, give the appropriate password when prompted, and `dnf` will do its thing, pull the packages down and get them installed:

```
$ su -
Password:
# dnf -y install snapm
```


Or:

```
$ sudo dnf -y install snapm
[sudo] password for bmr: 
```

For example, on Fedora 42 with `snapm-0.7.0-1.fc42` the installation will look something like this:

```
# dnf -y install snapm
Updating and loading repositories:
Repositories loaded.
Package                  Arch    Version                  Repository        Size
Installing:
 snapm                   noarch  0.7.0-1.fc42             updates       38.0 KiB
Installing dependencies:
 python3-snapm           noarch  0.7.0-1.fc42             updates        1.6 MiB
Installing weak dependencies:
 boom-boot               noarch  1.6.8-2.fc42             updates       30.3 KiB

Transaction Summary:
 Installing:         3 packages

Total size of inbound packages is 475 KiB. Need to download 475 KiB.
After this operation, 2 MiB extra will be used (install 2 MiB, remove 0 B).
[1/3] snapm-0:0.7.0-1.fc42.noarch       100% | 395.7 KiB/s |  36.8 KiB |  00m00s
[2/3] boom-boot-0:1.6.8-2.fc42.noarch   100% | 245.4 KiB/s |  29.5 KiB |  00m00s
[3/3] python3-snapm-0:0.7.0-1.fc42.noar 100% |   2.0 MiB/s | 408.8 KiB |  00m00s
--------------------------------------------------------------------------------
[3/3] Total                             100% |   1.3 MiB/s | 475.0 KiB |  00m00s
Running transaction
[1/5] Verify package files              100% | 250.0   B/s |   3.0   B |  00m00s
[2/5] Prepare transaction               100% |  21.0   B/s |   3.0   B |  00m00s
[3/5] Installing python3-snapm-0:0.7.0- 100% |  20.7 MiB/s |   1.7 MiB |  00m00s
[4/5] Installing snapm-0:0.7.0-1.fc42.n 100% | 542.2 KiB/s |  41.2 KiB |  00m00s
[5/5] Installing boom-boot-0:1.6.8-2.fc 100% |  33.1 KiB/s |  31.4 KiB |  00m01s
Complete!
```

Note that the `boom-boot` package (containing the boom boot manager CLI) is a weak dependency of `snapm` - that is to say, it is recommended but not required (the `python3-snapm` package separately depends on the `python3-boom` package that provides the procedural API that `snapm` uses). If you're installing `snapm` for manual use (rather than automation using the API or Ansible roles) you probably want to have `boom` installed too - it is the easiest way to get deeper insight into your snapshot boot entries.

If you would like to also have the HTML documentation available to browse locally add the `python3-snapm-doc` package name to your `dnf install` invocation.

## 2. Installing copr builds from GitHub (early access to new features & fixes)

What you'll need:

* The URL or PR# of the pull request that you want to install a build from.

* A Linux system installed with a recent edition of [Fedora](https://fedoraproject.org) (F42+), [CentOS Stream](https://www.centos.org/download/) (c9s+), or [Red Hat Enterprise Linux](https://developers.redhat.com/products/rhel/download) (RHEL9.6 onward).

* The package `python3-dnf-plugins-core` installed for the DNF copr plugin.

* Administrative privileges (or membership of the wheel group).

* A working internet connection.

In this scenario, we'll be using the DNF support for copr repositories in the core plug-ins package to enable a pull request repository and install the packages.

Either open the pull request web page, locate the comment from the Packit build system, and copy the provided `dnf` command for your distribution, or construct the repository argument for the dnf copr enable command as follows: ‘packit/snapshotmanager-snapm-PR#’, where PR# is the pull request number assigned by GitHub in the [snapshotmanager/snapm](https://github.com/snapshotmanager/snapm/) repository.

The command will end up looking like this:

```
# dnf copr enable packit/snapshotmanager-snapm-830
https://copr.fedorainfracloud.org/api_ 100% | 696.0 B/s | 485.0 B | 00m01s
Enabling a Copr repository. Please note that this repository is not part
of the main distribution, and quality may vary.

The Fedora Project does not exercise any power over the contents of
this repository beyond the rules outlined in the Copr FAQ at
<https://docs.pagure.org/copr.copr/user_documentation.html#what-i-can-build-in-copr>,
and packages are not held to any quality or security level.

Please do not file bug reports about these packages in Fedora
Bugzilla. In case of problems, contact the owner of this repository.
Is this ok [y/N]: y
```

Enter ‘y’ when prompted to confirm enabling the repository then follow the instructions from [1.](#1-installing-distribution-packages-with-dnf-recommended-for-most-users) to install the packages. When first installing packages from a new copr repository, you will be prompted to accept the Open PGP key used for signing packages in that repository: decide whether you trust the publisher of the builds, and enter ‘y’ to accept if so.

## 3. Installing from PyPi (Bleeding Edge Releases: Some Assembly Required)

* A Linux system installed with a recent edition of [Fedora](https://fedoraproject.org) (F42+), [CentOS Stream](https://www.centos.org/download/) (c9s+), or [Red Hat Enterprise Linux](https://developers.redhat.com/products/rhel/download) (RHEL9.6 onward).

* The package `python3-pip` installed for the pip program.

* Administrative privileges (or membership of the wheel group).

* A working internet connection.

New releases of `snapm` are pushed to the public PyPi repository at [snapm](https://pypi.org/project/snapm/). Often these will be available before updates to distribution packages are published (particularly for [CentOS Stream](https://www.centos.org/download/) and [Red Hat Enterprise Linux](https://developers.redhat.com/products/rhel/download)). These are mostly provided for users wanting to consume bleeding-edge releases in CI environments and are not typically recommended for end-users. You can install the latest code from PyPi using the `pip` command, including in a Python virtual environment. 

To install the latest package available (after activating any `venv`, if you wish to use one):

```
$ [sudo] pip install snapm
```

You can install `snapm` as a regular user or system wide, but be aware of the consequences of running pip as the root user if opting for the latter: consult your distribution's Python packaging documentation for further information. The `snapm` command requires administrative privileges for all snapshot management operations (but you can view the builtin help text as any user).

Just bear in mind: the Python packages do not currently include the configuration, systemd units, or manual pages that are included in the source and RPM distributions. This is a result of changes in the Python packaging ecosystem and the deprecation of `data_files` support in Python `setuptools`. You can reuse previously installed configuration files and resources to some extent but these may be out-of-date compared to the installation you are getting from PyPi. You will need to make any corrections or adjustments yourself. The easiest way to get these missing pieces is to clone the [source repository](https://github.com/snapshotmanager/snapm/) and copy the files to their proper locations with the following commands:


```
$ sudo mkdir -p /etc/snapm/plugins.d /etc/snapm/schedule.d
$ sudo cp systemd/*.timer /usr/lib/systemd/system
$ sudo cp systemd/*.service /usr/lib/systemd/system
$ sudo cp systemd/tmpfiles.d/snapm.conf /usr/lib/tmpfiles.d
$ sudo systemd-tmpfiles –create /usr/lib/tmpfiles.d/snapm.conf
$ sudo systemctl daemon-reload
```

If you would also like to install the latest manual pages, copy them from the man/ directory in the source tree into the appropriate location for your distribution (normally `/usr/share/man/man{5,8}`).

## 4. Installing or Running From Source (For Experts & Contributors)

* A Linux system installed with a recent edition of [Fedora](https://fedoraproject.org) (F42+), [CentOS Stream](https://www.centos.org/download/) (c9s+), or [Red Hat Enterprise Linux](https://developers.redhat.com/products/rhel/download) (RHEL9.6 onward).

* A working installation of the `git` version control system.

* (Optionally) the package `python3-pip` installed for the pip program.

* Administrative privileges (or membership of the wheel group).

* A working internet connection.

First clone the `snapm` repository from GitHub with the command:

```
$ git clone https://github.com/snapshotmanager/snapm
```

Optionally, also clone the boom-boot repository into the same parent directory (this is useful if you want to test or work on features or fixes that span both `snapm` and boom):

```
$ git clone https://github.com/snapshotmanager/boom-boot
```

To run `snapm` from the source tree, gain root privileges, change to the directory where you cloned the source (normally `snapm/`, relative to the directory where git-clone ran), and run the command:

```
# . scripts/setpaths.sh
```

This will set the `PATH` and `PYTHONPATH` environment variables appropriately for you to run `snapm` from the checked-out sources. It will also enable support for using the checked out copy of `boom-boot` if you also cloned that (assuming it is found at the path `../boom-boot` relative to the `snapm/` directory).

You can now run the `snapm` and boom commands using the latest source from `git`. Every time you pull or checkout a new revision subsequent invocations will use that copy of the code.

To install the current revision in a git clone, run:

```
$ sudo pip install .
```

Just remember that all the caveats from [3.](#3-installing-from-pypi-bleeding-edge-releases-some-assembly-required) apply to git clones too: you are responsible for ensuring all configuration files are in place, and for keeping them up-to-date with any code changes.

## 5. What's in the Box?

Depending on how `snapm` was installed the package will include some or all of the components needed to run and learn about the tool. This varies according to the packaging format (or lack thereof, in the case of source installations).

### 5.1 Source Distribution

The source distribution (a git checkout or a tarball) includes all the source and in tree documentation for Snapshot Manager but you are responsible for installing it and making it usable on your system. Refer to the previous chapter for instructions ([sec:Installing-or-Running]).

### 5.2 RPM Packages

The `snapm` project is packaged for RPM based distributions as three subpackages that all build from the same source RPM:

* `snapm` — The `snapm(8)` program, its manual pages, configuration files, systemd units, tmpfiles.d configuration, and [`README.md`](https://github.com/snapshotmanager/snapm/blob/main/README.md).

* `python3-snapm` — The Python API comprising the `snapm` Python package.

* `python3-snapm-doc` — HTML user and API documentation, normally found in `/usr/share/doc/python3-snapm-doc`.

You can browse the documentation installed on your system by running the following command (assuming you have a working web browser in a reasonably modern desktop environment):

```
$ xdg-open /usr/share/doc/python3-snapm-doc/doc/html/index.html
```

Or by visiting [this URL](file:///usr/share/doc/python3-snapm-doc/doc/html/index.html).

### 5.3 PyPi Packages

The PyPi (pip) packages include only the executable code that makes up Snapshot Manager. You will need to configure the program yourself and install any documentation you wish to use, following the directions in section [3.](#3-installing-from-pypi-bleeding-edge-releases-some-assembly-required).
