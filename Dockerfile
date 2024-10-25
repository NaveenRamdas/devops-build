# Step 1: Use an official Nginx image as the base
FROM nginx:alpine

# Step 2: Set the working directory inside the container
WORKDIR /usr/share/nginx/html

# Step 3: Remove the default Nginx static files
RUN rm -rf ./*

# Step 4: Copy your React build files from the local build folder to the Nginx HTML directory
COPY ./build .

# Step 5: Expose the port that Nginx will serve on
EXPOSE 80

# Step 6: Start Nginx (Nginx runs by default in the foreground)
CMD ["nginx", "-g", "daemon off;"]
