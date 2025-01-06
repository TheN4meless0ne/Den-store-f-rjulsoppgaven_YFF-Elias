FROM python:3.12-slim

# Install necessary dependencies: Git and SSH client
RUN apt-get update && apt-get install -y git openssh-client

# Set the working directory for your application
WORKDIR /app

# Copy the SSH private key into the container (Ensure it's securely passed)
# This is only necessary if you're copying it directly into the build context.
# In case of using a volume mount, this line can be skipped.
COPY id_rsa /root/.ssh/id_rsa

# Set appropriate permissions on the SSH private key
RUN chmod 600 /root/.ssh/id_rsa

# Disable strict host key checking for GitHub
RUN echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

# Clone the main repository with its submodules using SSH for authentication
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
