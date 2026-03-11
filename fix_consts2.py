import re
import os
import subprocess

def run_analyze():
    result = subprocess.run(['flutter', 'analyze'], capture_output=True, text=True)
    return result.stdout

def fix_errors(output):
    # Parse flutter analyze output more robustly
    lines = output.split('\n')
    fixes_made = 0
    
    # regex for file path and line number
    # e.g.: lib/features/product/presentation/widgets/product_card.dart:76:40 • invalid_constant
    pattern = re.compile(r'^\s*(lib/.*?\.dart):(\d+):(\d+)\s+•\s+(invalid_constant|const_with_non_constant_argument)')
    
    for line in lines:
        match = pattern.match(line)
        if match:
            filepath = match.group(1)
            line_num = int(match.group(2)) - 1
            
            if os.path.exists(filepath):
                with open(filepath, 'r') as f:
                    content_lines = f.readlines()
                    
                if 0 <= line_num < len(content_lines):
                    target_line = content_lines[line_num]
                    # Try removing 'const '
                    if 'const ' in target_line:
                        content_lines[line_num] = target_line.replace('const ', '', 1)
                        with open(filepath, 'w') as f:
                            f.writelines(content_lines)
                        fixes_made += 1
                        print(f"Fixed {filepath}:{line_num+1}")
    return fixes_made

while True:
    print("Running analyze...")
    out = run_analyze()
    print("Fixing...")
    fixed = fix_errors(out)
    if fixed == 0:
        print("Done or stuck")
        break
