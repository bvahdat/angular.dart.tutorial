library recipe_book_routing;

import 'package:angular/angular.dart';
import 'dart:async';
import 'dart:html';

void recipeBookRouteInitializer(Router router, RouteViewFactory views) {
  views.configure({
    'add': ngRoute(
        path: '/add',
        view: 'view/addRecipe.html',
        preLeave: (RoutePreLeaveEvent e) {
          bool trash = window.confirm('Your recipe has not been persisted on the back-end yet! Do you want to trash this receipe?');
          e.allowLeave(new Future.value(trash));
        }),
    'recipe': ngRoute(
        path: '/recipe/:recipeId',
        mount: {
          'view': ngRoute(
              path: '/view',
              view: 'view/viewRecipe.html'),
          'edit': ngRoute(
              path: '/edit',
              view: 'view/editRecipe.html',
              preLeave: (RoutePreLeaveEvent e) {
                bool trash = window.confirm('You have unsaved changes on this recipe! Do you want to trash them?');
                e.allowLeave(new Future.value(trash));
              }),
          'view_default': ngRoute(
              defaultRoute: true,
              enter: (RouteEnterEvent e) =>
                  router.go('view', {},
                      startingFrom: router.root.findRoute('recipe'),
                      replace: true))
        })
  });
}