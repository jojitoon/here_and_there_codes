# .gitlab-ci/deploy.sh
#!/usr/bin/env sh

echo $CI_REGISTRY_PASSWORD | \
    docker login \
        -u $CI_REGISTRY_USER \
        --password-stdin $CI_REGISTRY

mkdir -p $BASE_PATH
rm -f $BASE_PATH/docker-compose.yml
cp $DOCKER_COMPOSE_FILE $BASE_PATH/docker-compose.yml
cd $BASE_PATH

DOTENV_FILE=.env
cat <<EOF > ${DOTENV_FILE}
FRONTEND_IMAGE=${FRONTEND_IMAGE}

EOF

docker-compose pull
docker-compose down --remove-orphans
docker-compose up -d
docker-compose ps


# make script executable
# chmod +x deploy.sh

# export CI_REGISTRY_USER=<your-ci-registry-user>
# export CI_REGISTRY=<your-ci-registry>
# export BASE_PATH=<your-base-path>
# export DOCKER_COMPOSE_FILE=docker-compose.production.yml
# export FRONTEND_IMAGE=<your-frontend-image>

#  CI_REGISTRY_PASSWORD=<your-ci-registry-password> ./deploy.sh