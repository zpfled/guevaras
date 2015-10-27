angular.module('twochez').service('MediaQueryService', [
  '$window',
  function($window) {
  'use strict';

  this.isMobile = function() {
    return $window.innerWidth <= 320;
  };

  this.isNotMobile = function() {
    return !this.isMobile();
  };

  this.isLandscape = function() {
    return $window.innerWidth > $window.innerHeight;
  };

  this.isDesktop = function() {
    return $window.innerWidth >= 1024;
  };

  this.width = function() {
    return $window.innerWidth;
  };

  return this;
}]);