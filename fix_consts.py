import re
import os
import subprocess

def run_analyze():
    result = subprocess.run(['flutter', 'analyze'], capture_output=True, text=True)
    return result.stdout

def fix_errors(output):
    lines = output.split('\n')
    fixes_made = 0
    i = 0
    while i < len(lines):
        line = lines[i].strip()
        if 'error • Invalid constant value' in line or 'error • The constructor being called' in line or 'Invalid constant value' in line:
            # Look backwards for the file path, which flutter analyze outputs before the error message
            # Format usually:  "file.dart:line:col • Error name"
            file_line = None
            j = i - 1
            while j >= max(0, i - 5):
                if '.dart:' in lines[j] and ' • ' in lines[j]:
                    file_line = lines[j].strip()
                    break
                j -= 1
                
            if file_line:
                parts = file_line.split(' • ')[0].split(':')
                if len(parts) >= 2:
                    filepath = parts[0].strip()
                    line_num = int(parts[1].strip()) - 1 # 0-indexed
                    
                    if os.path.exists(filepath):
                        with open(filepath, 'r') as f:
                            content_lines = f.readlines()
                            
                        if 0 <= line_num < len(content_lines):
                            target_line = content_lines[line_num]
                            # Try replacing 'const ' with ''
                            if 'const ' in target_line:
                                content_lines[line_num] = target_line.replace('const ', '', 1)
                                with open(filepath, 'w') as f:
                                    f.writelines(content_lines)
                                fixes_made += 1
                                print(f"Fixed {filepath}:{line_num+1}")
        i += 1
    return fixes_made

while True:
    print("Running analyze...")
    out = run_analyze()
    print("Fixing...")
    fixed = fix_errors(out)
    if fixed == 0:
        print("Done or stuck")
        break
