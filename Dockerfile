FROM node:18-alpine

WORKDIR /app

# Install yarn
RUN npm install -g yarn

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . .

EXPOSE 3000
CMD ["node", "server.js"]