import pdfplumber
import sys

lab_manual = "MAAE 3202 Lab Manual - MAAE3202A Mechanics of Solids II (LEC) Fall 2025.pdf"

try:
    with pdfplumber.open(lab_manual) as pdf:
        print(f"Total pages: {len(pdf.pages)}\n")
        all_text = []
        
        for page_num, page in enumerate(pdf.pages):
            print(f"Extracting page {page_num + 1}...")
            text = page.extract_text()
            if text and text.strip():
                all_text.append(f"\n{'='*80}\nPAGE {page_num + 1}\n{'='*80}\n{text}")
        
        full_text = '\n'.join(all_text)
        
        # Save to file
        with open("lab_manual_full.txt", "w", encoding="utf-8") as f:
            f.write(full_text)
        
        print(f"\nExtracted {len(full_text)} characters total")
        print("\n" + "="*80)
        print("FULL EXTRACTED TEXT:")
        print("="*80 + "\n")
        print(full_text)
        
except Exception as e:
    print(f"Error: {e}")
    import traceback
    traceback.print_exc()

