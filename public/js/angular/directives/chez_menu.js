angular.module('twochez').directive('chezMenu', [
  '$window',
  'ChezApi',
  'MediaQueryService',
  function (
    $window,
    ChezApi,
    MediaQueryService
) {
  'use strict';

  var link = function (scope, element, attrs) {
    scope.categories = [];
    scope.menu = [];
    scope.device = MediaQueryService;

    scope.failure = function (response) {
      $window.console.error(response);
      return false;
    };

    scope.items_sorted_by = function (category) {
      return _.where(scope.menu, {category: category});
    };

    scope.initialize_menu = function (response) {
      scope.menu = response.data;
      scope.categories = _.uniq(_.pluck(response.data, 'category'));
    };

    ChezApi.get_menu_items(scope.menuName).then(
      scope.initialize_menu,
      scope.failure
    );
  };

  // Directive
  return {
    scope: {
      menuName: '@'
    },
    restrict: 'E',
    templateUrl: '/templates/directives/chez_menu.html',
    link: link
  };
}]);