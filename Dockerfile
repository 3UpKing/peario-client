# Use an official Node.js LTS image
FROM node:18

RUN apt-get update
 
RUN apt-get install -y python3 build-essential

# Install pnpm globally (faster than npm/yarn)
RUN npm install -g pnpm@7 typescript

# Set working directory
WORKDIR /app

# Copy package.json and pnpm-lock.yaml (or package-lock.json if using npm)
COPY package.json pnpm-lock.yaml ./

# Install dependencies using pnpm (or npm if preferred)
RUN pnpm install

# Copy the rest of the application code
COPY . .

# Build and minify code
RUN pnpm build

# Serve minifed code in prod
ENV NODE_ENV=production

# Expose the port your app runs on
EXPOSE 3000 

# Start the app
CMD ["npm", "run", "serve"]