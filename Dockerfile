# Stage 1: Build stage to get Nginx static binary
FROM nginx:alpine as build

# Copy nginx binary
RUN cp /usr/sbin/nginx /nginx

# Copy the default configuration (or your own)
RUN cp -R /etc/nginx /nginx-config

# Copy HTML page
COPY index.html /html/

# Stage 2: Final minimal image
FROM scratch

# Copy Nginx binary and config from the build stage
COPY --from=build /nginx /nginx
COPY --from=build /nginx-config /etc/nginx
COPY --from=build /html/ /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Start the Nginx web server
ENTRYPOINT ["/nginx", "-g", "daemon off;"]
