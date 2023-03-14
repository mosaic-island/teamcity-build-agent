# TeamCity Build Agent
This is TeamCity Build Agent configured to run AL2 &amp; Azul Zulu 17+

# To Build
Be sure to be logged in to Docker Hub

```shell
docker buildx build --push --platform linux/amd64 --tag miapplicationengineering/teamcity-build-agent:latest -f ./Dockerfile .

docker buildx build --platform linux/amd64 --tag miapplicationengineering/teamcity-build-agent:latest -f ./Dockerfile .

```