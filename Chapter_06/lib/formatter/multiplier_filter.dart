library multiplier_filter;

import 'package:angular/angular.dart';
import 'package:logging/logging.dart';
import '../util/util.dart';

@Formatter(name: 'multiplierfilter')
class MultiplierFilter {

  Logger _logger = new Logger('MultiplierFilter');

  call(text, multiplier) {
    if (text is String && isNumber(text) && multiplier is int) {
      text = double.parse(text) * multiplier;

      // avoid long fraction digits
      return text.toStringAsFixed(2);
    }

    _logger.warning('ignoring \'$text\' not being a number!');
    return text;
  }

}
