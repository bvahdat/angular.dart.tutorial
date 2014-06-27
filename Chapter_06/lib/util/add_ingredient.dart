import '../service/recipe.dart';

const String _DEFAULT_INGREDIENT_NAME = 'Type the ingredient here!';
const String _DEFAULT_INGREDIENT_AMOUNT = 'Type the amount here!';

addIngredientFor(Recipe recipe, Map<String, String> newIngredient) {
  String ingredientName = newIngredient['name'].trim();
  String ingredientAmount = newIngredient['amount'].trim();

  if (ingredientName == _DEFAULT_INGREDIENT_NAME) {
    return;
  }

  if (ingredientAmount == _DEFAULT_INGREDIENT_AMOUNT) {
    ingredientAmount = '';
  }

  recipe.ingredients[ingredientName] = ingredientAmount;

  // reset the map for the next user input
  _reset(newIngredient);
}

Map<String, String> getIngredientInputs() => _reset(new Map<String, String>());

_reset(Map<String, String> tuple) => tuple
    ..clear()
    ..['name'] = _DEFAULT_INGREDIENT_NAME
    ..['amount'] = _DEFAULT_INGREDIENT_AMOUNT;
