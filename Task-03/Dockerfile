# Set baseimage
FROM node:23-alpine

# Create app directory
WORKDIR /app

# Copy package.json and package-lock.json first (for better caching)
COPY my-express-app/package*.json ./

# Install app dependencies
RUN npm ci --only=production

# Copy app source code
COPY ./my-express-app .

# Expose port
EXPOSE 3000

# Start the app
CMD ["npm", "start"]