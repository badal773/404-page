# Step 1: Use a small Nginx image as the base image
FROM nginx:alpine

# Step 2: Remove default Nginx website
RUN rm -rf /usr/share/nginx/html/*

# Step 3: Copy your HTML file into the container
COPY index.html /usr/share/nginx/html/

# Step 4: Expose port 80 for the web server
EXPOSE 80

# Step 5: Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
