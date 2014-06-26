library add_recipe_component;

import '../service/recipe.dart';
import '../service/query_service.dart';
import 'package:angular/angular.dart';
import 'dart:collection';

@Component(
    selector: 'add-recipe',
    templateUrl: 'packages/angular_dart_demo/component/add_recipe_component.html',
    cssUrl: 'packages/angular_dart_demo/component/add_recipe_component.css',
    publishAs: 'cmp')
class AddRecipeComponent {
  static const String _DEFAULT_INGREDIENT_AMOUNT = "Type the amount here!";
  static const String _DEFAULT_INGREDIENT_NAME = "Type the ingredient here!";

  List<String> _allCategories;

  @NgOneWay('all-categories')
  List<String> get allCategories => _allCategories == null ? throw 'unexpected null value for _allCategories!' : _allCategories;
  void set allCategories(List<String> values) {
    _allCategories = values;
  }

  final QueryService queryService;

  String ingredientName;
  String ingredientAmount;
  Recipe recipe;

  AddRecipeComponent(this.queryService) {
    _resetTextInputs();
    recipe = new Recipe(null, "The recipe name", "The category name", new LinkedHashMap<String, String>(), "The recipe directions", 0, "fonzie1.jpg");
  }

  void addIngredient() {
    if (ingredientAmount == _DEFAULT_INGREDIENT_AMOUNT) {
      // -1 means this ingredient lacks a unit of measurement
      ingredientAmount = "-1";
    }

     recipe.ingredients[ingredientName] = ingredientAmount;
     _resetTextInputs();
   }

  void addRecipe() {
    // the Id property is set through the queryService itself
    queryService.addRecipe(recipe);
  }

  void _resetTextInputs() {
    ingredientName = _DEFAULT_INGREDIENT_NAME;
    ingredientAmount = _DEFAULT_INGREDIENT_AMOUNT;
  }

}
