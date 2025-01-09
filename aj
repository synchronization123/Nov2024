import requests
import urllib.parse

# Prompt the user for versions
versions_input = input("Enter the versions (comma separated): ")

# Encode the input to handle special characters properly
encoded_versions = urllib.parse.quote(versions_input)

# Construct the JQL query with the provided versions exactly as entered
jql_query = f"(labels in ({encoded_versions}) OR \"Build(s)\" in ({encoded_versions}))"

# Jira base URL (replace with your Jira URL)
jira_url = "https://jira.xrm.com/sr/jira.issueviews:searchrequest-csv-all-fields/temp/SearchRequest.csv"

# Jira API token (replace with your actual Jira API token)
api_token = "your-jira-api-token"

# Set the Authorization header using the Bearer token
headers = {
    "Authorization": f"Bearer {api_token}"
}

# Request the data from Jira
response = requests.get(f"{jira_url}?jqlQuery={jql_query}", headers=headers)

# Check if the request was successful
if response.status_code == 200:
    # Save the CSV data to a file
    with open('jiraoutput.csv', 'wb') as f:
        f.write(response.content)
    print("Data successfully downloaded and saved as 'jiraoutput.csv'")
else:
    print(f"Failed to download data. HTTP Status Code: {response.status_code}")