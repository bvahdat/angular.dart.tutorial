import '../service/recipe.dart';

const String _DEFAULT_INGREDIENT_NAME = 'Type the ingredient here!';
const String _DEFAULT_INGREDIENT_AMOUNT = 'Type the amount here!';

addIngredientTo(Recipe recipe, Map<String, String> newIngredient) {
  String ingredientName = newIngredient['name'].trim();
  String ingredientAmount = newIngredient['amount'].trim();

  if (ingredientName == _DEFAULT_INGREDIENT_NAME || ingredientName.isEmpty) {
    return;
  }

  if (ingredientAmount == _DEFAULT_INGREDIENT_AMOUNT) {
    ingredientAmount = '';
  }

  recipe.ingredients[ingredientName] = ingredientAmount;

  // reset the map for the next user input
  _reset(newIngredient);
}

void removeIngredientFrom(Recipe recipe, String ingredient) {
  recipe.ingredients.remove(ingredient);
}

Map<String, String> getIngredientInputs() => _reset(new Map<String, String>());

_reset(Map<String, String> tuple) => tuple
    ..clear()
    ..['name'] = _DEFAULT_INGREDIENT_NAME
    ..['amount'] = _DEFAULT_INGREDIENT_AMOUNT;

final RegExp _REG_EXP = new RegExp('[0-9]*\\.?[0-9]+');

bool isNumber(String text) {
  if (text == null || text.trim().isEmpty) {
    return false;
  }

  String firstMatch = _REG_EXP.stringMatch(text);

  // the whole string should resolve to a number
  return firstMatch != null && firstMatch == text;
}
