# .gitlab-ci/build-frontend.sh
#!/usr/bin/env sh

# stop script on error and log every executed command
set -ex

FRONTEND_IMAGE_TAG=${FRONTEND_IMAGE_TAG:-latest}
FRONTEND_IMAGE="${FRONTEND_IMAGE_NAME}:${FRONTEND_IMAGE_TAG}"

echo $CI_REGISTRY_PASSWORD | \
    docker login \
        -u $CI_REGISTRY_USER \
        --password-stdin $CI_REGISTRY

# Pull image from docker registry and ignore if they do not exist yet
docker pull "${FRONTEND_IMAGE}" || true

# build the web server image
docker build \
    --cache-from  /
    -t ${FRONTEND_IMAGE} /
    -f .docker/frontend/Dockerfile \
    .

# push image to our docker registry
docker push ${FRONTEND_IMAGE}



## then run this to make script executable
# chmod +x .gitlab-ci/build-frontend.sh