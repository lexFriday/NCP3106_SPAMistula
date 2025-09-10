#!/usr/bin/env python3
import re
import urllib.request
import csv
import sys

def scrape_video_ids(folder_url):
    """
    Scrapes file IDs from a publicly shared Google Drive folder URL.
    Returns a set of unique IDs.
    """
    try:
        with urllib.request.urlopen(folder_url) as response:
            html = response.read().decode("utf-8")
    except Exception as e:
        print(f"Error fetching page: {e}", file=sys.stderr)
        return set()

    # Regex to capture /file/d/FILE_ID/ patterns
    ids = re.findall(r'/file/d/([a-zA-Z0-9_-]{25,})', html)
    return set(ids)

def write_csv(ids, out_path):
    """
    Writes video ID data to CSV with headers:
    id,preview_link,download_link
    """
    headers = ["id", "preview_link", "download_link"]
    with open(out_path, "w", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow(headers)
        for vid in ids:
            preview = f"https://drive.google.com/file/d/{vid}/view"
            download = f"https://drive.google.com/uc?id={vid}&export=download"
            writer.writerow([vid, preview, download])
    print(f"CSV written to {out_path} with {len(ids)} entries.")

def main():
    # CHANGE THIS to your shared folder link
    folder_url = "https://drive.google.com/drive/folders/1h-w9-57ouVCK_diL5Kz1E4f-UKCtJL6e?usp=sharing"
    output_csv = "video_ids.csv"

    ids = scrape_video_ids(folder_url)
    if not ids:
        print("No file IDs found. Is the folder public and accessible?", file=sys.stderr)
        sys.exit(1)
    write_csv(ids, output_csv)

if __name__ == "__main__":
    main()
