# Stage 1: Build the Node.js application
FROM node:16-alpine as builder

# Set the working directory inside the container
WORKDIR /Spyd-main

# Copy package.json and package-lock.json into the container's working directory
COPY Spyd-main/package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy the rest of the application source code into the container
COPY Spyd-main/ ./

# Build the application
RUN npm run build

# Stage 2: Set up Nginx to serve the built application
FROM nginx:latest

# Copy the built application files from the 'builder' stage
COPY --from=builder /Spyd-main/dist /usr/share/nginx/html

# Expose the necessary ports
EXPOSE 80
EXPOSE 5173

# Run Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
