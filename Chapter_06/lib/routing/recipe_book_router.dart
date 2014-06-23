library recipe_book_routing;

import 'package:angular/angular.dart';
import 'dart:async';

void recipeBookRouteInitializer(Router router, RouteViewFactory views) {
  views.configure({
    'add': ngRoute(
        path: '/add',
        view: 'view/addRecipe.html',
        leave: (RouteLeaveEvent e) {
          // TODO: leave() doesn't seem to work, see https://github.com/angular/route.dart/issues/28
          e.allowLeave(new Future.value(false));
        }),
    'recipe': ngRoute(
        path: '/recipe/:recipeId',
        mount: {
          'view': ngRoute(
              path: '/view',
              view: 'view/viewRecipe.html'),
          'edit': ngRoute(
              path: '/edit',
              view: 'view/editRecipe.html'),
          'view_default': ngRoute(
              defaultRoute: true,
              enter: (RouteEnterEvent e) =>
                  router.go('view', {},
                      startingFrom: router.root.findRoute('recipe'),
                      replace: true))
        })
  });
}