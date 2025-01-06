FROM python:3.12-slim

# Install necessary dependencies, including Git and SSH client
RUN apt-get update && apt-get install -y git openssh-client

# Add the SSH key for GitHub access (Use Docker secrets or bind mount for security)
# Here we assume the private key is added securely to the build context, such as via Docker secrets or volumes.
COPY id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Disable strict host key checking for GitHub
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

# Set the working directory for your application
WORKDIR /app

# Clone the repository using SSH instead of HTTPS
RUN git clone --recurse-submodules git@github.com:TheN4meless0ne/Den-store-f-rjulsoppgaven_YFF-Elias.git .

# Update submodules if necessary
RUN git submodule update --init --recursive

# Copy the rest of the application files into the container
COPY . .

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Set the Flask app environment variable
ENV FLASK_APP=run.py

# Expose the application port
EXPOSE 5000

# Start the Flask app when the container runs
CMD ["flask", "run", "--host=0.0.0.0"]