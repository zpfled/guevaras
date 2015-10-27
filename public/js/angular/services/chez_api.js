angular.module('twochez').service('ChezApi', [
  '$http',
  '$q',
  function(
    $http,
    $q
  ) {

  'use strict';
  this.base_url = 'api/v1/'

  this.get_menu_items = function () {
    return $http.get(this.base_url + 'menu_items');
  }

  return this;
}]);