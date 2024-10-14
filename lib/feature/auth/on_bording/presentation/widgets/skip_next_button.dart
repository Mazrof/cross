import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_strings/app_strings.dart';

class SkipNextButton extends StatelessWidget {
  const SkipNextButton({
    super.key,
    required this.jumptoPage2,
    required this.jumptonextpage,
  });
  final Function() jumptoPage2;
  final Function() jumptonextpage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
              jumptoPage2();},
            style: TextButton.styleFrom(
              elevation: 0,
              textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: (MediaQuery.of(context).size.width <= 550) ? 13 : 17,

              ),
            ),
            child:   const Text(
              AppStrings.skip,
              style:  TextStyle(color: AppColors.primaryColor),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              jumptonextpage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 0,
              // foregroundColor: Colors.white,
              padding: (MediaQuery.of(context).size.width <= 550)
                  ? const EdgeInsets.symmetric(horizontal: 30, vertical: 20)
                  : const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
            
            ),
            child:  const Text(AppStrings.next)
          ),
        ],
      ),
    );
  }
}
