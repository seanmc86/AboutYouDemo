import 'package:AboutYouDemo/Helpers/StringLocalizations.dart';
import 'package:intl/intl.dart';

class Converters {
  static String currencyToStringLocalization(String currencyCode, num amount) {
    NumberFormat formatter = NumberFormat.currency(
      locale: StringLocalizations.appLocale.languageCode, 
      name: currencyCode,
      symbol: "€",
      decimalDigits: 2
    );
    return formatter.format(amount/100);
  }
}