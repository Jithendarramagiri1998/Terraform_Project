# Use an official Nginx image as the base
FROM nginx:alpine

# Create an HTML file that will display "Hello, Dear"
RUN echo '<!DOCTYPE html><html><body><h1>Hello, Dear</h1></body></html>' > /usr/share/nginx/html/index.html

# Expose port 80
EXPOSE 80

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
