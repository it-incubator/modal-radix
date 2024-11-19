# Check out https://hub.docker.com/_/node to select a new base image
FROM node:20.9-alpine
# Set to a non-root built-in user `node`
RUN npm install -g pnpm
# Create app directory (with user `node`)
RUN mkdir -p /home/node/dist/app

WORKDIR /home/node/dist/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)

COPY package*.json ./
COPY pnpm-lock.yaml ./

RUN pnpm install

# Bundle app source code
COPY . .

RUN pnpm build

# Bind to all network interfaces so that it can be mapped to the host OS

EXPOSE 3000

CMD [ "pnpm", "start" ]
