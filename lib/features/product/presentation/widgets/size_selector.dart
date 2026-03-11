import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';

class SizeSelector extends StatefulWidget {
  final List<String> sizes;
  final String? initialSize;
  final ValueChanged<String?> onSizeSelected;

   const SizeSelector({
    super.key,
    required this.sizes,
    this.initialSize,
    required this.onSizeSelected,
  });

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  String? _selectedSize;

  @override
  void initState() {
    super.initState();
    _selectedSize = widget.initialSize;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Ukuran',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
         SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.sizes.map((size) {
            final isSelected = _selectedSize == size;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedSize = isSelected ? null : size;
                });
                widget.onSizeSelected(_selectedSize);
              },
              child: AnimatedContainer(
                duration:  Duration(milliseconds: 150),
                padding:  EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.accent : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.accent
                        : context.borderColor,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  size,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isSelected ? Colors.white : null,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
