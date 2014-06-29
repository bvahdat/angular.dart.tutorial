library main_test;

import 'package:unittest/unittest.dart';
import 'package:di/di.dart';
import 'package:angular/angular.dart';
import 'package:angular/mock/module.dart';
import 'package:angular_dart_demo/recipe_book.dart';
import 'package:angular_dart_demo/formatter/category_filter.dart';
import 'package:angular_dart_demo/formatter/fahrenheit_to_celsius_filter.dart';
import 'package:angular_dart_demo/formatter/multiplier_filter.dart';
import 'package:angular_dart_demo/formatter/sugar_filter.dart';
import 'package:angular_dart_demo/rating/rating_component.dart';
import 'package:angular_dart_demo/service/recipe.dart';
import 'package:angular_dart_demo/util/util.dart';

import '../web/main.dart';

main() {
  setUp(() {
   setUpInjector();
   module((Module m) => m.install(new MyAppModule()));
  });
  tearDown(tearDownInjector);

  group('recipe-book', () {
    test('should load recipes', async(inject((Injector injector,
                                              MockHttpBackend backend) {
      backend.expectGET('recipes.json').respond('''
[
  {
    "id": "1",
    "name": "foo",
    "category": "Appetizers",
    "ingredients": {
        "mushrooms": "12",
        "oz bleu cheese": "8"
    },
    "directions": "some text",
    "rating": 1,
    "imgUrl": "noop.jpg"
  }
]
''');
      backend.expectGET('categories.json').respond('["c1"]');

      var recipesController = injector.get(RecipeBookController);
      expect(recipesController.allRecipes, isEmpty);

      microLeap();
      backend.flush();
      microLeap();

      expect(recipesController.allRecipes, isNot(isEmpty));
    })));

    test('should select recipe', async(inject((Injector injector,
                                               MockHttpBackend backend) {
      backend.expectGET('recipes.json').respond('''
[
  {
    "id": "2",
    "name": "bar",
    "category": "Another Appetizers",
    "ingredients": {
        "mushrooms": "7",
        "oz bleu cheese": "3"
    },
    "directions": "some other text",
    "rating": 2,
    "imgUrl": "noop2.jpg"
  }
]
''');
      backend.expectGET('categories.json').respond('["c1"]');

      var recipesController = injector.get(RecipeBookController);
      expect(recipesController.allRecipes, isEmpty);

      microLeap();
      backend.flush();
      microLeap();

      var recipe = recipesController.allRecipes[0];
      recipesController.selectRecipe(recipe);
      expect(recipesController.selectedRecipe, same(recipe));
    })));
  });

  group('rating component', () {
    test('should show the right number of stars',
        inject((RatingComponent rating) {
      rating.maxRating = '5';
      expect(rating.stars, equals([1, 2, 3, 4, 5]));
    }));

    test('should handle click', inject((RatingComponent rating) {
      rating.maxRating = '5';
      rating.handleClick(3);
      expect(rating.rating, equals(3));

      rating.handleClick(1);
      expect(rating.rating, equals(1));

      rating.handleClick(1);
      expect(rating.rating, equals(0));

      rating.handleClick(1);
      expect(rating.rating, equals(1));
    }));
  });

  group('categoryFilter', () {
    test('should return subset', inject((CategoryFilter filter) {
      var r1 = new Recipe(null, null, 'C1', null, null, null, null);
      var r2 = new Recipe(null, null, 'C2', null, null, null, null);
      var list = [r1, r2];
      var map = {'C1': false, 'C2': true};
      expect(filter(list, map), equals([r2]));
    }));
  });

  group('ftocfilter', () {
    test('should convert if pattern found and applyFtoCFilter is true', inject((FtoCFilter filter) {
      expect(filter('Preheat oven to 250 degrees F. Clean the mushrooms.', true), equals('Preheat oven to 121 degrees C. Clean the mushrooms.'));
      expect(filter('Preheat oven to 350 degrees F.', true), equals('Preheat oven to 177 degrees C.'));
    }));
    test('should not convert if pattern not found or applyFtoCFilter is false', inject((FtoCFilter filter) {
      expect(filter('Preheat oven to 250 degrees F. Clean the mushrooms.', false), equals('Preheat oven to 250 degrees F. Clean the mushrooms.'));
      expect(filter('Preheat oven to 250 degree F. Clean the mushrooms.', true), equals('Preheat oven to 250 degree F. Clean the mushrooms.'));
      expect(filter('Preheat oven to 250 degrees F Clean the mushrooms.', true), equals('Preheat oven to 250 degrees F Clean the mushrooms.'));
      expect(filter('Cook and drain the beans.', true), equals('Cook and drain the beans.'));
      expect(filter('Cook and drain the beans.', false), equals('Cook and drain the beans.'));
    }));
  });

  group('multiplierfilter', () {
    test('should multiply correctly if number', inject((MultiplierFilter filter) {
      expect(filter('3', 7), equals('21.00'));
      expect(filter('0.25', 3), equals('0.75'));
      expect(filter('1.3', 4), equals('5.20'));
      expect(filter('2.13', 2), equals('4.26'));
    }));
    test('should not touch if not number', inject((MultiplierFilter filter) {
      expect(filter('1.4s', 2), equals('1.4s'));
      expect(filter('3x45', 3), equals('3x45'));
      expect(filter('25A', 2), equals('25A'));
      expect(filter('AbC', 4), equals('AbC'));
    }));
  });

  group('sugarfilter', () {
    test('should change to maple syrup if applySugarFilter is true', inject((SugarFilter filter) {
      expect(filter('cups powdered sugar, divided', true), equals('cups maple syrup, divided'));
      expect(filter('some sugar and again cups powdered sugar, yeah this is yummy', true), equals('some maple syrup and again cups maple syrup, yeah this is yummy'));
    }));
    test('should not touch if pattern not found or applySugarFilter is false', inject((SugarFilter filter) {
      expect(filter('cups powdered sugar, divided', false), equals('cups powdered sugar, divided'));
      expect(filter('some sugar and cups powdered sugar, divided', false), equals('some sugar and cups powdered sugar, divided'));
      expect(filter('some of this and cups of that, divided', true), equals('some of this and cups of that, divided'));
    }));
  });

  group('number recognition', () {
    test('should properly identify if numbers', () {
      expect(isNumber('.0329'), isTrue);
      expect(isNumber('715'), isTrue);
      expect(isNumber('39.435'), isTrue);
    });
    test('should not identify if no numbers', () {
      expect(isNumber('.032S9'), isFalse);
      expect(isNumber('34X5'), isFalse);
      expect(isNumber('34R'), isFalse);
      expect(isNumber('12.4z35'), isFalse);
      expect(isNumber('12x.435'), isFalse);
    });
  });
}
