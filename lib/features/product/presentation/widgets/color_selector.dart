import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';

class ColorSelector extends StatefulWidget {
  final List<String> colors;
  final String? initialColor;
  final ValueChanged<String?> onColorSelected;

   const ColorSelector({
    super.key,
    required this.colors,
    this.initialColor,
    required this.onColorSelected,
  });

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  String? _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.initialColor;
  }

  Color _parseColor(String colorName) {
    final lowerColor = colorName.toLowerCase();
    switch (lowerColor) {
      case 'merah':
      case 'red':
        return Colors.red;
      case 'biru':
      case 'blue':
        return Colors.blue;
      case 'hijau':
      case 'green':
        return Colors.green;
      case 'kuning':
      case 'yellow':
        return Colors.yellow;
      case 'hitam':
      case 'black':
        return Colors.black;
      case 'putih':
      case 'white':
        return Colors.white;
      case 'abu-abu':
      case 'grey':
      case 'gray':
        return Colors.grey;
      case 'coklat':
      case 'brown':
        return Colors.brown;
      case 'ungu':
      case 'purple':
        return Colors.purple;
      case 'pink':
        return Colors.pink;
      case 'oranye':
      case 'orange':
        return Colors.orange;
      case 'krem':
      case 'cream':
        return  Color(0xFFFFFDD0);
      case 'navy':
        return  Color(0xFF001F5B);
      default:
        try {
          if (colorName.startsWith('#')) {
            return Color(
              int.parse(colorName.substring(1), radix: 16) | 0xFF000000,
            );
          }
        } catch (_) {}
        return AppColors.accent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Warna: ',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: context.primaryTextColor,
                ),
              ),
              if (_selectedColor != null)
                TextSpan(
                  text: _selectedColor!,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: context.secondaryTextColor,
                  ),
                ),
            ],
          ),
        ),
         SizedBox(width: 12),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: widget.colors.map((color) {
                final isSelected = _selectedColor == color;
                final colorValue = _parseColor(color);

                return Padding(
                  padding:  EdgeInsets.only(right: 10),
                  child: Tooltip(
                    message: color,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = isSelected ? null : color;
                        });
                        widget.onColorSelected(_selectedColor);
                      },
                      child: AnimatedContainer(
                        duration:  Duration(milliseconds: 150),
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorValue,
                          border: Border.all(
                            color: isSelected
                                ? AppColors.accent
                                : context.borderColor,
                            width: isSelected ? 2.5 : 1.5,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color:
                                        AppColors.accent.withValues(alpha: 0.25),
                                    blurRadius: 6,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : null,
                        ),
                        child: isSelected
                            ? Icon(
                                Icons.check_rounded,
                                size: 13,
                                color: colorValue.computeLuminance() > 0.5
                                    ? Colors.black
                                    : Colors.white,
                              )
                            : null,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
