# Use a lightweight Nginx image
FROM nginx:alpine

# Copy frontend files to Nginx's default static directory
COPY ./index.html /usr/share/nginx/html/

# Expose port 80 for HTTP traffic
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]