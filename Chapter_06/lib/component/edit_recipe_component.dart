library edit_recipe_component;

import '../service/recipe.dart';
import '../service/query_service.dart';
import '../util/util.dart';
import 'package:angular/angular.dart';

@Component(
    selector: 'edit-recipe',
    templateUrl: 'packages/angular_dart_demo/component/edit_recipe_component.html',
    cssUrl: 'packages/angular_dart_demo/component/edit_recipe_component.css',
    publishAs: 'cmp')
class EditRecipeComponent {
  @NgOneWay('categories')
  List<String> categories;

  @NgTwoWay('recipe-map')
  Map<String, Recipe> recipeMap;

  final QueryService queryService;
  String _recipeId;

  // a copy of the current Recipe the user wants to edit (which he will probably cancel/undo)
  Recipe _recipeCopy;

  Recipe get recipe {
    if (recipeMap == null) {
      return null;
    }

    if (_recipeCopy == null) {
      // let the user to edit a clone of the current recipe (and not the current recipe itself)
      _recipeCopy = recipeMap[_recipeId].copyOf();
    }

    return _recipeCopy;
  }

  Map<String, String> newIngredient;

  EditRecipeComponent(RouteProvider routeProvider, this.queryService) {
    _recipeId = routeProvider.parameters['recipeId'];
    newIngredient = getIngredientInputs();
  }

  addIngredient() {
    addIngredientTo(recipe, newIngredient);
  }

  removeIngredient(String ingredient) {
    removeIngredientFrom(recipe, ingredient);
  }

  void saveRecipe() {
   // commit the pending changes both into the memory as well as the back-end
   recipeMap[_recipeId] = _recipeCopy;
   queryService.saveRecipe(recipe);
  }

}
