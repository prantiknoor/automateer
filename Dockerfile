# Use Node.js with Chrome pre-installed as base
FROM zenika/alpine-chrome
# FROM zenika/alpine-chrome:with-node

# Install pnpm globally with proper permissions
USER root
RUN apk add --no-cache nodejs-current npm tini
RUN npm install -g pnpm
USER chrome

# Set working directory
WORKDIR /usr/src/app

# Set Puppeteer to use the system Chrome
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# Copy package files
COPY package.json pnpm-lock.yaml ./

# Install dependencies with pnpm
RUN pnpm install --frozen-lockfile

# Copy application code
COPY . .

# Expose port for Express server
EXPOSE 3000

# Use tini as init system
ENTRYPOINT ["tini", "--"]

# Start the application
CMD ["node", "api.mjs"]