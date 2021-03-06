# using non base tag images as npm install is required
# latest        – 54.26 MB (npm 3.10.10)
# 7, 7.3, 7.3.0 – 54.26 MB (npm 3.10.10)
FROM mhart/alpine-node:6
# 6, 6.9, 6.9.2 – 49.65 MB (npm 3.10.10)
# 4, 4.7, 4.7.0 – 36.82 MB (npm 2.15.11)

RUN apk add --no-cache htop bash curl vim nano figlet git
RUN adduser -S server

RUN npm install pm2 -g --depth=0

# npm-cli-login supports the following environment varibles.
# NPM_USER: NPM username
# NPM_PASS: NPM password
# NPM_EMAIL: NPM email
# NPM_REGISTRY: (optional) Private NPM registry to log in to (Default: https://registry.npmjs.org)
# NPM_SCOPE: (optional) Private NPM scope
# NPM_RC_PATH: (optional) Path to a custom .npmrc file you want to update (Default: ~/)
#              (Do note this is the path of the file, not the file itself)
RUN npm install npm-cli-login -g --depth=0
# https://www.npmjs.com/package/npm-cli-login

# set the working directory to the home folder of the 'server' user
# for all docker commands operating on the container.
WORKDIR /home/server
USER server

# setup bash terminal for user 'server'
RUN curl https://raw.githubusercontent.com/gitnooji/nj-docker-support/master/.bashrc > .bashrc

# if you want the current filesystem contents statically loaded into
# the container, enable the COPY command below. you can still mount your
# local filesystem over the static contents of the '/home/server' folder
# COPY . .

# alternatively you can use git to pull in the project
# RUN git clone https://github.com/<USERNAME>/<REPO>.git

# If you have native dependencies, you'll need extra tools
# RUN apk add --no-cache make gcc g++ python

# install/config if needed
# RUN npm install

EXPOSE 9229 3001 3002 8000 8001 8002 8080 8181
# To connect the node engine debugger tools port 9229 is used
# the project's package.json scripts stanza should contain a start command
# which invokes the debugger.
#
# "start": "node --inspect --debug-brk server.js ",
#
CMD ["npm", "start"]
