# syntax=docker/dockerfile:1.4
FROM python:3.12-slim

# Install necessary packages
RUN apt-get update && apt-get install -y git openssh-client curl

# Set the working directory
WORKDIR /app

# Clone the repository and initialize submodules
ARG GIT_USERNAME
ARG GIT_TOKEN
RUN git clone --recurse-submodules https://${GIT_USERNAME}:${GIT_TOKEN}@github.com/TheN4meless0ne/Den-store-f-rjulsoppgaven_YFF-Elias .

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Set FLASK_APP environment variable to your main application file
ENV FLASK_APP=run.py

# Expose the port
EXPOSE 5000

# Command to run the app
CMD ["python", "freezer.py"]