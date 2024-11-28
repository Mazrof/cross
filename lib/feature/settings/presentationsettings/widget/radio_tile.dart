import 'package:flutter/material.dart';
import 'package:telegram/core/utililes/app_colors/app_colors.dart';
import 'package:telegram/feature/settings/presentationsettings/controller/user_settings_state.dart';

enum PrivacyOption { everybody, myContacts, nobody }

enum AutoDelOption { off, oneDay, oneWeek, oneMonth }

extension PrivacyOptionExtension on PrivacyOption {
  String convertString() {
    switch (this) {
      case PrivacyOption.everybody:
        return "Everybody";
      case PrivacyOption.myContacts:
        return "My Contacts";
      case PrivacyOption.nobody:
        return "Nobody";
    }
  }
}

extension AutoDelOptionExtension on AutoDelOption {
  String convertString() {
    switch (this) {
      case AutoDelOption.off:
        return "Off";
      case AutoDelOption.oneDay:
        return "After 1 day";
      case AutoDelOption.oneWeek:
        return "After 1 week";
      case AutoDelOption.oneMonth:
        return "After 1 month";
    }
  }
}

class RadioTile extends StatelessWidget {
  final UserSettingsState state;
  final String label;
  final String groupValue;
  final ValueChanged<String?> onChanged;
  const RadioTile({
    super.key,
    required this.label,
    required this.groupValue,
    required this.state,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      title: Text(
        label,
        style: Theme.of(context).textTheme.titleSmall,
      ),
      activeColor: AppColors.lightBlueColor,
      value: label,
      groupValue: groupValue,
      onChanged: onChanged,
    );
  }
}
