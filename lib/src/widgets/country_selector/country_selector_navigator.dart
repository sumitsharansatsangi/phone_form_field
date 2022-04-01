import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/all_countries.dart';
import '../../models/country.dart';
import 'country_selector.dart';

abstract class CountrySelectorNavigator {
  final List<Country>? countries;
  final List<String>? favorites;
  final bool addSeparator;
  final bool showCountryCode;
  final bool sortCountries;
  final String? noResultMessage;
  final bool searchAutofocus;

  const CountrySelectorNavigator({
    this.countries,
    this.favorites,
    this.addSeparator = true,
    this.showCountryCode = true,
    this.sortCountries = false,
    this.noResultMessage,
    required this.searchAutofocus,
  });

  Future<Country?> navigate(BuildContext context);

  CountrySelector _getCountrySelector({
    required ValueChanged<Country> onCountrySelected,
    ScrollController? scrollController,
  }) =>
      CountrySelector(
        countries: countries ?? allCountries,
        onCountrySelected: onCountrySelected,
        favoriteCountries: favorites ?? [],
        addFavoritesSeparator: addSeparator,
        showCountryCode: showCountryCode,
        sortCountries: sortCountries,
        noResultMessage: noResultMessage,
        scrollController: scrollController,
        searchAutofocus: searchAutofocus,
      );

  const factory CountrySelectorNavigator.dialog({
    List<Country>? countries,
    List<String>? favorites,
    bool addSeparator,
    bool showCountryCode,
    bool sortCountries,
    String? noResultMessage,
    bool searchAutofocus,
    // ignore: deprecated_member_use_from_same_package
  }) = DialogNavigator;

  const factory CountrySelectorNavigator.bottomSheet({
    List<Country>? countries,
    List<String>? favorites,
    bool addSeparator,
    bool showCountryCode,
    bool sortCountries,
    String? noResultMessage,
    bool searchAutofocus,
    // ignore: deprecated_member_use_from_same_package
  }) = BottomSheetNavigator;

  const factory CountrySelectorNavigator.modalBottomSheet({
    double? height,
    List<Country>? countries,
    List<String>? favorites,
    bool addSeparator,
    bool showCountryCode,
    bool sortCountries,
    String? noResultMessage,
    bool searchAutofocus,
    // ignore: deprecated_member_use_from_same_package
  }) = ModalBottomSheetNavigator;

  const factory CountrySelectorNavigator.draggableBottomSheet({
    double initialChildSize,
    double minChildSize,
    double maxChildSize,
    BorderRadiusGeometry? borderRadius,
    List<Country>? countries,
    List<String>? favorites,
    bool addSeparator,
    bool showCountryCode,
    bool sortCountries,
    String? noResultMessage,
    bool searchAutofocus,
    // ignore: deprecated_member_use_from_same_package
  }) = DraggableModalBottomSheetNavigator;
}

class DialogNavigator extends CountrySelectorNavigator {
  @Deprecated('use CountrySelectorNavigator.dialog() instead')
  const DialogNavigator({
    List<Country>? countries,
    List<String>? favorites,
    bool addSeparator = true,
    bool showCountryCode = true,
    bool sortCountries = false,
    String? noResultMessage,
    bool searchAutofocus = kIsWeb,
  }) : super(
          countries: countries,
          favorites: favorites,
          addSeparator: addSeparator,
          showCountryCode: showCountryCode,
          sortCountries: sortCountries,
          noResultMessage: noResultMessage,
          searchAutofocus: searchAutofocus,
        );

  @override
  Future<Country?> navigate(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => Dialog(
        child: _getCountrySelector(
          onCountrySelected: (country) => Navigator.pop(context, country),
        ),
      ),
    );
  }
}

class BottomSheetNavigator extends CountrySelectorNavigator {
  @Deprecated('use CountrySelectorNavigator.bottomSheet() instead')
  const BottomSheetNavigator({
    List<Country>? countries,
    List<String>? favorites,
    bool addSeparator = true,
    bool showCountryCode = true,
    bool sortCountries = false,
    String? noResultMessage,
    bool searchAutofocus = kIsWeb,
  }) : super(
            countries: countries,
            favorites: favorites,
            addSeparator: addSeparator,
            showCountryCode: showCountryCode,
            sortCountries: sortCountries,
            noResultMessage: noResultMessage,
            searchAutofocus: searchAutofocus);

  @override
  Future<Country?> navigate(BuildContext context) {
    Country? selected;
    final ctrl = showBottomSheet(
      context: context,
      builder: (_) => _getCountrySelector(
        onCountrySelected: (country) {
          selected = country;
          Navigator.pop(context, country);
        },
      ),
    );
    return ctrl.closed.then((_) => selected);
  }
}

class ModalBottomSheetNavigator extends CountrySelectorNavigator {
  final double? height;

  @Deprecated('use CountrySelectorNavigator.modalBottomSheet() instead')
  const ModalBottomSheetNavigator({
    this.height,
    List<Country>? countries,
    List<String>? favorites,
    bool addSeparator = true,
    bool showCountryCode = true,
    bool sortCountries = false,
    String? noResultMessage,
    bool searchAutofocus = kIsWeb,
  }) : super(
            countries: countries,
            favorites: favorites,
            addSeparator: addSeparator,
            showCountryCode: showCountryCode,
            sortCountries: sortCountries,
            noResultMessage: noResultMessage,
            searchAutofocus: searchAutofocus);

  @override
  Future<Country?> navigate(BuildContext context) {
    return showModalBottomSheet<Country>(
      context: context,
      builder: (_) => SizedBox(
        height: height ?? MediaQuery.of(context).size.height - 90,
        child: _getCountrySelector(
          onCountrySelected: (country) => Navigator.pop(context, country),
        ),
      ),
      isScrollControlled: true,
    );
  }
}

class DraggableModalBottomSheetNavigator extends CountrySelectorNavigator {
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final BorderRadiusGeometry? borderRadius;

  @Deprecated('use CountrySelectorNavigator.draggableBottomSheet() instead')
  const DraggableModalBottomSheetNavigator({
    this.initialChildSize = 0.5,
    this.minChildSize = 0.25,
    this.maxChildSize = 0.85,
    this.borderRadius,
    List<Country>? countries,
    List<String>? favorites,
    bool addSeparator = true,
    bool showCountryCode = true,
    bool sortCountries = false,
    String? noResultMessage,
    bool searchAutofocus = kIsWeb,
  }) : super(
            countries: countries,
            favorites: favorites,
            addSeparator: addSeparator,
            showCountryCode: showCountryCode,
            sortCountries: sortCountries,
            noResultMessage: noResultMessage,
            searchAutofocus: searchAutofocus);

  @override
  Future<Country?> navigate(BuildContext context) {
    final effectiveBorderRadius = borderRadius ??
        const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        );
    return showModalBottomSheet<Country>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: effectiveBorderRadius,
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        expand: false,
        builder: (context, scrollController) {
          return Container(
            decoration: ShapeDecoration(
              color: Theme.of(context).canvasColor,
              shape: RoundedRectangleBorder(
                borderRadius: effectiveBorderRadius,
              ),
            ),
            child: _getCountrySelector(
              onCountrySelected: (country) => Navigator.pop(context, country),
              scrollController: scrollController,
            ),
          );
        },
      ),
      isScrollControlled: true,
    );
  }
}