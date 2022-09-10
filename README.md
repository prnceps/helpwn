# helpwn

docker-compose를 사용한 포너블 환경 구축

### build

```shell
docker-compose up -d --build
```

### ubuntu 16.04는 수동으로 설치해야 합니다.

```shell
gem install one_gadget seccomp-tools
pip3 install ropgadget pwntools
```

### change ubuntu version

https://github.com/kwon99/helpwn/blob/6b3d76ac53aaf2de790de4d4309f6cf69f49a3d6/docker-compose.yml#L7-L8

### reference

- [check ubuntu package version](https://distrowatch.com/table.php?distribution=ubuntu)
