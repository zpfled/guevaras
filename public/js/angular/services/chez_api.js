angular.module('twochez').service('ChezApi', [
  '$http',
  '$q',
  function(
    $http,
    $q
  ) {

  'use strict';
  this.base_url = 'api/v1/'

  this.get_menu_items = function (menu) {
    if (menu) {
      return $http.get(this.base_url + 'menu_items/' + menu.split(' ').join('_'));
    } else {
      return $http.get(this.base_url + 'menu_items');
    };
  }

  return this;
}]);