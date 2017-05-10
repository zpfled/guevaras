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

  $scope.initializeMenus = function (menuItems) {
    $scope.menus = _.uniq(_.pluck(menuItems, 'menu'));
    $scope.menuItems = menuItems;
    return true;
  };

  $scope.isSelectedMenu = function (menu) {
    return $scope.selected_menu === menu;
  };

  $scope.logError = function (response) {
    console.error('failed', response);
    return false;
  };

  $scope.selectMenu = function (menu) {
    $scope.selected_menu = menu;
    return menu;
  };

  ChezApi.getMenuItems().then(
    $scope.initializeMenus,
    $scope.logError
  );
}]);