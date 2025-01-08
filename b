import requests
import openpyxl
from openpyxl.styles import Font

def fetch_commits(api_url, repo_url, api_token):
    # Extract project and repository names from the repo URL
    repo_parts = repo_url.rstrip("/").split("/")
    project_key = repo_parts[-2]
    repo_slug = repo_parts[-1]
    
    # Bitbucket API endpoint for commits
    commits_url = f"{api_url}/projects/{project_key}/repos/{repo_slug}/commits"

    # Headers for authentication
    headers = {
        "Authorization": f"Bearer {api_token}"
    }

    commits_data = []
    start = 0
    limit = 100  # API pagination limit

    while True:
        # Fetch commits with pagination
        response = requests.get(f"{commits_url}?start={start}&limit={limit}", headers=headers)
        if response.status_code != 200:
            raise Exception(f"Error fetching commits: {response.text}")

        commits = response.json()
        for commit in commits.get("values", []):
            commit_id = commit["id"]
            commit_date = commit["authorTimestamp"]
            jira_ids = [issue["key"] for issue in commit.get("properties", {}).get("jira", {}).get("issues", [])]
            commits_data.append([commit_id, ", ".join(jira_ids), commit_date])

        if not commits.get("isLastPage", False):
            start += limit
        else:
            break

    return commits_data

def export_to_excel(commits_data, output_file):
    # Create a workbook and sheet
    wb = openpyxl.Workbook()
    ws = wb.active
    ws.title = "Commits"

    # Add headers
    headers = ["Commit ID", "Jira IDs", "Commit Date"]
    ws.append(headers)

    # Style headers
    for col in range(1, len(headers) + 1):
        ws.cell(row=1, column=col).font = Font(bold=True)

    # Add data
    for row in commits_data:
        ws.append(row)

    # Save the workbook
    wb.save(output_file)

def main():
    api_url = input("Enter Bitbucket API URL (e.g., https://bitbucket.example.com/rest/api/1.0): ")
    repo_url = input("Enter Repository URL: ")
    api_token = input("Enter API Token: ")
    output_file = input("Enter Output Excel File Name (e.g., commits.xlsx): ")

    try:
        commits_data = fetch_commits(api_url, repo_url, api_token)
        export_to_excel(commits_data, output_file)
        print(f"Data successfully exported to {output_file}")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()