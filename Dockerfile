FROM python:3.12-slim

# Install necessary packages
RUN apt-get update && apt-get install -y git openssh-client curl

# Set the working directory
WORKDIR /app

# Test connectivity to GitHub
RUN curl -I https://github.com

# Ensure SSH directory exists and set permissions
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

# Attempt to add GitHub to known_hosts with verbose output for debugging
RUN touch /root/.ssh/known_hosts && ssh-keyscan -v github.com >> /root/.ssh/known_hosts && chmod 644 /root/.ssh/known_hosts

# If the above step fails, run this instead:
# RUN touch /root/.ssh/known_hosts || true

# Copy the id_rsa file
COPY id_rsa /root/.ssh/id_rsa

# Set correct permissions for the private key
RUN chmod 600 /root/.ssh/id_rsa

# Run the rest of the Dockerfile steps (e.g., clone repo)
RUN git clone --recurse-submodules https://github.com/TheN4meless0ne/Den-store-f-rjulsoppgaven_YFF-Elias .

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port
EXPOSE 5000

# Command to run the app
CMD ["flask", "run", "--host=0.0.0.0"]
