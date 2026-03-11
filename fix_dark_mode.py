import os
import re

EXT_IMPORT = "import '../../../../core/theme/theme_ext.dart';"
EXT_IMPORT_3 = "import '../../../core/theme/theme_ext.dart';"
EXT_IMPORT_2 = "import '../../core/theme/theme_ext.dart';"
EXT_IMPORT_1 = "import '../core/theme/theme_ext.dart';"
EXT_IMPORT_5 = "import '../../../../../core/theme/theme_ext.dart';"

def get_import_depth(path):
    parts = path.split('/lib/')[1].split('/')
    depth = len(parts) - 1
    if depth == 1: return EXT_IMPORT_1
    if depth == 2: return EXT_IMPORT_2
    if depth == 3: return EXT_IMPORT_3
    if depth == 4: return EXT_IMPORT_4 # Wait
    return None

def process_file(filepath):
    with open(filepath, 'r') as f:
        content = f.read()

    original = content

    replacements = {
        'AppColors.lightSurface': 'context.surfaceColor',
        'AppColors.lightBackground': 'context.backgroundColor',
        'AppColors.lightPrimaryText': 'context.primaryTextColor',
        'AppColors.lightSecondaryText': 'context.secondaryTextColor',
        'AppColors.lightDivider': 'context.dividerColor',
        'AppColors.lightBorder': 'context.borderColor',
    }

    # Only replace if context is available (in build method or similar).
    # Since it's Flutter, `context` is mostly available.
    
    for k, v in replacements.items():
        content = content.replace(k, v)

    # Replace hardcoded Colors.white carefully.
    # In MainShell:
    if 'main_shell.dart' in filepath:
        content = content.replace('color: Colors.white,', 'color: context.backgroundColor,')
        content = content.replace('backgroundColor: Colors.white,', 'backgroundColor: context.backgroundColor,')

    # Shimmer.fromColors
    content = content.replace('baseColor: AppColors.shimmerBase,', 'baseColor: context.isDarkMode ? AppColors.darkDivider : AppColors.shimmerBase,')
    content = content.replace('highlightColor: AppColors.shimmerHighlight,', 'highlightColor: context.isDarkMode ? AppColors.darkSurface : AppColors.shimmerHighlight,')
    content = content.replace('highlightColor: AppColors.lightSurface,', 'highlightColor: context.isDarkMode ? AppColors.darkSurface : AppColors.lightSurface,')

    if content != original:
        # Add import
        rel_path = filepath.split('/lib/')[1]
        depth = len(rel_path.split('/')) - 1
        imp = "import '" + ("../" * depth) + "core/theme/theme_ext.dart';"
        
        # Insert import after last import
        lines = content.split('\n')
        last_import = -1
        for i, line in enumerate(lines):
            if line.startswith('import '):
                last_import = i
        if last_import != -1 and imp not in content:
            lines.insert(last_import + 1, imp)
            content = '\n'.join(lines)
            
        with open(filepath, 'w') as f:
            f.write(content)

for root, _, files in os.walk('lib'):
    for file in files:
        if file.endswith('.dart'):
            process_file(os.path.join(root, file))
