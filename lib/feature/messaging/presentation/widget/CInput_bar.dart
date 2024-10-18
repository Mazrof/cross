import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';

class CInputBar extends StatelessWidget {
  const CInputBar({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.sm),
      child: Container(
        height: AppSizes.inputFieldH,
        decoration: BoxDecoration(
          color: AppColors.darkBackgroundColor,
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          boxShadow: const [
            BoxShadow(
              color: AppColors.blackColor12,
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.emoji_emotions_outlined),
              iconSize: AppSizes.iconMd,
              color: AppColors.grey,
              onPressed: () {},
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: AppSizes.xxs, top: AppSizes.xxs),
                child: TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines:
                      5, // Max number of lines before field starts scrolling
                  minLines: 1, // Minimum number of lines field will start with
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w300, color: AppColors.grey),
                    hintText: "Message",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                  onChanged: (text) {},
                  controller: controller,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.attach_file),
              color: AppColors.grey,
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.send),
              color: AppColors.grey,
              onPressed: () {
                // Todo
              },
            ),
          ],
        ),
      ),
    );
  }
}
