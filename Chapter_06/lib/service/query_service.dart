library query_service;

import 'dart:async';
import 'dart:convert';
import 'dart:html';

import 'recipe.dart';
import 'package:angular/angular.dart';

@Injectable()
class QueryService {
  String _recipesUrl = 'recipes.json';
  String _categoriesUrl = 'categories.json';
  JsonEncoder encoder;

  Future _loaded;

  Map<String, Recipe> _recipesCache;
  List<String> _categoriesCache;
  String _lastId;

  final Http _http;

  QueryService(Http this._http) {
    encoder = new JsonEncoder.withIndent("  ");
    _loaded = Future.wait([_loadRecipes(), _loadCategories()]);
  }

  Future _loadRecipes() {
    return _http.get(_recipesUrl)
      .then((HttpResponse response) {
        _recipesCache = new Map<String, Recipe>();
        for (Map recipe in response.data) {
          Recipe r = new Recipe.fromJson(recipe);
          _recipesCache[r.id] = r;

          // update the last id we've got so far
          if (_lastId == null || int.parse(r.id) > int.parse(_lastId)) {
            _lastId = r.id;
          }
        }
      });
  }

  Future _loadCategories() {
    return _http.get(_categoriesUrl).then((HttpResponse response) {
      _categoriesCache = response.data;
    });
  }

  Future<Recipe> getRecipeById(String id) {
    return _recipesCache == null
        ? _loaded.then((_) => _recipesCache[id])
        : new Future.value(_recipesCache[id]);
  }

  Future<Map<String, Recipe>> getAllRecipes() {
    return _recipesCache == null
        ? _loaded.then((_) => _recipesCache)
        : new Future.value(_recipesCache);
  }

  Future<List<String>> getAllCategories() {
    return _categoriesCache == null
        ? _loaded.then((_) => _categoriesCache)
        : new Future.value(_categoriesCache);
  }

  addRecipe(Recipe recipe) {
    // inc the max id we've got so far
    _lastId = (int.parse(_lastId) + 1).toString();
    recipe.id = _lastId;

    _updateBackendWith(recipe);
  }

  saveRecipe(Recipe recipe) {
    _updateBackendWith(recipe);
  }

  _updateBackendWith(Recipe recipe) {
    _recipesCache[recipe.id] = recipe;

    // see https://code.google.com/p/dart/issues/detail?id=10525
    String recipes = encoder.convert(_recipesCache.values.toList());
    _http.put('http://127.0.0.1:3031/recipes.json', recipes)
      .then((HttpResponse response) {
        window.console.log('saved $recipes with the status $response');
    });
  }

}
