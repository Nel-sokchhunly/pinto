# Use Node.js official image
FROM node:18

# Set working directory
WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Install Linux packages for virtual display
RUN apt-get update && apt-get install -y \
    x11vnc xvfb fluxbox websockify \
    && rm -rf /var/lib/apt/lists/*

# Install noVNC
RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC

# Install Playwright dependencies
RUN npx playwright install --with-deps

# Copy project files
COPY . .

# Expose necessary ports
EXPOSE 3000 5900 6080
# port 3000 is for nextjs
# port 5900 is for VNC
# port 6080 is for noVNC

# Start everything
CMD [ "bash", "./start.sh" ]
