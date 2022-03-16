# Dockerizing Schedule app
<img src="./onefetch.svg" />

Copy `.env.local` to `.env` and edit to suite your needs:
```bash
cp .env.local .env
```

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

Copy `nginx.site.conf` file to nginx sites configuration folder. Edit
`server_name` and `fastcgi_proxy` port to suite your setup.
