FROM node:20-bullseye

WORKDIR /usr/src/app

# Copy package files
COPY package*.json ./

# Install dependencies with legacy peer deps
RUN npm install --legacy-peer-deps
# Install music encryption libraries
RUN npm install sodium-native sodium libsodium-wrappers tweetnacl

# Copy source code
COPY . .

# Build the application
RUN npm run build

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD node dist/healthcheck.js

# Start the application
CMD ["npm", "start"]