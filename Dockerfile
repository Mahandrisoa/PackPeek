FROM node:18-alpine
# Installing libvips-dev for sharp Compatibility
RUN apk update && apk add --no-cache build-base gcc autoconf automake zlib-dev libpng-dev nasm bash vips-dev
ARG NODE_ENV=development
ENV NODE_ENV=${NODE_ENV}

WORKDIR /opt/
COPY package.json yarn.lock ./
RUN yarn config set network-timeout 600000 -g && yarn install
ENV PATH /opt/node_modules/.bin:$PATH

WORKDIR /opt/app

# Copy the rest of the application files
COPY . .

# Ensure correct permissions
RUN chown -R node:node /opt/app

# Switch to non-root user
USER node

# Build the application
RUN ["yarn", "build"]

# Copy the scripts into the image
COPY scripts/import-strapi-data.sh /scripts/import-strapi-data.sh
COPY entrypoint.sh /entrypoint.sh

# Make scripts executable
RUN chmod +x /scripts/import-strapi-data.sh
RUN chmod +x /entrypoint.sh

# Expose necessary ports
EXPOSE 1337

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
CMD ["yarn", "develop"]