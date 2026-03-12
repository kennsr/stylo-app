import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/style_preference.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../../../../core/theme/theme_ext.dart';

class StylePreferenceChips extends StatefulWidget {
  final List<StylePreference> preferences;

   const StylePreferenceChips({super.key, required this.preferences});

  @override
  State<StylePreferenceChips> createState() => _StylePreferenceChipsState();
}

class _StylePreferenceChipsState extends State<StylePreferenceChips> {
  late Set<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = widget.preferences
        .where((p) => p.isSelected)
        .map((p) => p.id)
        .toSet();
  }

  @override
  Widget build(BuildContext context) {
    final allPrefs = widget.preferences.isNotEmpty
        ? widget.preferences
        : AppConstants.stylePreferences.asMap().entries.map(
            (e) => StylePreference(
              id: e.key.toString(),
              name: e.value,
              isSelected: _selectedIds.contains(e.key.toString()),
            ),
          ).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:  EdgeInsets.fromLTRB(20, 20, 20, 8),
          child: Text(
            'Preferensi Gaya',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Pilih gaya yang kamu suka untuk rekomendasi yang lebih personal.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.secondaryTextColor,
                ),
          ),
        ),
         SizedBox(height: 16),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: allPrefs.map((pref) {
              final isSelected = _selectedIds.contains(pref.id);
              return FilterChip(
                label: Text(pref.name),
                selected: isSelected,
                onSelected: (value) {
                  setState(() {
                    if (value) {
                      _selectedIds.add(pref.id);
                    } else {
                      _selectedIds.remove(pref.id);
                    }
                  });
                },
                selectedColor: AppColors.accent,
                checkmarkColor: Colors.white,
                // Explicit text color so it stays readable in both light and
                // dark mode — Material 3's default can blend with the chip
                // background in light mode.
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : context.primaryTextColor,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              );
            }).toList(),
          ),
        ),
         SizedBox(height: 24),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.read<ProfileBloc>().add(
                      ProfileUpdatePreferences(
                          preferenceIds: _selectedIds.toList()),
                    );
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                padding:  EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child:  Text(
                'Simpan',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
         SizedBox(height: 24),
      ],
    );
  }
}
