library ftoc_filter;

import 'package:angular/angular.dart';

@Formatter(name: 'ftocfilter')
class FtoCFilter {
  call(directions, applyFtoCFilter) {
    if (directions is String && applyFtoCFilter) {
      directions = directions.replaceAllMapped(new RegExp('\\d+ degrees F\\.'), (Match match) {
        String input = match.input;
        String substring = input.substring(match.start);
        int firstSpaceIndex = input.length - substring.length + substring.indexOf(' ');
        int fahrenheit = int.parse(input.substring(match.start, firstSpaceIndex));
        int celsius = ((fahrenheit - 32) * 5 / 9).round();
        return '$celsius degrees C.';
      });
    }

    return directions;
  }

}
