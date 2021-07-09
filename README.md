# fio-device
Tools to emulate a Foundries Factory device

## Usage

### Container

#### Build
````
docker build -t foundries/ostree-puller .
````

#### Run
```
export COMPOSE_HTTP_TIMEOUT=3600
docker run -it --rm -e TOKEN=$TOKEN -e FACTORY=$FACTORY -e OSTREE_HASH=$OSTREE_HASH -v $REPO_ROOT:/repo -v $PWD:/work -w /work -t foundries/ostree-puller /work/pull $OSTREE_HASH /repo
```

### Compose

#### Pull via OSTreeProxy
```
FACTORY=<> TOKEN=<> OSTREE_HASH=<> REPO_ROOT=<> docker-compose up [--scale ostree-puller=<instance-numb>]
```

#### Pull directly from GCS bucket
export COMPOSE_HTTP_TIMEOUT=3600
REPO_URI=<> GCS_TOKEN=<> OSTREE_HASH=<> REPO_ROOT=<> docker-compose -f docker-compose-gcs.yml up [--scale puller=<instance-numb>]

#### Just register a device and get device certificate&key as well as device config
```
FACTORY=<> TOKEN=<> UID_GID="$(id -u):$(id -g)" docker-compose run device-registrator
```
