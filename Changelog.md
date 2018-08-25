# Changelog

This file only reflects the changes that are made in this image. The version numbers correspond to the `Oracle JDK 10 releases`. The `+` from the JDK full version string is here replaced by a `b` in the version number for compatibility reasons. Example: `10.0.2+13` -> `10.0.2b13`

For Oracle JDK 10 release notes please check https://www.oracle.com/technetwork/java/javase/10all-relnotes-4108743.html

**10.0.2b13**
- Change the version scheme: `10.0.2p13` -> `10.0.2b13`. We can't use the `+` because docker doesn't accept a `+` in the image version string.

**`10.0.2p13`**
- Initial commit
- alpine: 3.8
- glibc: 2.28-r0
- Java SE Development Kit: 10.0.2 (JDK 10.0.2) (Full Version String: 10.0.2+13)
