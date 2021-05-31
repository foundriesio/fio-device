# fio-device
Tools to emulate a Foundries Factory device

## Usage

### Container

```
docker run -it --rm -e TOKEN=$TOKEN -e FACTORY=$FACTORY -t foundries/ostree-puller pull $OSTREE_HASH
```

### Compose

```
FACTORY=<> TOKEN=<> OSTREE_HASH=<> docker-compose up [--scale <service>=<instance-numb>]
```
