# syntax=docker/dockerfile:1.4
FROM python:3.12-slim

# Install necessary packages
RUN apt-get update && apt-get install -y git openssh-client curl

# Set the working directory
WORKDIR /app

# Configure SSH for GitHub
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh && \
    echo "Host github.com\n\tStrictHostKeyChecking no\n" > /root/.ssh/config

# Copy the private SSH key
COPY id_rsa /root/.ssh/id_rsa
RUN chmod 600 /root/.ssh/id_rsa

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the .env file containing the secret key
COPY .env .env

# Set FLASK_APP environment variable to your main application file
# Change "app.py" to whatever your Flask app's entry point is
ENV FLASK_APP=run.py

# Expose the port
EXPOSE 5000

RUN chmod +x ./entrypoint.sh

CMD ["sh", "./entrypoint.sh"]
