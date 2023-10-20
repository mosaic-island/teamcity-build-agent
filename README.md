# TeamCity Build Agent
This is TeamCity Build Agent configured to run in ECS with Azul Zulu 17

# To Build
Be sure to be logged in to Docker Hub

```shell
docker buildx build --push --platform linux/amd64 --tag miapplicationengineering/teamcity-build-agent:latest -f ./Dockerfile .
docker buildx build --platform linux/amd64 --tag miapplicationengineering/teamcity-build-agent:latest -f ./Dockerfile .
```

docker run -e SERVER_URL="https://teamcity.columbus-qa.product.which.co.uk"  \
    -v /tmp/teamcity:/data/teamcity_agent/conf  \
    miapplicationengineering/teamcity-build-agent:latest