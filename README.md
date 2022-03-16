# Dockerizing Schedule app

To build this docker image run:
```bash
git clone https://github.com/PlumpAlbert/schedule-docker
cd schedule-docker
docker build --compress --rm --tag schedule:$(date +%F) --tag schedule:latest .
```

Then create docker container using image that we created earlier:
```bash
docker container create --publish ${host_port_to_use}:9000 schedule:latest
```
