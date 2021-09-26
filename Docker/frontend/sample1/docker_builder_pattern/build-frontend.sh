# .gitlab-ci/build-frontend.sh
#!/usr/bin/env sh

# stop script on error and log every executed command
set -ex

FRONTEND_IMAGE="frontend"
FRONTEND_IMAGE_BUILDER="${FRONTEND_IMAGE}_builder"

echo $CI_REGISTRY_PASSWORD | \
    docker login \
        -u $CI_REGISTRY_USER \
        --password-stdin $CI_REGISTRY

# Pull images from docker registry and ignore if they do not exist yet
docker pull ${FRONTEND_IMAGE_BUILDER} || true
docker pull ${FRONTEND_IMAGE} || true

# build the builder image
docker build \
    --cache-from ${FRONTEND_IMAGE_BUILDER} \
    -t ${FRONTEND_IMAGE_BUILDER} \
    -f .docker/frontend/Dockerfile_builder \
    .

# build the web server image and pass the name of the dependent image
docker build \
    --cache-from ${FRONTEND_IMAGE} /
    -t ${FRONTEND_IMAGE} /
    -f .docker/frontend/Dockerfile \
    --build-arg builder="$FRONTEND_IMAGE_BUILDER" \
    .

# push both images to a docker registry
docker push ${FRONTEND_IMAGE_BUILDER}
docker push ${FRONTEND_IMAGE}