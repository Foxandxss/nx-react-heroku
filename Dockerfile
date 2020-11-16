FROM node as build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build -- --prod

FROM nginx
COPY --from=build /app/dist/apps/demo /usr/share/nginx/html
COPY default.conf.template /etc/nginx/conf.d/default.conf.template

CMD /bin/bash -c "envsubst '\$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf" && nginx -g 'daemon off;'

