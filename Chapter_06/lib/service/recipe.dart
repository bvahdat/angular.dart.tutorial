library recipe;

class Recipe {
  String id;
  String name;
  String category;
  Map<String, String> ingredients;
  Iterable<String> ingredient;
  Iterable<String> ingredientAmount;
  String directions;
  int rating;
  String imgUrl;

  Recipe(this.id, this.name, this.category, this.ingredients, this.ingredient, this.ingredientAmount, this.directions, this.rating, this.imgUrl);

  Map<String, dynamic> toJson() => <String, dynamic> {
    "id": id,
    "name": name,
    "category": category,
    "ingredients": ingredients,
    "ingredient": ingredients.keys,
    "ingredientAmount": ingredients.values,
    "directions": directions,
    "rating": rating,
    "imgUrl": imgUrl
  };

  Recipe.fromJson(Map<String, dynamic> json) : this(json['id'], json['name'], json['category'], json['ingredients'], (json['ingredients'] as Map).keys, (json['ingredients'] as Map).values, json['directions'], json['rating'], json['imgUrl']);

  ingredientAmountOf(int index) {
    String amount = ingredientAmount.elementAt(index);
    return amount == "-1" ? "" : amount;
  }

}
