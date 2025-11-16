# Step 1 — Build Stage
FROM node:16-alpine AS build

WORKDIR /app

COPY package.json package-lock.json ./
RUN npm install

COPY . .
RUN npm run build

# Step 2 — NGINX Production Server
FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

# Expose the port you want to access (React default: 3000)
EXPOSE 3000

CMD ["nginx", "-g", "daemon off;"]


