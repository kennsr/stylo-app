import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/theme_ext.dart';
import '../bloc/product_list_event.dart';

class FilterSheet extends StatefulWidget {
  final ProductSortOption currentSort;
  final double? currentMinPrice;
  final double? currentMaxPrice;
  final void Function(
    ProductSortOption sort,
    double? minPrice,
    double? maxPrice,
  ) onApply;

  const FilterSheet({
    super.key,
    required this.currentSort,
    this.currentMinPrice,
    this.currentMaxPrice,
    required this.onApply,
  });

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  static const double _kMaxPrice = 1000000;
  static const double _kMinPrice = 0;

  late ProductSortOption _selectedSort;
  late RangeValues _priceRange;
  bool _isPriceFilterActive = false;

  final _currencyFormatter = NumberFormat('#,###', 'id_ID');

  @override
  void initState() {
    super.initState();
    _selectedSort = widget.currentSort;
    final min = widget.currentMinPrice ?? _kMinPrice;
    final max = widget.currentMaxPrice ?? _kMaxPrice;
    _priceRange = RangeValues(min, max);
    _isPriceFilterActive =
        widget.currentMinPrice != null || widget.currentMaxPrice != null;
  }

  String _formatPrice(double value) {
    return 'Rp ${_currencyFormatter.format(value.toInt())}';
  }

  bool get _hasActiveFilter {
    if (_selectedSort != ProductSortOption.terbaru) return true;
    if (_isPriceFilterActive) return true;
    return false;
  }

  void _resetAll() {
    setState(() {
      _selectedSort = ProductSortOption.terbaru;
      _priceRange = const RangeValues(_kMinPrice, _kMaxPrice);
      _isPriceFilterActive = false;
    });
  }

  void _applyFilter() {
    double? minPrice;
    double? maxPrice;
    if (_isPriceFilterActive) {
      if (_priceRange.start > _kMinPrice) minPrice = _priceRange.start;
      if (_priceRange.end < _kMaxPrice) maxPrice = _priceRange.end;
    }
    widget.onApply(_selectedSort, minPrice, maxPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHandle(),
            _buildHeader(context),
            const SizedBox(height: 4),
            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSortSection(context),
                    const SizedBox(height: 24),
                    _buildPriceSection(context),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            _buildApplyButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 12, bottom: 8),
        width: 36,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          Text(
            'Filter & Urutkan',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: context.primaryTextColor,
            ),
          ),
          const Spacer(),
          if (_hasActiveFilter)
            GestureDetector(
              onTap: _resetAll,
              child: Text(
                'Reset',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.accent,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSectionLabel(BuildContext context, String label) {
    return Text(
      label.toUpperCase(),
      style: GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: context.secondaryTextColor,
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildSortSection(BuildContext context) {
    final options = [
      (ProductSortOption.terbaru, 'Terbaru'),
      (ProductSortOption.ratingTertinggi, 'Rating Tertinggi'),
      (ProductSortOption.hargaTerendah, 'Harga Terendah'),
      (ProductSortOption.hargaTertinggi, 'Harga Tertinggi'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionLabel(context, 'Urutkan'),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((entry) {
            final (option, label) = entry;
            final isSelected = _selectedSort == option;
            return GestureDetector(
              onTap: () => setState(() => _selectedSort = option),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.accent : context.surfaceColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isSelected ? AppColors.accent : context.borderColor,
                    width: 1.5,
                  ),
                ),
                child: Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight:
                        isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected ? Colors.white : context.primaryTextColor,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPriceSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildSectionLabel(context, 'Rentang Harga'),
            const Spacer(),
            if (_isPriceFilterActive)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isPriceFilterActive = false;
                    _priceRange =
                        const RangeValues(_kMinPrice, _kMaxPrice);
                  });
                },
                child: Text(
                  'Hapus',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.accent,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildPriceBox(
                context,
                label: 'Min',
                value: _isPriceFilterActive
                    ? _formatPrice(_priceRange.start)
                    : _formatPrice(_kMinPrice),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                '—',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: context.secondaryTextColor,
                ),
              ),
            ),
            Expanded(
              child: _buildPriceBox(
                context,
                label: 'Max',
                value: _isPriceFilterActive
                    ? _formatPrice(_priceRange.end)
                    : _formatPrice(_kMaxPrice),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: AppColors.accent,
            inactiveTrackColor: context.dividerColor,
            thumbColor: AppColors.accent,
            overlayColor: AppColors.accent.withValues(alpha: 0.12),
            rangeThumbShape:
                const RoundRangeSliderThumbShape(enabledThumbRadius: 10),
            trackHeight: 3,
          ),
          child: RangeSlider(
            values: _priceRange,
            min: _kMinPrice,
            max: _kMaxPrice,
            divisions: 100,
            onChanged: (values) {
              setState(() {
                _priceRange = values;
                _isPriceFilterActive = true;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatPrice(_kMinPrice),
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: context.secondaryTextColor,
              ),
            ),
            Text(
              _formatPrice(_kMaxPrice),
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: context.secondaryTextColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceBox(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: context.surfaceColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: context.secondaryTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: context.primaryTextColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplyButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: SizedBox(
        height: 48,
        child: ElevatedButton(
          onPressed: _applyFilter,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Terapkan Filter',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
