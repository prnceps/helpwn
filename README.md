# helpwn

docker-compose를 사용한 포너블 환경 구축

### build

```shell
docker-compose up -d --build
```

### Setting

```shell
update-alternatives --config python3
gem install one_gadget seccomp-tools
pip3 install ropgadget pwntools
```

### reference

- [check ubuntu package version](https://distrowatch.com/table.php?distribution=ubuntu)
