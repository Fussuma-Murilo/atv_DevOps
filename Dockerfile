# 1. Base image: Node on Alpine Linux (small). Use an LTS version, not 25.
FROM node:24-alpine

# 2. All following commands run inside /app in the container
WORKDIR /app

# 3. Copy ONLY the dependency files first
COPY package*.json ./

# 4. Install the exact versions from the lockfile, without dev dependencies
RUN npm ci --omit=dev

# 5. Now copy the application code
COPY . .

# 6. Tell Node it's running in production
ENV NODE_ENV=production

# 7. Document the port the app listens on
EXPOSE 3000

# 8. Don't run as root (the node image ships with a "node" user)
USER node

# 9. Command that starts the app
CMD ["node", "main.js"]