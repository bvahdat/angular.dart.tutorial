library recipe_book_controller;

import 'package:angular/angular.dart';

import 'tooltip/tooltip.dart';
import 'service/recipe.dart';
import 'service/query_service.dart';

@Controller(
    selector: '[recipe-book]',
    publishAs: 'ctrl')
class RecipeBookController {

  static const String LOADING_MESSAGE = "Loading recipe book...";
  static const String ERROR_MESSAGE = "Sorry! The cook stepped out of the"
      "kitchen and took the recipe book with him!";

  final Http _http;
  final QueryService queryService;

  // Determine the initial load state of the app
  String message = LOADING_MESSAGE;
  bool recipesLoaded = false;
  bool categoriesLoaded = false;

  // Data objects that are loaded from the server side via json
  List<String> _categories = [];
  List<String> get categories => _categories;

  Map<String, Recipe> _recipeMap = {};
  Map<String, Recipe> get recipeMap => _recipeMap;
  set recipeMap(Map<String, Recipe> anotherRecipeMap) {
    _loadRecipes(anotherRecipeMap);
  }
  List<Recipe> _allRecipes = [];

  List<Recipe> get allRecipes => _allRecipes;

  // Filter box
  final categoryFilterMap = <String, bool>{};
  String nameFilter = "";

  RecipeBookController(this._http, this.queryService) {
    _loadData();
  }

  Recipe selectedRecipe;

  void selectRecipe(Recipe recipe) {
    selectedRecipe = recipe;
  }

  // Tooltip
  static final _tooltip = new Expando<TooltipModel>();
  TooltipModel tooltipForRecipe(Recipe recipe) {
    if (_tooltip[recipe] == null) {
      _tooltip[recipe] = new TooltipModel(recipe.imgUrl,
          "I don't have a picture of these recipes, "
          "so here's one of my cat instead!",
          80);
    }
    return _tooltip[recipe]; // recipe.tooltip
  }

  void _loadData() {
    queryService.getAllRecipes()
      .then((Map<String, Recipe> backendRecipes) {
        _loadRecipes(backendRecipes);
      })
      .catchError((e) {
        print(e);
        recipesLoaded = false;
        message = ERROR_MESSAGE;
      });

    queryService.getAllCategories()
      .then((List<String> allCategories) {
        _categories = allCategories;
        for (String category in _categories) {
          categoryFilterMap[category] = false;
        }
        categoriesLoaded = true;
      })
      .catchError((e) {
        print(e);
        categoriesLoaded = false;
        message = ERROR_MESSAGE;
      });
  }

  void _loadRecipes(Map<String, Recipe> newRecipeMap) {
    _recipeMap = newRecipeMap;
    _allRecipes = _recipeMap.values.toList();
    recipesLoaded = true;
  }
}
