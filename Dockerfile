FROM node:12.19.0-slim as build
RUN apt-get update \
    && apt-get install -y build-essential
WORKDIR /app
COPY package.json ./
COPY package-lock.json ./
RUN npm install
COPY . /app
RUN npm run build

FROM nginx:1.19.4-alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]