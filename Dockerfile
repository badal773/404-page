# Stage 1: Build stage
FROM alpine:latest as builder

# Install nginx
RUN apk add --no-cache nginx

# Create necessary directories
RUN mkdir -p /tmp/nginx/client-body && \
    mkdir -p /var/log/nginx && \
    mkdir -p /var/cache/nginx && \
    mkdir -p /usr/share/nginx/html

# Copy static website content
COPY index.html /usr/share/nginx/html/

# Stage 2: Create minimal runtime image
FROM scratch

# Copy the entire root filesystem from builder
COPY --from=builder / /

# Set working directory
WORKDIR /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]