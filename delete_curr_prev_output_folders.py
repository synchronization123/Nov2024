import os

def delete_files_in_folders():
    # Define the folders and file to delete
    folders = ['curr_data', 'prev_data', 'output']
    file_to_delete = 'final.xlsx'

    # Get the current directory
    current_directory = os.getcwd()

    # Iterate over the folders
    for folder in folders:
        folder_path = os.path.join(current_directory, folder)
        if os.path.exists(folder_path):
            try:
                # Remove only files inside the folder
                for filename in os.listdir(folder_path):
                    file_path = os.path.join(folder_path, filename)
                    if os.path.isfile(file_path):
                        os.remove(file_path)
                        print(f"Deleted file: {file_path}")
                print(f"Cleared files in folder: {folder_path}")
            except Exception as e:
                print(f"Error clearing files in folder {folder_path}: {e}")
        else:
            print(f"Folder does not exist: {folder_path}")

    # Delete the file
    file_path = os.path.join(current_directory, file_to_delete)
    if os.path.exists(file_path):
        try:
            os.remove(file_path)
            print(f"Deleted file: {file_path}")
        except Exception as e:
            print(f"Error deleting file {file_path}: {e}")
    else:
        print(f"File does not exist: {file_path}")

if __name__ == "__main__":
    delete_files_in_folders()
