import sys
import os

# Try different PDF libraries
try:
    import PyPDF2
    def extract_text_pypdf2(filename):
        with open(filename, 'rb') as file:
            reader = PyPDF2.PdfReader(file)
            text = ""
            for page in reader.pages:
                text += page.extract_text() + "\n"
            return text
    extract_func = extract_text_pypdf2
except ImportError:
    try:
        import pypdf
        def extract_text_pypdf(filename):
            with open(filename, 'rb') as file:
                reader = pypdf.PdfReader(file)
                text = ""
                for page in reader.pages:
                    text += page.extract_text() + "\n"
                return text
        extract_func = extract_text_pypdf
    except ImportError:
        print("No PDF library found. Please install PyPDF2 or pypdf.")
        sys.exit(1)

# Extract text from both PDFs
files = [
    "MAAE 3202 Lab Manual - MAAE3202A Mechanics of Solids II (LEC) Fall 2025.pdf",
    "MAAE 3202 Lab Report instructions.pdf"
]

for filename in files:
    if os.path.exists(filename):
        print(f"\n{'='*80}")
        print(f"Content from: {filename}")
        print('='*80)
        try:
            text = extract_func(filename)
            # Search for prelab-related content
            text_lower = text.lower()
            if 'prelab' in text_lower or 'pre-lab' in text_lower or 'preparation' in text_lower:
                # Find the section
                lines = text.split('\n')
                for i, line in enumerate(lines):
                    if 'prelab' in line.lower() or 'pre-lab' in line.lower() or ('preparation' in line.lower() and 'before' in line.lower()):
                        # Print context around this line
                        start = max(0, i-5)
                        end = min(len(lines), i+50)
                        print('\n'.join(lines[start:end]))
                        print('\n' + '='*80 + '\n')
            
            # Print full text (or first 10000 chars if very long)
            if len(text) > 10000:
                print(text[:10000])
                print(f"\n... (truncated, total length: {len(text)} characters)")
            else:
                print(text)
        except Exception as e:
            print(f"Error extracting text: {e}")

