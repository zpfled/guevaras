angular.module('twochez').directive('chezMenu', [
  '$window',
  'ChezApi',
  function (
    $window,
    ChezApi
) {
  'use strict';

  var link = function (scope, element, attrs) {
    scope.menu_items = [];
    scope.categories = ['appetizers']

    scope.by_category = function (menu_item) {
      return true;
    };

    scope.failure = function (response) {
      $window.console.error(response);
      return false;
    };

    scope.set_menu_items = function (response) {
      return scope.menu_items = response.data;
    };

    ChezApi.get_menu_items().then(scope.set_menu_items)

  };

  // Directive
  return {
    scope: {
      type: '@',
    },
    restrict: 'E',
    templateUrl: '/templates/directives/chez_menu.html',
    link: link
  };
}]);
