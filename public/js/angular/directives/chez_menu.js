angular.module('twochez').directive('chezmenu', [
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

    scope.init = function () {
      scope.menu = _.where(scope.menuItems, { menu: scope.menuName });
      scope.categories = _.uniq(_.pluck(scope.menu, 'category'));
    };

    scope.sortedBy = function (category) {
      return _.where(scope.menu, { category: category });
    };

    scope.init();
  };

  // Directive
  return {
    scope: {
      menuItems: '=',
      menuName: '@'
    },
    restrict: 'E',
    link: link,
    template: '<section ng-class="{\'chezmenu--bg\': device.isDesktop()}">' +
                '<div class="chezmenu--scrim scrim row mg-top-near mg-bottom-near">' +
                    '<ul class="chezmenu--ul pd-near" ng-repeat="category in categories">' +
                      '<h3 class="chezmenu--section mg-bottom-near">' +
                        '{{ category | stripDashes }}' +
                      '</h3>' +
                      '<li class="chezmenu--li" ng-repeat="item in sortedBy(category)">' +
                        '<h5 class="chezmenu--name">' +
                          '{{ item.name }}' +
                          '<span class="right">' +
                            '{{ item.price }}' +
                          '</span>' +
                        '</h5>' +
                        '<p class="light-gray t-italics">' +
                          '{{ item.description }}' +
                        '</p>' +
                      '</li>' +
                    '</ul>' +
                  '</div>' +
                '</section>'
  };
}]);