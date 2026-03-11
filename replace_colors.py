import os

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

    # Apply standard replacements
    for k, v in replacements.items():
        content = content.replace(k, v)

    # MainShell specific white replacements
    if 'main_shell.dart' in filepath:
        content = content.replace('color: Colors.white,', 'color: context.backgroundColor,')
        content = content.replace('backgroundColor: Colors.white,', 'backgroundColor: context.backgroundColor,')

    # Shimmer.fromColors uses specific highlight/base colors
    content = content.replace('baseColor: AppColors.shimmerBase', 'baseColor: context.isDarkMode ? AppColors.darkDivider : AppColors.shimmerBase')
    content = content.replace('highlightColor: AppColors.shimmerHighlight', 'highlightColor: context.isDarkMode ? AppColors.darkSurface : AppColors.shimmerHighlight')
    
    # Also need to make sure we don't end up with invalid context.isDarkMode if we don't import theme_ext
    if content != original:
        path_parts = filepath.split('/')
        try:
            lib_idx = path_parts.index('lib')
            rel_parts = path_parts[lib_idx+1:]
        except ValueError:
            rel_parts = path_parts

        depth = len(rel_parts) - 1
        prefix = '../' * depth if depth > 0 else './'
        imp = f"import '{prefix}core/theme/theme_ext.dart';"
        
        # fix edge case if the file IS in core/theme
        if 'core/theme' in filepath:
            imp = "import 'theme_ext.dart';"

        lines = content.split('\n')
        last_import = -1
        for i, line in enumerate(lines):
            if line.startswith('import '):
                last_import = i
                
        if last_import != -1 and 'theme_ext.dart' not in content:
            lines.insert(last_import + 1, imp)
            content = '\n'.join(lines)
            
        with open(filepath, 'w') as f:
            f.write(content)

for root, _, files in os.walk('lib'):
    # skip core/theme files to avoid circular imports unless necessary
    for file in files:
        if file.endswith('.dart') and file != 'app_colors.dart' and file != 'theme_ext.dart' and file != 'app_theme.dart':
            process_file(os.path.join(root, file))
