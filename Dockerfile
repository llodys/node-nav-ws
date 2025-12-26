FROM node:20-alpine

WORKDIR /app

ENV NODE_ENV=production

RUN apk add --no-cache openssl curl gcompat iproute2 coreutils bash

COPY package.json package-lock.json ./

RUN npm ci --omit=dev

COPY app.js ./
COPY public ./public
COPY data ./data

EXPOSE 3000

CMD ["node", "app.js"]
