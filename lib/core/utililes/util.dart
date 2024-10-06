import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Util {
  
  static String formatNumberWithSuffix(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      return '${(number % 1000 == 0) ? number ~/ 1000 : (number / 1000).toStringAsFixed(1)}K';
    } else {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    }
  }

  static String formatDateTime(DateTime dateTime,
      {bool timeOnly = false, bool dateOnly = false}) {
    String displayTime = '';
    final time = dateTime;
    final minuteLength = time.minute.toString().length;
    final minutes =
        minuteLength == 1 ? '0${time.minute}' : time.minute.toString();
    if (time.hour > 12) {
      displayTime = '${time.hour - 12}:${minutes}PM';
    } else {
      displayTime = '${time.hour}:${minutes}AM';
    }
    if (timeOnly) {
      return displayTime;
    }
    if (dateOnly) {
      return '${time.day}/${time.month}/${time.year}';
    }
    return '${time.day}/${time.month}/${time.year} - $displayTime';
  }

  static bool isColorCode(String colorCode) {
    try {
      Color(int.parse(colorCode, radix: 16));
      return true;
    } catch (e) {
      return false;
    }
  }


  static String? colorToHex(Color? color) {
    if (color == null) return null;
    // Extract the RGB values
    int red = color.red;
    int green = color.green;
    int blue = color.blue;

    // Convert the RGB values to hexadecimal and concatenate them
    String hex = '#${red.toRadixString(16).padLeft(2, '0')}'
        '${green.toRadixString(16).padLeft(2, '0')}'
        '${blue.toRadixString(16).padLeft(2, '0')}';

    return hex.toUpperCase(); // Convert to uppercase for consistency
  }



  static double fitFontSizeShrinkFactor(
      String text, int maxChars, double reductionRatio) {
    return text.length > maxChars
        ? 1 - reductionRatio * log(text.length - maxChars)
        : 1;
  }

  static double roundDouble(double value, int places) {
    final mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  static String formatBirthDate(DateTime date) {
    return DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(date.toUtc());
  }

  static String formateToViewBD(String bd) {
    return bd.split('-').first.trim();
  }

//   static bool checkDate(
//     List<int?> inputs, {
//     String? errorTitle,
//     required String errorBody,
//     required BuildContext context,
//   }) {
//     if (inputs.any((input) => input == null || input.isNegative)) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialogWidget(
//             title: errorTitle ?? '',
//             contentText: errorBody,
//           );
//         },
//       );
//       return false;
//     } else {
//       final List<List<int>> ranges = [
//         [1, 31],
//         [1, 12],
//         [1933, 2007]
//       ];
//       for (int i = 0; i < inputs.length; i++) {
//         if (inputs[i]! < ranges[i][0] || inputs[i]! > ranges[i][1]) {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialogWidget(
//                 title: errorTitle ?? '',
//                 contentText: errorBody,
//               );
//             },
//           );
//           return false;
//         }
//       }
//     }
//     return true;
//   }
}
