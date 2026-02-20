import os
import shutil
from datetime import datetime

SOURCE_DIR = "source"
BRONZE_DIR = "data/bronze"

# Create batch timestamp folder
batch_timestamp = datetime.now().strftime("%Y_%m_%d_%H%M%S")
batch_folder = os.path.join(BRONZE_DIR, batch_timestamp)

os.makedirs(batch_folder, exist_ok=True)

# Copy all CSV files into batch folder
for file in os.listdir(SOURCE_DIR):

    if not file.endswith(".csv"):
        continue

    source_path = os.path.join(SOURCE_DIR, file)
    target_path = os.path.join(batch_folder, file)

    shutil.copy2(source_path, target_path)

    print(f"[BRONZE] Copied {file} to {batch_folder}")

print(f"\nBatch ingestion completed: {batch_timestamp}")