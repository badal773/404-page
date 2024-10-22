# Stage 1: Build stage to get Nginx static binary
FROM nginx:alpine as build

# Copy the Nginx binary from the container
RUN cp /usr/sbin/nginx /nginx

# Copy the default configuration (or your own)
RUN cp -R /etc/nginx /nginx-config

# Copy HTML page to the default location for Nginx
COPY index.html /usr/share/nginx/html/

# Stage 2: Final minimal image
FROM alpine:latest

# Install necessary packages for running Nginx (if needed)
RUN apk --no-cache add nginx

# Copy Nginx binary and config from the build stage
COPY --from=build /nginx /nginx
COPY --from=build /nginx-config /etc/nginx/
COPY --from=build /usr/share/nginx/html /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start the Nginx web server
ENTRYPOINT ["/nginx", "-g", "daemon off;"]
