import 'package:intl/intl.dart';

class TAppFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();

    return DateFormat('HH:mm').format(date);
  }

  static String FormateCurrency(double value) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(value);
  }

  static String formatePhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return ' ${phoneNumber.substring(0, 3)} + '
          ' + ${phoneNumber.substring(3, 6)} + '
          ' + ${phoneNumber.substring(6, 10)}';
    } else {
      return phoneNumber.replaceAllMapped(
          RegExp(r".{1,3}"), (match) => "${match.group(0)} ");
    }
  }

  static String internationalFomratePhoneNumber(String phoneNumber) {
    //remove any non digit
    phoneNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    //extract the country code

    String countryCode = '+${phoneNumber.substring(0, 2)}';
    phoneNumber = phoneNumber.substring(2);

    //return the formated phone number
    return '$countryCode ${formatePhoneNumber(phoneNumber)}';
  }
}
