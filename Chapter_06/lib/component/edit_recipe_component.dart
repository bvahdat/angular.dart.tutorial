library edit_recipe_component;

import '../service/recipe.dart';
import '../service/query_service.dart';
import 'package:angular/angular.dart';

@Component(
    selector: 'edit-recipe',
    templateUrl: 'packages/angular_dart_demo/component/edit_recipe_component.html',
    cssUrl: 'packages/angular_dart_demo/component/edit_recipe_component.css',
    publishAs: 'cmp')
class EditRecipeComponent {
  @NgOneWay('categories')
  List<String> categories;

  @NgOneWay('recipe-map')
  Map<String, Recipe> recipeMap;

  final QueryService queryService;
  String _recipeId;

  Recipe get recipe => recipeMap == null ? null : recipeMap[_recipeId];

  String anotherIngredientName = '';
  String anotherIngredientAmount = '';

  EditRecipeComponent(RouteProvider routeProvider, this.queryService) {
    _recipeId = routeProvider.parameters['recipeId'];
  }

  addIngredient() {
    anotherIngredientName = anotherIngredientName.trim();
    anotherIngredientAmount = anotherIngredientAmount.trim();

    if (anotherIngredientName.isEmpty) {
      return;
    }

    recipe.ingredients[anotherIngredientName] = anotherIngredientAmount;
    anotherIngredientName = anotherIngredientAmount = '';
  }

  removeIngredient(String ingredient) {
    recipe.ingredients.remove(ingredient);
  }

  void saveRecipe() {
   queryService.saveRecipe(recipe);
  }

}
