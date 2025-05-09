# Use Node.js v22 image as the base
FROM node:22-slim

# Install pnpm
RUN corepack enable && corepack prepare pnpm@10.10.0 --activate

# Install necessary dependencies for Puppeteer
RUN apt-get update && apt-get install -y wget

RUN cd /tmp \
    && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && apt-get install -y --fix-missing ./google-chrome-stable_current_amd64.deb
    
    # apt-get install -y wget gnupg \
    # && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    # && mkdir -p /etc/apt/sources.list.d \
    # && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    # && apt-get update \
    # && apt-get install -y google-chrome-stable fonts-ipafont-gothic fonts-wqy-zenhei fonts-thai-tlwg fonts-kacst fonts-freefont-ttf libxss1 \
    #   --no-install-recommends \
    # && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /usr/src/app

# Copy package files
COPY package.json pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install --frozen-lockfile

# Copy app source
COPY . .

# Set environment variable for Puppeteer to use Chrome instead of Chromium
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true
ENV PUPPETEER_EXECUTABLE_PATH=/usr/bin/google-chrome

# Expose port (if your Express app needs it)
EXPOSE 3000

# Start the application
CMD ["node", "api.mjs"]