import os
import requests
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

# Variables for Radarr instances with their URLs and API keys from environment variables
RADARR_INSTANCES = [
    {"url": os.getenv("RADARR_URL_1"), "api_key": os.getenv("RADARR_API_KEY_1")},
    {"url": os.getenv("RADARR_URL_2"), "api_key": os.getenv("RADARR_API_KEY_2")},
    {"url": os.getenv("RADARR_URL_3"), "api_key": os.getenv("RADARR_API_KEY_3")}
]

def trigger_search(instance):
    url = f"{instance['url']}/api/v3/command"
    headers = {
        "Content-Type": "application/json",
        "X-Api-Key": instance['api_key']
    }
    data = {
        "name": "missingMoviesSearch"
    }
    
    try:
        response = requests.post(url, headers=headers, json=data)
        response.raise_for_status()  # Raise HTTPError for bad responses
        if response.status_code == 201:
            print(f"Successfully triggered search for missing movies on {instance['url']}")
        else:
            # Print detailed error information
            try:
                response_json = response.json()
                print(f"Failed to trigger search on {instance['url']}: {response.status_code}, {response_json}")
            except ValueError:
                print(f"Failed to trigger search on {instance['url']}: {response.status_code}, Response content is not JSON: {response.text}")
    except requests.exceptions.HTTPError as http_err:
        print(f"HTTP error occurred while triggering search on {instance['url']}: {http_err}")
    except requests.exceptions.RequestException as req_err:
        print(f"Request error occurred while triggering search on {instance['url']}: {req_err}")
    except Exception as e:
        print(f"An unexpected error occurred while triggering search on {instance['url']}: {e}")

def main():
    for instance in RADARR_INSTANCES:
        trigger_search(instance)

if __name__ == "__main__":
    main()
