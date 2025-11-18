import pdfplumber
from PIL import Image
import io
import os

lab_manual = "MAAE 3202 Lab Manual - MAAE3202A Mechanics of Solids II (LEC) Fall 2025.pdf"

try:
    with pdfplumber.open(lab_manual) as pdf:
        print(f"Total pages: {len(pdf.pages)}\n")
        
        # Extract images from each page
        for page_num, page in enumerate(pdf.pages):
            print(f"Processing page {page_num + 1}...")
            
            # Get images on this page
            images = page.images
            print(f"  Found {len(images)} image(s)")
            
            # Try to render the page as an image
            try:
                im = page.to_image(resolution=150)
                output_path = f"page_{page_num + 1}.png"
                im.save(output_path)
                print(f"  Saved page {page_num + 1} as {output_path}")
            except Exception as e:
                print(f"  Could not save page image: {e}")
            
            # Try to extract text with different methods
            text = page.extract_text()
            if text and text.strip():
                print(f"  Text found: {text[:200]}...")
            
            # Check for "Experiment D" in any extracted text
            if text and 'experiment d' in text.lower() or 'experiment d' in text.lower():
                print(f"\n*** FOUND EXPERIMENT D ON PAGE {page_num + 1} ***")
                print(text)
            
            print()
            
except Exception as e:
    print(f"Error: {e}")
    import traceback
    traceback.print_exc()

