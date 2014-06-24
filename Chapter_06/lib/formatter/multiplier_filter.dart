library multiplier_filter;

import 'package:angular/angular.dart';

@Formatter(name: 'multiplierfilter')
class MultiplierFilter {
  call(number, multiplier) {
    if (number is String && !number.isEmpty && multiplier is int) {
      number = double.parse(number) * multiplier;

      // avoid long fraction digits
      return number.toStringAsFixed(2);
    }

    return number;
  }

}
