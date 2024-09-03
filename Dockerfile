# Use a minimal Python image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Install cron
RUN apt-get update && \
    apt-get install -y cron && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the requirements file and install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application files
COPY . .

# Add a cron job
RUN echo "*/5 * * * * root python3 /app/your_script.py >> /var/log/cron.log 2>&1" > /etc/cron.d/your-cron-job

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/your-cron-job

# Apply cron job
RUN crontab /etc/cron.d/your-cron-job

# Run cron in the foreground
CMD ["cron", "-f"]
