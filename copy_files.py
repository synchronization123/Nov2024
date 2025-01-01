import os
import shutil

def copy_files_to_target():
    # Get the current directory
    current_directory = os.getcwd()

    # Hardcoded contrast directory
    contrast_directory = os.path.join(current_directory, 'contrast')

    # Prompt for the source folder inside contrast to copy files to curr_data
    source_folder_curr = input("Enter the folder name inside 'contrast' to copy files into 'curr_data': ").strip()
    source_path_curr = os.path.join(contrast_directory, source_folder_curr)
    curr_data_folder = os.path.join(current_directory, 'curr_data')

    # Ensure curr_data folder exists
    if not os.path.exists(curr_data_folder):
        os.makedirs(curr_data_folder)

    if os.path.exists(source_path_curr):
        try:
            for filename in os.listdir(source_path_curr):
                source_file = os.path.join(source_path_curr, filename)
                if os.path.isfile(source_file):
                    shutil.copy(source_file, curr_data_folder)
                    print(f"Copied {filename} to curr_data folder")
        except Exception as e:
            print(f"Error copying files to curr_data: {e}")
    else:
        print(f"Source folder does not exist: {source_path_curr}")

    # Prompt for the source folder inside contrast to copy files to prev_data
    source_folder_prev = input("Enter the folder name inside 'contrast' to copy files into 'prev_data': ").strip()
    source_path_prev = os.path.join(contrast_directory, source_folder_prev)
    prev_data_folder = os.path.join(current_directory, 'prev_data')

    # Ensure prev_data folder exists
    if not os.path.exists(prev_data_folder):
        os.makedirs(prev_data_folder)

    if os.path.exists(source_path_prev):
        try:
            for filename in os.listdir(source_path_prev):
                source_file = os.path.join(source_path_prev, filename)
                if os.path.isfile(source_file):
                    shutil.copy(source_file, prev_data_folder)
                    print(f"Copied {filename} to prev_data folder")
        except Exception as e:
            print(f"Error copying files to prev_data: {e}")
    else:
        print(f"Source folder does not exist: {source_path_prev}")

if __name__ == "__main__":
    copy_files_to_target()
