# Use a base image with Python installed
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install cron and other necessary packages
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

# Ensure cron service is not running initially and set up log file
RUN service cron stop && touch /var/log/cron.log

# Run the script once at container startup and then start cron in the foreground
CMD ["sh", "-c", "python /app/app.py && cron && tail -f /var/log/cron.log"]
