FROM python:3.12-slim

# Install necessary dependencies, including Git
RUN apt-get update && apt-get install -y git

# Set the working directory for your application
WORKDIR /app

# Set environment variables for Git credentials (these will be passed from docker-compose.yml or the environment)
ENV GIT_USERNAME=${GIT_USERNAME}
ENV GIT_TOKEN=${GIT_TOKEN}

# Configure Git to use the credentials for HTTPS authentication globally
RUN git config --global credential.helper store

# Update Git configuration to use token for all GitHub URLs
RUN git config --global url."https://${GIT_USERNAME}:${GIT_TOKEN}@github.com/".insteadOf "https://github.com/"

# Clone the main repository and its submodules
RUN git clone --recurse-submodules https://github.com/TheN4meless0ne/Den-store-f-rjulsoppgaven_YFF-Elias .

# Explicitly update submodules if needed
RUN git submodule update --init --recursive

# Copy application files into the container
COPY . .

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy additional application module
COPY infomodule /app/infomodule

# Set the Flask app environment variable
ENV FLASK_APP=run.py

# Expose the application port
EXPOSE 5000

# Start the Flask app when the container runs
CMD ["flask", "run", "--host=0.0.0.0"]
