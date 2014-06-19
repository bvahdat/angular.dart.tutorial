library view_recipe_component;

import '../service/recipe.dart';
import 'package:angular/angular.dart';

@Component(
    selector: 'view-recipe',
    templateUrl: 'packages/angular_dart_demo/component/view_recipe_component.html',
    cssUrl: 'packages/angular_dart_demo/component/view_recipe_component.css',
    publishAs: 'cmp')
class ViewRecipeComponent {
  @NgOneWay('recipe-map')
  Map<String, Recipe> recipeMap;

  @NgOneWay('applySugarFilter')
  bool applySugarFilter = false;

  @NgOneWay('applyFtoCFilter')
  bool applyFtoCFilter = false;

  @NgOneWay('multiplier')
  int multiplier = 1;

  String _recipeId;

  Recipe get recipe => recipeMap == null ? null : recipeMap[_recipeId];

  ViewRecipeComponent(RouteProvider routeProvider) {
    _recipeId = routeProvider.parameters['recipeId'];
  }
}
