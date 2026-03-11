import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import '../../core/theme/theme_ext.dart';

class StyloTextField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final bool readOnly;
  final int maxLines;
  final FocusNode? focusNode;

   const StyloTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.onEditingComplete,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.focusNode,
  });

  @override
  State<StyloTextField> createState() => _StyloTextFieldState();
}

class _StyloTextFieldState extends State<StyloTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: context.primaryTextColor,
          ),
        ),
         SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          obscureText: _isObscured,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          validator: widget.validator,
          readOnly: widget.readOnly,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
          focusNode: widget.focusNode,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: context.primaryTextColor,
          ),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              color: context.secondaryTextColor,
            ),
            filled: true,
            fillColor: context.surfaceColor,
            contentPadding:  EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                   BorderSide(color: context.borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                   BorderSide(color: context.borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                   BorderSide(color: AppColors.accent, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:  BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                   BorderSide(color: AppColors.error, width: 1.5),
            ),
            prefixIcon: widget.prefixIcon != null
                ? Icon(
                    widget.prefixIcon,
                    color: context.secondaryTextColor,
                    size: 20,
                  )
                : null,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _isObscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: context.secondaryTextColor,
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => _isObscured = !_isObscured),
                  )
                : (widget.suffixIcon != null
                    ? IconButton(
                        icon: Icon(
                          widget.suffixIcon,
                          color: context.secondaryTextColor,
                          size: 20,
                        ),
                        onPressed: widget.onSuffixTap,
                      )
                    : null),
            errorStyle: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.error,
            ),
          ),
        ),
      ],
    );
  }
}
