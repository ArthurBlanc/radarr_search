# Use a base image with Python installed
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install cron
RUN apt-get update && apt-get install -y cron

# Copy the requirements file
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the cron file and script
COPY crontab /etc/cron.d/crontab
COPY app.py .

# List the contents of the cron file
RUN cat /etc/cron.d/crontab

# Verify cron job syntax
RUN crontab -l

# Give execution rights on the cron job file
RUN chmod 0644 /etc/cron.d/crontab

# Try to install cron jobs
RUN crontab /etc/cron.d/crontab

# Start cron and execute the Python script at container start
CMD cron && python /app/app.py TASK=startup
