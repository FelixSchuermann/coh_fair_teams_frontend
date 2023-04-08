# Use the official Nginx image as the base image
FROM nginx:stable

COPY fullchain.pem /etc/ssl/certs/
COPY privkey.pem /etc/ssl/private/

# Remove the default Nginx configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy the custom Nginx configuration file
#COPY nginx.conf /etc/nginx/conf.d
COPY nginx.conf /etc/nginx/nginx.conf
COPY website.conf /etc/nginx/conf.d

# Copy the built web app files to the Nginx container
COPY build/web /usr/share/nginx/html

# Expose the HTTP port
EXPOSE 80
EXPOSE 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
