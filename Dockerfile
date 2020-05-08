FROM nginx:stable-alpine

# Create a working directory
WORKDIR /static-html-directory

# Copy site code to nginx static site location
COPY static-html-directory /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Run nginx container at launch
# https://hub.docker.com/_/nginx)
# include -g daemon off in the CMD in order for nginx to stay in the foreground
CMD ["nginx", "-g", "daemon off;"]
