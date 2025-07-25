#######################################################
# Step 1: Sets up a runtime environment using nginx:alpine image
#######################################################
FROM nginx:23-alpine AS base

WORKDIR /app

EXPOSE 80

#######################################################
# Step 2: Uses the node:20-alpine image to build the application
#######################################################
FROM node:23-alpine AS build

# Set the environment variable
# ARG VITE_API_URL


# Set the working directory
WORKDIR /app

# Copy the package.json and yarn.json files
COPY package.json yarn.lock ./

# Install the dependencies
RUN yarn ci

# Copy the rest of the files over
COPY . .

# Run the tests and generate the code coverage report (including coverage check against the thresholds)
RUN yarn coverage

#######################################################
# Step 3: Separate stage to extract coverage report
#######################################################
FROM scratch AS coverage-export

COPY --from=build /app/coverage /coverage

#######################################################
# Step 4: Uses the minimal runtime image from the base stage to run the published app.
#######################################################
FROM base AS final

# Copy the build output from the build stage to Nginx's public directory
COPY --from=build /app/dist /usr/share/nginx/html

# Copy custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
