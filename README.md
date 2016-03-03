# To build use

docker build -t engineering/postgres:9.4 .
docker tag engineering/postgres:9.4 a99a-rep-docker.ad.bedag.ch:5000/engineering/postgres:9.4
docker push a99a-rep-docker.ad.bedag.ch:5000/engineering/postgres:9.4
