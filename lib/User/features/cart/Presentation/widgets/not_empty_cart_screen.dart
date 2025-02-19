import 'package:coffe_app/User/features/cart/Presentation/widgets/payment_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../home/data/models/coffe_item.dart';
import '../../../home/presentation/cubit/UserData_cubit/user_data_cubit.dart';
import 'Payment_bottom_sheet/payment_bottom_sheet.dart';
import 'cart_items_listview.dart';

TextEditingController notesController = TextEditingController();

class NotEmptyCartScreen extends StatefulWidget {
  const NotEmptyCartScreen(
      {super.key,
      required this.discountPrice,
      required this.priceBeforeDiscount,
      required this.cartItems});

  final double discountPrice;
  final double priceBeforeDiscount;
  final List<CoffeeItem> cartItems;

  @override
  State<NotEmptyCartScreen> createState() => _NotEmptyCartScreenState();
}

class _NotEmptyCartScreenState extends State<NotEmptyCartScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserDataClassCubit>().getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Cart',
          style: TextStyle(
              letterSpacing: 2,
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: AppColorsDarkTheme.whiteAppColor),
        ),
        const SizedBox(
          height: 12,
        ),
        CartItemsListview(cartItems: widget.cartItems),
        const SizedBox(),
        Container(
          padding: const EdgeInsets.all(16),
          child: TextField(
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
            controller: notesController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColorsDarkTheme.darkBlueAppColor),
                borderRadius: BorderRadius.circular(12),
              ),
              fillColor: AppColorsDarkTheme.greyAppColor,
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColorsDarkTheme.darkBlueAppColor),
                borderRadius: BorderRadius.circular(12),
              ),
              hintText: 'Add Your Notes',
              hintStyle: TextStyle(
                  color: AppColorsDarkTheme.greyLessDegreeAppColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp),
              border: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: AppColorsDarkTheme.darkBlueAppColor),
                borderRadius: BorderRadius.circular(12),
              ),
              suffixIcon: const Icon(
                Icons.note_alt_outlined,
                color: AppColorsDarkTheme.greyLessDegreeAppColor,
              ),
            ),
          ),
        ),
        PaymentSummary(
            priceWithoutDiscount: widget.priceBeforeDiscount,
            priceWithDiscount: widget.discountPrice),
        const SizedBox(height: 16),
        PaymentBottomSheet(
          finalPrice: widget.discountPrice,
          cartItems: widget.cartItems,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
