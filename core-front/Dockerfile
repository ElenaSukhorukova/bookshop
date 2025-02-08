ARG DEFAULT_PORT=3000

# Use the latest LTS version of Node.js
FROM node:22

# Set the working directory inside the container
RUN mkdir /app
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json /app

# Install dependencies
RUN npm install

# Copy the rest of your application files
COPY . /app

# Expose the port your app runs on
EXPOSE ${DEFAULT_PORT}

# Define the command to run your app
CMD ["npm", "start"]