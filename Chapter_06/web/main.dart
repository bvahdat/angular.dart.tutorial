library recipe_book;

import 'package:angular/angular.dart';
import 'package:angular/application_factory.dart';
import 'package:logging/logging.dart';

import 'package:angular_dart_demo/recipe_book.dart';
import 'package:angular_dart_demo/formatter/category_filter.dart';
import 'package:angular_dart_demo/formatter/fahrenheit_to_celsius_filter.dart';
import 'package:angular_dart_demo/formatter/multiplier_filter.dart';
import 'package:angular_dart_demo/formatter/sugar_filter.dart';
import 'package:angular_dart_demo/rating/rating_component.dart';
import 'package:angular_dart_demo/tooltip/tooltip.dart';
import 'package:angular_dart_demo/service/query_service.dart';
import 'package:angular_dart_demo/routing/recipe_book_router.dart';
import 'package:angular_dart_demo/component/add_recipe_component.dart';
import 'package:angular_dart_demo/component/edit_recipe_component.dart';
import 'package:angular_dart_demo/component/view_recipe_component.dart';
import 'package:angular_dart_demo/component/search_recipe_component.dart';

class MyAppModule extends Module {
  MyAppModule() {
    bind(RecipeBookController);
    bind(Tooltip);
    bind(CategoryFilter);
    bind(FtoCFilter);
    bind(MultiplierFilter);
    bind(SugarFilter);
    bind(AddRecipeComponent);
    bind(EditRecipeComponent);
    bind(RatingComponent);
    bind(SearchRecipeComponent);
    bind(ViewRecipeComponent);
    bind(QueryService);
    bind(RouteInitializerFn, toValue : recipeBookRouteInitializer);
    bind(NgRoutingUsePushState, toFactory: (_) => new NgRoutingUsePushState.value(false));
  }
}

void main() {
  Logger.root..level = Level.FINEST
             ..onRecord.listen((LogRecord r) { print(r.message); });
  applicationFactory()
      .addModule(new MyAppModule())
      .run();
}
