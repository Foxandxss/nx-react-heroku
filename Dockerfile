FROM node as build

WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . ./
RUN npm run build

FROM nginx
COPY --from=build /app/dist/apps/demo /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]