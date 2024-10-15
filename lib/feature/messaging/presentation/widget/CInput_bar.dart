import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/core/utililes/app_sizes/app_sizes.dart';

class CInputBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback sendMessage;
  const CInputBar(
      {required this.controller, super.key, required this.sendMessage});

  @override
  State<CInputBar> createState() => _CInputBarState();
}

class _CInputBarState extends State<CInputBar> {
  bool _isSendIcon = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.sm),
      child: Container(
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
              child: TextField(
                style: const TextStyle(color: AppColors.whiteColor),
                maxLines:
                    5, // Max number of lines before field starts scrolling
                minLines: 1, // Minimum number of lines field will start with
                decoration: const InputDecoration(
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.w300, color: AppColors.grey),
                  hintText: "Message",
                  border: InputBorder.none,
                ),
                onChanged: (text) {
                  setState(() {
                    _isSendIcon = text.isNotEmpty;
                  });
                },
                controller: widget.controller,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.attach_file),
              color: AppColors.grey,
              onPressed: () {},
            ),
            IconButton(
              icon: _isSendIcon ? Icon(Icons.send) : Icon(Icons.mic),
              color: AppColors.grey,
              onPressed: widget.sendMessage,
            ),
          ],
        ),
      ),
    );
  }
}
