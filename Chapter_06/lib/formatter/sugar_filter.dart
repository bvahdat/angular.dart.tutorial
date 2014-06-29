library sugar_filter;

import 'package:angular/angular.dart';

@Formatter(name: 'sugarfilter')
class SugarFilter {
  call(text, applySugarFilter) {
    if (applySugarFilter) {
      if (text is String) {
        return _replaceAll(text);
      } else if (text is Iterable<String>) {
        return text.map(_replaceAll);
      }
    }

    return text;
  }

  _replaceAll(String text) =>
  // should first replace all the 'powdered sugar' patterns BEFORE replacing the 'sugar' ones
  text.replaceAll('powdered sugar', 'maple syrup').replaceAll('sugar', 'maple syrup');

}
