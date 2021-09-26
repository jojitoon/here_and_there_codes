# .docker/frontend/Dockerfile
ARG builder
FROM ${builder} as builder
FROM nginx:mainline-alpine

COPY --from=builder /app/dist/ /usr/share/nginx/html