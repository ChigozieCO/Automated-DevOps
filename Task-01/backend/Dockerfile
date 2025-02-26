# Set base image
FROM node:23-alpine

# Create app directory
WORKDIR /app

# Copy package.json and package-lock.json first (for better caching)
COPY backend/package*.json ./

# Install dependencies
RUN npm install

# Install app dependencies
RUN npm ci --only=production

# Copy backend source code
COPY backend/ .  

# Expose port
EXPOSE 3000

# Start the app
CMD ["node", "server.js"]