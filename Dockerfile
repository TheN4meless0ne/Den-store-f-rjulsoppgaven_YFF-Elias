# syntax=docker/dockerfile:1.4
FROM python:3.12-slim

# Install necessary packages
RUN apt-get update && apt-get install -y git openssh-client curl

# Set the working directory
WORKDIR /app

# Configure SSH for GitHub
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh && \
    echo "Host github.com\n\tStrictHostKeyChecking no\n" > /root/.ssh/config

# Clone the repository and initialize submodules
RUN --mount=type=ssh git clone --recurse-submodules git@github.com:TheN4meless0ne/Den-store-f-rjulsoppgaven_YFF-Elias .

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Set FLASK_APP environment variable to your main application file
ENV FLASK_APP=run.py

# Expose the port
EXPOSE 5000

# Command to run the app
CMD ["python", "freezer.py"]