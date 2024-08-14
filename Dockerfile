# Use the official Node.js image as the base image
FROM node:20-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the React application
RUN npm run build

# Use a minimal Node.js image to serve the build
FROM nginx:alpine


COPY nginx.conf /etc/nginx/conf.d/default.conf
# Copy the build output to the Nginx HTML directory
COPY --from=0 /app/build /usr/share/nginx/html
# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
