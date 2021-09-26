FROM node:10-alpine as builder

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

RUN npm run build

FROM nginx:mainline-alpine
COPY --from=builder /app/dist/ /usr/share/nginx/html