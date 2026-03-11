import os

def process_file(filepath):
    with open(filepath, 'r') as f:
        content = f.read()

    new_content = content.replace('.withOpacity(', '.withValues(alpha: ')
    new_content = new_content.replace('activeColor:', 'activeThumbColor:')

    if content != new_content:
        with open(filepath, 'w') as f:
            f.write(new_content)
        return True
    return False

def walk_dir(directory):
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.dart'):
                filepath = os.path.join(root, file)
                process_file(filepath)

walk_dir('lib')
print("Deprecations fixed.")
