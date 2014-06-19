library multiplier_filter;

import 'package:angular/angular.dart';

@Formatter(name: 'multiplierfilter')
class MultiplierFilter {
  call(text, multiplier) {
    if (text is String && !text.isEmpty && multiplier is int) {
      return double.parse(text) * multiplier;
    }

    return text;
  }

}
