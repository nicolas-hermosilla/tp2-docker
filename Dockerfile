FROM node:12-alpine3.9
ENV NODE_ENV=production

WORKDIR /app
COPY src/ ./src/
COPY package.json .

RUN npm install --production

CMD ["node", "src/index.js"]