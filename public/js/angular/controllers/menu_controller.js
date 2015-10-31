angular.module('twochez').controller('MenuController', [
  '$scope',
  'ChezApi',
  'MediaQueryService',
  function (
    $scope,
    ChezApi,
    MediaQueryService
  ) {

  'use strict';

  $scope.menus = [];
  $scope.selected_menu = MediaQueryService.isDesktop() ? 'dinner' : null;
  $scope.device = MediaQueryService;

  $scope.failure = function (response) {
    $window.console.error(response);
    return false;
  };

  $scope.initialize_menu = function (response) {
    $scope.menus = _.uniq(_.pluck(response.data, 'menu'));
    return true;
  };

  $scope.select_menu = function (menu) {
    $scope.selected_menu = menu;
    return menu;
  };

  $scope.selected_menu_is = function (menu) {
    return $scope.selected_menu === menu;
  };

  ChezApi.get_menu_items().then(
    $scope.initialize_menu,
    $scope.failure
  );
}]);