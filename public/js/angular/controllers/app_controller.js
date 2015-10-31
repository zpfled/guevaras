angular.module('twochez').controller('AppController', [
  '$scope',
  'MediaQueryService',
  function (
    $scope,
    MediaQueryService
  ) {

  'use strict';

  $scope.device = MediaQueryService;
}]);