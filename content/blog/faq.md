+++
title = "Frequently Asked Questions (FAQs)"
date = 2026-01-20
weight = 45
template = "page.html"
render = true
[taxonomies]
tags = ["tips","faq"]
categories = ["documentation", "tech tips", "faq"]
+++

# Frequently Asked Questions (FAQs)

Our users ask a lot of reasonable and insightful questions about `snapm` and its usage. We have collected together some of the more common ones in this post, along with their corresponding answers.

## Running Snapshot Manager

**Q:** What Python version does snapm require?  
**A:** We support Python 3.9 and later.


**Q:** Do you support other operating systems than Linux?  
**A:** No, and this is unlikely to change: the snapshot providers that we support are all Linux specific.

**Q:** Is my distribution supported?  
**A:** The `snapm` command and `boom-boot` should work on most recent Linux distributions (using `boom` to create bootable snapshot sets requires a [*BLS compatible*](https://uapi-group.org/specifications/specs/boot_loader_specification/) boot loader: some versions of GRUB2, the zSeries zIPL, or [`systemd-boot(7)`](https://man7.org/linux/man-pages/man7/systemd-boot.7.html)). Distribution packages are currently available for, and are tested on, Fedora, CentOS Stream, and Red Hat Enterprise Linux.

**Q:** Can I use snapm on systems without LVM?  
**A:** Snapshot Manager supports LVM2 (CoW and thin) snapshots as well as Stratis snapshots. Other storage back ends (for example, Btrfs) may be supported in future versions.

## Using Snapshot Manager

**Q:** What's the difference between a Snapshot and a Snapshot Set?  
**A:** A Snapshot is an individual instance of a block device or file system snapshot (managed by `snapm` or not, as the case may be). A Snapshot Set is a named collection of snapshots taken at the same point in time and managed by `snapm`.

**Q:** Can I use the difference engine if I haven't created any snapshot sets yet?  
**A:** No: it is only possible to create difference reports when there is at least one snapshot set to make a comparison against.

**Q:** Do I need to use `boom` in order to use `snapm`?  
**A:** We require `boom` to create bootable snapshot sets but you don't need to interact with it directly (you don't even need to install the `boom-boot` CLI, but it can be useful for inspecting your boot entries). Unless you have unusual requirements the `snapm` tool can take care of all the details for you when you use the `--boot` or `--revert` options.

## Snapshot Set Creation and Management

**Q:** How much space do I need for snapshots?  
**A:** That is a bit of a ‘how long is a piece of string?’ question: the precise answer depends on the amount of change that occurs to the origin volume or the snapshot during its lifespan. Snapshot Manager defaults to allocating twice the space currently used on a mounted file system, or one quarter the size of block devices when creating snapshot sets, but if you have a better estimate then these values should be adjusted for your particular circumstances.

**Q:** What happens if a snapshot runs out of space?  
**A:** This will produce errors and may invalidate the snapshot. This should be avoided at all costs if you value what the snapshot represents, as it will result in data loss.

**Q:** Can I create snapshots of individual files or directories?  
**A:** No: none of the current snapshot providers support snapshots at this granularity. A similar result can be obtained on modern file systems via the *reflink* facility (see [`cp(1)`](https://man7.org/linux/man-pages/man1/cp.1.html)) but these snapshot-like file system objects are not managed by `snapm`.

**Q:** Can I modify the contents of a snapshot after creation?  
**A:** Yes. Snapshot sets are by default created in read-write mode and can be modified when mounted subject to normal file system permission checks.

**Q:** Why does my snapshot set show as "`Reverting`" and how long will it take?  
**A:** This is because a `snapset revert` command has been issued (or the underlying storage tools have been used to initiate a revert). The time it takes depends on the snapshot provider type: in all cases, when snapshots or their origin volumes are in use, the revert operation is deferred until the next activation (normally at boot time). In the case of LVM2 CoW snapshots the underlying merge operation involves physically moving dat**A:** this takes time proportional to the amount of data in the snapshot at the time of the merge and the speed of the storage devices involved. Thin snapshot reverts (LVM2 Thin and Stratis) are instantaneous at the time the pool is activated.

## Scheduling & Clean-up

**Q:** How do I know which garbage collection policy to use?  
**A:** This depends on how much space you have, and for how long you want to keep snapshot sets around. The four policies (`ALL`, `COUNT`, `AGE`, `TIMELINE`) cover a multitude of possibilities and accept parameters to configure them for your needs. See the `snapm(8)` manual page for a full description of configuring and managing schedules.

**Q:** Will scheduled snapshots fill up my disk?  
**A:** Potentially, yes. The thin provisioned snapshot providers are more space efficient than the LVM2 CoW provider but they will consume space from the pool they are created in (unlike LVM2 CoW which will not exceed the fixed space allocated to it from its containing volume group). You should configure a garbage collection policy with parameters that limit space consumption to an acceptable level.

**Q:** What happens to my snapshots if I delete a schedule?  
**A:** The snapshot sets will remain until they are manually deleted.

**Q:** Can I manually delete snapshot sets created by a schedule?  
**A:** Yes: use the regular `snapm snapset delete` command with the name or UUID of the snapshot set you want to remove. The schedule garbage collection policy will continue to operate as configured.

## Boot & Recovery

**Q:** What's the difference between `-b/--bootable` and `-r/--revert`?  
**A:** The `-b/--bootable` option creates a bootable snapshot set. When you select the resulting Snapshot boot entry the snapshot set will boot in place of the normal system environment, allowing you to look around and make changes. The `-r/--revert` option is used to create a fail safe revert boot entry. This is used in conjunction with the `snapm snapset revert` command to revert the system to the state reflected in the snapshot set. The revert boot entry uses backup boot images by default to protect against the case where the original copies have already been removed from the live system. See the `snapm(8)` manual page for full instructions on using Snapshot Manager's boot integration features.

**Q:** Can I boot into a snapshot set without reverting to it?  
**A:** Yes. Select the appropriate Snapshot boot entry from your system's boot menu to boot into the corresponding snapshot set. Subsequently, when you reboot, the system will by default boot into the normal (non snapshot) environment.

**Q:** What happens if I reboot while a revert is in progress?  
**A:** The revert will continue the next time that its volumes are activated.

**Q:** Do I need to create boot entries manually?  
**A:** No: use the `-b/--bootable` and `-r/--revert` options when creating snapshot sets and `snapm` will take care of the necessary details.

## Compatibility & Integration

**Q:** Can I use regular storage commands on snapm managed volumes?  
**A:** Yes: you are free to mix LVM2 or Stratis commands with your `snapm` commands. Just don't rename the logical volumes or Stratis file systems (or `snapm` will no longer recognise them as snapshot set members).

**Q:** Will snapm interfere with my existing LVM2 or Stratis snapshots?  
**A:** No: snapm will not touch any snapshots that it did not create.

**Q:** Does snapm work with Stratis or other storage systems?  
**A:** Yes: snapm currently supports LVM2 and Stratis with native (in tree) plugins. Support for Btrfs will be added in a future version.

**Q:** Can I use snapm with encrypted volumes?  
**A:** ‘It depends’: `snapm` currently supports LVM2 volume groups that are encrypted at the physical volume level (encrypted VGs) as well as encrypted Stratis pools. Support for individually encrypted LVM2 logical volumes will be included in a future release: see [Issue #916](https://github.com/snapshotmanager/snapm/issues/916) for more information.

## Performance & Safety

**Q:** Does creating snapshots impact system performance?  
**A:** Potentially, yes. This is particularly acute when you have multiple LVM2 CoW snapshots of the same volume. In this case performance is significantly degraded when more than a handful of snapshots exist.

**Q:** Is it safe to snapshot a running database?  
**A:** It depends on your definition of ‘safe’: the resulting snapshot will be internally consistent at the file system level but the database data will almost certainly not be *application consistent*. See the next question for more information. We are in the process of creating documentation to discuss this important topic in greater detail.

**Q:** What level of consistency do snapshots provide?  
**A:** It depends on how and when they are taken and whether the system was prepared for the snapshot beforehand. Snapshots are always *file system consistent* due to the mechanisms used by the kernel but achieving *application consistency* currently depends on the administrator to stop services or isolate to a `systemd` target such as `rescue` before creating snapshot sets.

**Q:** Can snapshots protect against hardware failure?  
**A:** Snapshots live on the same storage as your data. A catastrophic hardware failure may affect both your main volumes and your snapshots. For this reason we always recommend combining snapm use with a carefully designed and tested backup strategy.

## Troubleshooting

**Q:** Why can't I mount my snapshot set?  
**A:** First check the snapshot set is not Invalid. If this is the case then the volume will be inaccessible (and difficult to repair — recovery of an invalid CoW exception store is beyond the scope of this FAQ). If the snapshot is valid check the output of [`dmesg(1)`](https://man7.org/linux/man-pages/man1/dmesg.1.html) or [`journalctl(1)`](https://man7.org/linux/man-pages/man1/journalctl.1.html) and consider consulting the [`fsck(8)`](https://man7.org/linux/man-pages/man8/fsck.8.html) program for your file system (preferably, to start, in check/read only/dry run mode if supported).

Note that if you are trying to mount a snapshot of an [`xfs(5)`](https://man7.org/linux/man-pages/man5/xfs.5.html) file system while its origin volume is also mounted you will need to specify `-o nouuid` when running the [`mount(8)`](https://man7.org/linux/man-pages/man8/mount.8.html) program to avoid a UUID collision.

**Q:** My `diff` or `diffreport` command is taking forever — is this normal?
**A:** The time taken for difference computation is proportional to the size of the file system (number of files and directories) and the degree of change between the volumes being compared. It is normal for difference calculations for large volumes with many changes to take some time (minutes to tens of minutes for very large file systems). You may be able to gain more insight into what is happening by enabling verbose logs and debugging. Refer to the `snapm(8)` manual page for details of available debug and logging settings.  
