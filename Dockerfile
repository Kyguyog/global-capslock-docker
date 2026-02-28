# Use an official Python runtime as a parent image from Docker Hub
FROM python:3.12-slim

# Install build tools + Linux headers required for evdev
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    linux-headers-amd64 \
    && rm -rf /var/lib/apt/lists/*

# Install python dependencies
RUN  pip install fastapi uvicorn evdev

# Set the working directory to /app inside the container
WORKDIR /app

# Copy the requirements file and install dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Run the app
CMD ["python", "example-server.py"]

EXPOSE 8000