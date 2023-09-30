import 'package:flutter/material.dart';
import 'package:phone_form_field/src/helpers/country_finder.dart';
import 'package:phone_numbers_parser/phone_numbers_parser.dart';

import '../models/country.dart';

class CountryCodeChip extends StatelessWidget {
  final Country country;
  final bool showFlag;
  final bool showDialCode;
  final TextStyle textStyle;
  final EdgeInsets padding;
  final TextStyle? flagStyle;
  final TextDirection? textDirection;

  CountryCodeChip({
    Key? key,
    required IsoCode isoCode,
    this.textStyle = const TextStyle(),
    this.showFlag = true,
    this.showDialCode = true,
    this.padding = const EdgeInsets.all(20),
    this.flagStyle,
    this.textDirection,
  })  : country = Country(isoCode, ''),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
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
