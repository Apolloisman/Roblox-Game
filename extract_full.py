import sys
import os

try:
    import pypdf
except ImportError:
    print("pypdf not found")
    sys.exit(1)

def extract_all_pages(filename):
    with open(filename, 'rb') as file:
        reader = pypdf.PdfReader(file)
        all_text = []
        print(f"Total pages: {len(reader.pages)}")
        for page_num, page in enumerate(reader.pages):
            try:
                text = page.extract_text()
                if text.strip():  # Only add non-empty pages
                    all_text.append(f"\n--- Page {page_num + 1} ---\n{text}")
            except Exception as e:
                print(f"Error on page {page_num + 1}: {e}")
        return '\n'.join(all_text)

# Extract from lab manual
lab_manual = "MAAE 3202 Lab Manual - MAAE3202A Mechanics of Solids II (LEC) Fall 2025.pdf"
if os.path.exists(lab_manual):
    print(f"Extracting from: {lab_manual}\n")
    text = extract_all_pages(lab_manual)
    # Save to file
    with open("lab_manual_extracted.txt", "w", encoding="utf-8") as f:
        f.write(text)
    print(f"\nExtracted {len(text)} characters")
    # Print first 15000 chars
    print(text[:15000])
    if len(text) > 15000:
        print(f"\n... (see lab_manual_extracted.txt for full content)")

