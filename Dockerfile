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

# Give execution rights on the cron job file
RUN chmod 0644 /etc/cron.d/crontab

# Apply cron job
RUN crontab /etc/cron.d/crontab

# Install dotenv package
RUN pip install python-dotenv

# Start cron and keep the container running
CMD ["cron", "-f"]
