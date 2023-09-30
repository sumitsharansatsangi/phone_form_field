import 'package:flutter/material.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

import 'country_selector/country.dart';
import 'country_selector/country_finder.dart';

class CountryCodeChip extends StatelessWidget {
  final Country country;
  final bool showFlag;
  final bool showDialCode;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final TextStyle? flagStyle;
  final TextDirection? textDirection;
  final bool showIsoCode;

  CountryCodeChip({
    Key? key,
    required IsoCode isoCode,
    this.textStyle = const TextStyle(),
    this.showFlag = true,
    this.showDialCode = true,
    this.padding = const EdgeInsets.all(20),
    this.flagStyle,
    this.textDirection,
    this.showIsoCode = false,
  })  : country = Country(isoCode, ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (showIsoCode) ...[
          Text(
            country.isoCode.name,
            style: textStyle,
          ),
          const SizedBox(width: 8),
        ],
        if (showFlag) ...[
        Text(
            CountryFinder.generateFlagEmojiUnicode(country.isoCode.name),
            style: flagStyle ?? Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(width: 8),
        ],
        if (showDialCode)
          Text(
            country.displayCountryCode,
            style: textStyle,
            textDirection: textDirection,
          ),
      ],
    );
  }
}
