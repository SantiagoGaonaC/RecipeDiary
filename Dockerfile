FROM node:18-alpine

WORKDIR /api
COPY . .
RUN [ "npm", "i" ]
CMD [ "node", "/api/backend/src/index.js" ]