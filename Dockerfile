# Use a base Python image
FROM python:3.12-slim

# Install git and openssh-client
RUN apt-get update && apt-get install -y git openssh-client

# Set the working directory inside the container
WORKDIR /app

# Copy the private SSH key to the container
# Make sure to add the id_rsa file in the same directory as the Dockerfile
COPY id_rsa /root/.ssh/id_rsa

# Set proper permissions for the SSH private key
RUN chmod 600 /root/.ssh/id_rsa

# Configure SSH to prevent known host verification (optional, you can adjust this depending on your security needs)
RUN touch /root/.ssh/known_hosts && ssh-keyscan github.com >> /root/.ssh/known_hosts

# Clone the repository including submodules
RUN git clone --recurse-submodules https://github.com/TheN4meless0ne/Den-store-f-rjulsoppgaven_YFF-Elias .

# Update the submodules after cloning
RUN git submodule update --init --recursive

# Copy the rest of the application files
COPY . .

# Install dependencies from requirements.txt
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Set the FLASK_APP environment variable
ENV FLASK_APP=run.py

# Expose port 5000 for the Flask app
EXPOSE 5000

# Run the Flask app
CMD ["flask", "run", "--host=0.0.0.0"]
