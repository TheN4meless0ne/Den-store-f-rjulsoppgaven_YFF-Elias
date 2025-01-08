FROM python:3.12-slim

# Install necessary packages
RUN apt-get update && apt-get install -y git openssh-client curl

# Set the working directory
WORKDIR /app

# Copy the application code
COPY . .

# Initialize and update submodules
RUN git submodule init && git submodule update

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Ensure environment variables are passed correctly
ENV GIT_USERNAME=${GIT_USERNAME}
ENV GIT_TOKEN=${GIT_TOKEN}
ENV SECRET_KEY=${SECRET_KEY}

# Command to run the freezer script
CMD ["python", "freezer.py"]