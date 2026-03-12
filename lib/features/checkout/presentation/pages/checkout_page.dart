import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../cart/presentation/bloc/cart_bloc.dart';
import '../../../cart/presentation/bloc/cart_event.dart';
import '../../../cart/presentation/bloc/cart_state.dart';
import '../bloc/checkout_bloc.dart';
import '../bloc/checkout_event.dart';
import '../bloc/checkout_state.dart';
import '../widgets/address_card.dart';
import '../widgets/payment_method_tile.dart';
import '../../domain/entities/payment_method.dart';
import '../widgets/shipping_option_tile.dart';
import 'order_success_page.dart';
import '../../../../core/theme/theme_ext.dart';

class CheckoutPage extends StatefulWidget {
   const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  @override
  void initState() {
    super.initState();
    context.read<CheckoutBloc>().add( CheckoutInitialize());
  }

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );

    return BlocListener<CheckoutBloc, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutSuccess) {
          context.read<CartBloc>().add( CartClear());
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => OrderSuccessPage(order: state.order),
            ),
          );
        } else if (state is CheckoutError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: GoogleFonts.poppins(fontSize: 13),
              ),
              backgroundColor: AppColors.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: context.surfaceColor,
        appBar: AppBar(
          backgroundColor: context.backgroundColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon:  Icon(Icons.arrow_back_ios_new, size: 20),
            color: context.primaryTextColor,
            onPressed: () => Navigator.of(context).maybePop(),
          ),
          title: Text(
            'Checkout',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: context.primaryTextColor,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize:  Size.fromHeight(1),
            child: Container(height: 1, color: context.dividerColor),
          ),
        ),
        body: BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, checkoutState) {
            if (checkoutState is CheckoutLoading ||
                checkoutState is CheckoutProcessing) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     CircularProgressIndicator(
                      color: AppColors.accent,
                      strokeWidth: 2,
                    ),
                     SizedBox(height: 16),
                    Text(
                      checkoutState is CheckoutProcessing
                          ? 'Memproses pesanan...'
                          : 'Memuat...',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: context.secondaryTextColor,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (checkoutState is CheckoutInitial) {
              return  SizedBox.shrink();
            }

            List addresses = [];
            String? selectedAddressId;
            List shippingOptions = [];
            dynamic selectedShipping;
            String? selectedPayment;
            List<PaymentMethod> paymentMethods = [];

            if (checkoutState is CheckoutAddressesLoaded) {
              addresses = checkoutState.addresses;
              selectedAddressId = checkoutState.selectedAddressId;
              paymentMethods = checkoutState.paymentMethods;
            } else if (checkoutState is CheckoutShippingLoaded) {
              addresses = checkoutState.addresses;
              selectedAddressId = checkoutState.selectedAddressId;
              shippingOptions = checkoutState.options;
              selectedShipping = checkoutState.selectedOption;
              paymentMethods = checkoutState.paymentMethods;
            } else if (checkoutState is CheckoutReady) {
              addresses = checkoutState.addresses;
              selectedAddressId = checkoutState.selectedAddressId;
              shippingOptions = checkoutState.shippingOptions;
              selectedShipping = checkoutState.selectedShipping;
              selectedPayment = checkoutState.selectedPayment;
              paymentMethods = checkoutState.paymentMethods;
            }

            return BlocBuilder<CartBloc, CartState>(
              builder: (context, cartState) {
                final cart =
                    cartState is CartLoaded ? cartState.cart : null;

                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding:  EdgeInsets.only(bottom: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Address section
                            _SectionHeader(
                              title: 'Alamat Pengiriman',
                              action: TextButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Fitur segera hadir',
                                        style: GoogleFonts.poppins(
                                            fontSize: 13),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8),
                                      ),
                                    ),
                                  );
                                },
                                icon:  Icon(Icons.add,
                                    size: 16, color: AppColors.accent),
                                label: Text(
                                  'Tambah Alamat',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: AppColors.accent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                              ),
                            ),
                            if (addresses.isEmpty)
                              Container(
                                margin:  EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                padding:  EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: context.backgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: context.dividerColor),
                                ),
                                child: Row(
                                  children: [
                                     Icon(
                                      Icons.location_off_outlined,
                                      color: context.secondaryTextColor,
                                      size: 20,
                                    ),
                                     SizedBox(width: 12),
                                    Text(
                                      'Belum ada alamat pengiriman.',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        color: context.secondaryTextColor,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            else
                              ...addresses.map(
                                (addr) => AddressCard(
                                  address: addr,
                                  isSelected: addr.id == selectedAddressId,
                                  onTap: () {
                                    context.read<CheckoutBloc>().add(
                                          CheckoutSelectAddress(
                                              addressId: addr.id),
                                        );
                                  },
                                ),
                              ),

                            // Shipping section
                            if (shippingOptions.isNotEmpty) ...[
                              const _SectionHeader(
                                  title: 'Pilih Pengiriman'),
                              ...shippingOptions.map(
                                (opt) => ShippingOptionTile(
                                  option: opt,
                                  isSelected:
                                      opt.id == selectedShipping?.id,
                                  onTap: () {
                                    context.read<CheckoutBloc>().add(
                                          CheckoutSelectShipping(
                                              option: opt),
                                        );
                                  },
                                ),
                              ),
                            ],

                            // Payment section
                            const _SectionHeader(
                                title: 'Metode Pembayaran'),
                            if (paymentMethods.isEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                child: Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.accent,
                                  ),
                                ),
                              )
                            else
                              ...paymentMethods.map(
                                (pm) => PaymentMethodTile(
                                  paymentMethod: pm,
                                  isSelected: pm.id == selectedPayment,
                                  onTap: () {
                                    context.read<CheckoutBloc>().add(
                                          CheckoutSelectPayment(method: pm.id),
                                        );
                                  },
                                ),
                              ),

                            // Order summary section
                            if (cart != null &&
                                cart.items.isNotEmpty) ...[
                              const _SectionHeader(
                                  title: 'Ringkasan Pesanan'),
                              Container(
                                margin:  EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 4),
                                padding:  EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: context.backgroundColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: context.dividerColor),
                                ),
                                child: Column(
                                  children: [
                                    ...cart.items.map(
                                      (item) => Padding(
                                        padding:  EdgeInsets.only(
                                            bottom: 8),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${item.productName} (${item.size}) x${item.quantity}',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 13,
                                                  color: AppColors
                                                      .lightPrimaryText,
                                                ),
                                                overflow:
                                                    TextOverflow.ellipsis,
                                              ),
                                            ),
                                             SizedBox(width: 8),
                                            Text(
                                              formatter.format(
                                                (item.discountPrice ??
                                                        item.price) *
                                                    item.quantity,
                                              ),
                                              style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors
                                                    .lightPrimaryText,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                     Divider(
                                        color: context.dividerColor,
                                        height: 16),
                                    _SummaryRow(
                                      label: 'Subtotal',
                                      value:
                                          formatter.format(cart.subtotal),
                                    ),
                                     SizedBox(height: 6),
                                    _SummaryRow(
                                      label: 'Ongkos Kirim',
                                      value: selectedShipping != null
                                          ? formatter.format(
                                              selectedShipping.cost)
                                          : '-',
                                    ),
                                     Divider(
                                        color: context.dividerColor,
                                        height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total',
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color:
                                                context.primaryTextColor,
                                          ),
                                        ),
                                        Text(
                                          formatter.format(
                                            cart.subtotal +
                                                (selectedShipping?.cost ??
                                                    0),
                                          ),
                                          style: GoogleFonts.poppins(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.accent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    _BayarButton(checkoutState: checkoutState),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            color: context.secondaryTextColor,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: context.primaryTextColor,
          ),
        ),
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final Widget? action;

  const _SectionHeader({required this.title, this.action});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.fromLTRB(16, 20, 16, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: context.primaryTextColor,
            ),
          ),
          ?action,
        ],
      ),
    );
  }
}

class _BayarButton extends StatelessWidget {
  final CheckoutState checkoutState;

  const _BayarButton({required this.checkoutState});

  @override
  Widget build(BuildContext context) {
    final isReady = checkoutState is CheckoutReady;

    return Container(
      padding:  EdgeInsets.fromLTRB(16, 12, 16, 24),
      decoration:  BoxDecoration(
        color: context.backgroundColor,
        border: Border(
          top: BorderSide(color: context.dividerColor, width: 1),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: isReady
              ? () => context
                  .read<CheckoutBloc>()
                  .add( CheckoutPlaceOrder())
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.accent,
            disabledBackgroundColor: context.borderColor,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Text(
            'Bayar Sekarang',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
