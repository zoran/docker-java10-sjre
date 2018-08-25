## Slim Docker image based on AlpineLinux with latest stable Oracle Java 10 Server JRE

[![Build Status](https://travis-ci.org/zoran/docker-java10-sjre.svg?branch=master)](https://travis-ci.org/zoran/docker-java10-sjre)
[![](https://images.microbadger.com/badges/image/zoran/java10-sjre:latest.svg)](https://microbadger.com/images/zoran/java10-sjre:latest)
[![Docker Pulls](https://img.shields.io/docker/pulls/zoran/java10-sjre.svg?style=round-square)](https://hub.docker.com/r/zoran/java10-sjre/)

---

### Usage / Examples

#### Pull the latest stable Server JRE version
```
docker pull zoran/java10-sjre
```

#### Run the latest stable Server JRE version
```
docker run -it --rm zoran/java10-sjre java -version
```

#### Run a specific Server JRE version (official full version string: 10.0.2+13)
```
docker run -it --rm zoran/java10-sjre:10.0.2p13 java -version
```

#### Use it as a Java basis in your Dockerfile
```
# Utilization of the latest stable Server JRE 10 version
FROM zoran/java10-sjre

RUN java -version
```

---

### Versioning
For the versions available, see the [tags on this repository](https://github.com/zoran/docker-java10-sjre/tags).

---

### Changes
Check the [Changelog.md](https://github.com/zoran/docker-java10-sjre/blob/master/Changelog.md)

---

### Authors
* **Zoran Kikic** - [zoran](https://github.com/zoran)

### License
This project is licensed under the MIT License - see the [LICENSE.md](https://github.com/zoran/docker-java10-sjre/blob/master/LICENSE.md) file for details

---

### Disclaimer
By using Dockerfiles contained in this repo and/or container images derived from them, you are agreeing to any and all applicable license agreements
