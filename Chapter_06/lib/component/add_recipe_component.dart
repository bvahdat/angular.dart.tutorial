library add_recipe_component;

import '../service/recipe.dart';
import '../service/query_service.dart';
import '../util/add_ingredient.dart';
import 'package:angular/angular.dart';
import 'dart:collection';

@Component(
    selector: 'add-recipe',
    templateUrl: 'packages/angular_dart_demo/component/add_recipe_component.html',
    cssUrl: 'packages/angular_dart_demo/component/add_recipe_component.css',
    publishAs: 'cmp')
class AddRecipeComponent {
  @NgOneWay('categories')
  List<String> categories;

  final QueryService queryService;

  Map<String, String> newIngredient;
  Recipe recipe;

  AddRecipeComponent(this.queryService) {
    recipe = new Recipe(null, "The recipe name", "The category name", new LinkedHashMap<String, String>(), "The recipe directions", 0, "fonzie1.jpg");
    newIngredient = getIngredientInputs();
  }

  void addIngredient() {
    addIngredientFor(recipe, newIngredient);
    newIngredient = getIngredientInputs();
   }

  void addRecipe() {
    // the Id property is set through the queryService itself
    queryService.addRecipe(recipe);
  }

}
