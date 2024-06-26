# Stage 1: Build the React application
FROM node:14 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Clean npm cache and install dependencies with --legacy-peer-deps
RUN npm cache clean --force
RUN npm install --legacy-peer-deps

# Copy the rest of the application
COPY . .

# Build the application
RUN npm run build

# Stage 2: Serve React application using Nginx
FROM nginx:alpine

# Remove default Nginx configuration
RUN rm -rf /etc/nginx/conf.d/*

# Copy Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy built files from previous stage
COPY --from=build /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
