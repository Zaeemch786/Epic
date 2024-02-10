import 'package:intl/intl.dart';

class TFormatter {
  static String formData(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(
      locale: 'en_us',
      symbol: '\$',
    ).format(amount);
  }

  static String formatePhoneNumber(String phoneNumer) {
    if (phoneNumer.length == 10) {
      return '(${phoneNumer.substring(0, 3)})${phoneNumer.substring(3, 6)}${phoneNumer.substring(6)}';
    } else if (phoneNumer.length == 11) {
      return '(${phoneNumer.substring(0, 4)})${phoneNumer.substring(4, 7)}${phoneNumer.substring(7)}';
    }
    return phoneNumer;
  }

  static String internationFormatPhoneNumber(String phoneNumber) {
    var digitsOnlu = phoneNumber.replaceAll(RegExp(r'\D'), '');
    String countryCode = '+${digitsOnlu.substring(0, 2)}';
    digitsOnlu = digitsOnlu.substring(2);

    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode)');
    int i = 0;
    while (i < digitsOnlu.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+1') {
        groupLength = 3;
      }
      int end = i + groupLength;
      formattedNumber.write(digitsOnlu.substring(i, end));
      if (end < digitsOnlu.length) {
        formattedNumber.write(' ');
      }
      i = end;
    }
    return phoneNumber;
  }
}
