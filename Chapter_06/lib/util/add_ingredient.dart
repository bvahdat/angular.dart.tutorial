import '../service/recipe.dart';

const String _DEFAULT_INGREDIENT_NAME = 'Type the ingredient here!';
const String _DEFAULT_INGREDIENT_AMOUNT = 'Type the amount here!';


addIngredientFor(Recipe recipe, [Map<String, String> newIngredient]) {
  String ingredientName = newIngredient['name'].trim();
  String ingredientAmount = newIngredient['amount'].trim();

  if (ingredientName == _DEFAULT_INGREDIENT_NAME) {
    return;
  }

  if (ingredientAmount == _DEFAULT_INGREDIENT_AMOUNT) {
    ingredientAmount = "";
  }

  recipe.ingredients[ingredientName] = ingredientAmount;

  newIngredient = getIngredientInputs();
}

Map<String, String> getIngredientInputs() {
  return new Map()
      ..['name'] = _DEFAULT_INGREDIENT_NAME
      ..['amount'] = _DEFAULT_INGREDIENT_AMOUNT;
}
