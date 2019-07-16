import 'package:AboutYouDemo/Styles/Constants.dart';
import 'package:AboutYouDemo/Helpers/Enums.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class StringLocalizations {
  static StringLocalizations of(BuildContext context) {
    return Localizations.of<StringLocalizations>(context, StringLocalizations);
  }

  static Locale get appLocale => Locale('en-US', 'DE');

  static String get appTitle => Intl.message(
    'ABOUT YOU',
    args: [],
  );

  static String get appTitleFirst => Intl.message(
    'ABOUT',
    args: [],
  );

  static String get appTitleSecond => Intl.message(
    'YOU',
    args: [],
  );

  static String get appSubtitle => Intl.message(
    'Demo',
    args: [],
  );

  static String get filterTitle => Intl.message(
    'Filters',
    args: [],
  );

  static String get filterPriceHighest => Intl.message(
    'Highest Price',
    args: [],
  );

  static String get filterPriceLowest => Intl.message(
    'Lowest Price',
    args: [],
  );

  static String get filterColor => Intl.message(
    'Color',
    args: [],
  );

  static String get filterButtonText => Intl.message(
    'Show All Results',
    args: [],
  );

  static Map<ColorType, String> get filterColorStringMap => 
  {
    ColorType.black: 'Black',
    ColorType.white: 'White',
    ColorType.blue: 'Blue',
    ColorType.gray: 'Gray',
    ColorType.pink: 'Pink'
  };

  static Map<ColorType, String> get filterColorCodeMap => 
  {
    ColorType.black: '38932',
    ColorType.white: '38935',
    ColorType.blue: '38920',
    ColorType.gray: '38925',
    ColorType.pink: '38930'
  };

  static Map<ColorType, Color> get filterColorMap => 
  {
    ColorType.black: Constants.materialBlack,
    ColorType.white: Constants.materialWhite,
    ColorType.blue: Constants.materialBlue,
    ColorType.gray: Constants.materialGray,
    ColorType.pink: Constants.materialPink
  };

  static Map<int, ResponseCode> get httpResponseMap => 
  {
    400: ResponseCode.BadRequest,
    403: ResponseCode.Forbidden,
    404: ResponseCode.NotFound,
    429: ResponseCode.TooManyRequests,
    500: ResponseCode.InternalServerError
  };

  static String get retryText => Intl.message(
    'Try Again',
    args: [],
  );

  static String get authorName => Intl.message(
    'Sean McCalgan',
    args: [],
  );
}