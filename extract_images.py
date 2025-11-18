import pdfplumber
from PIL import Image
import io

lab_manual = "MAAE 3202 Lab Manual - MAAE3202A Mechanics of Solids II (LEC) Fall 2025.pdf"

try:
    with pdfplumber.open(lab_manual) as pdf:
        print(f"Total pages: {len(pdf.pages)}\n")
        
        for page_num, page in enumerate(pdf.pages):
            print(f"Page {page_num + 1}:")
            print(f"  - Text extraction: {len(page.extract_text() or '')} chars")
            
            # Try to get images
            images = page.images
            print(f"  - Images found: {len(images)}")
            
            # Try extracting tables
            tables = page.extract_tables()
            if tables:
                print(f"  - Tables found: {len(tables)}")
                for i, table in enumerate(tables):
                    print(f"    Table {i+1}: {len(table)} rows")
            
            # Try to get text with layout preservation
            text = page.extract_text(layout=True)
            if text and text.strip():
                print(f"  - Layout text: {len(text)} chars")
                print(f"  Preview: {text[:200]}...")
            print()
            
except Exception as e:
    print(f"Error: {e}")
    import traceback
    traceback.print_exc()





