# Setcap checks

### Build the image

```bash
docker build -t readonly .
```
### Run the docker images

Show how the setcap stuff works in conjunction with dropping all capabilities.

```bash
$ docker-compose run --rm readonly --readonly
$ docker-compose run --rm readonly-setcap --readonlyexec /usr/local/bin/readonly-setcap: operation not permitted
$ docker-compose run --rm readonly --readonly
```