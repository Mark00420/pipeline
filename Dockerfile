# Step 1: Use Node.js image to build the app
FROM node:14 AS builder

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application
COPY . .

# Expose port 3000
EXPOSE 3000

# Command to run the application
CMD ["node", "app.js"]

# Step 2: Use Nginx to serve the app
FROM nginx:alpine

# Copy the built app from the builder stage
COPY --from=builder /usr/src/app /usr/share/nginx/html

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Command to run Nginx
CMD ["nginx", "-g", "daemon off;"]

