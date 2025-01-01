import os
import time
import subprocess

# List of Python scripts to execute
scripts = [
    "delete_curr_prev_output_folders.py",
    "copy_files.py",
    "compare3.py",
    "step2.py"
]

# Iterate through the list and execute each script
for script in scripts:
    if os.path.isfile(script):
        print(f"Executing {script}...")
        subprocess.run(["python", script])
        print(f"Completed {script}. Waiting for 5 seconds...")
        time.sleep(5)
    else:
        print(f"Script {script} not found in the current directory.")

print("All scripts executed.")
