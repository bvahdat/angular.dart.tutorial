library recipe;

class Recipe {
  String id;
  String name;
  String category;
  Map<String, String> ingredients;
  Iterable<String> _names;
  Iterable<String> _amounts;
  String directions;
  int rating;
  String imgUrl;

  Recipe(this.id, this.name, this.category, this.ingredients, this.directions, this.rating, this.imgUrl);

  Iterable<String> get ingredientNames {
    if (_names == null) {
      _names = ingredients.keys;
    }

    return _names;
  }

  Iterable<String> get ingredientAmounts {
    if (_amounts == null) {
      _amounts = ingredients.values;
    }

    return _amounts;
  }

  Map<String, dynamic> toJson() => <String, dynamic> {
    "id": id,
    "name": name,
    "category": category,
    "ingredients": ingredients,
    "directions": directions,
    "rating": rating,
    "imgUrl": imgUrl
  };

  Recipe.fromJson(Map<String, dynamic> json) : this(json['id'], json['name'], json['category'], json['ingredients'], json['directions'], json['rating'], json['imgUrl']);
}
