angular.module('twochez').filter('stripDashes', [
  '$window',
  function (
    $window
  ) {

  'use strict';

  var _stripDashes = function(string) {
    return string.split('-').join(' ');
  };

  var _failure = function (string) {
    $window.console.log('Error stripping dashes from "' + string + '".');
    return string;
  };

  return function (string) {
    try {
      return _stripDashes(string);
    } catch(e) {
      return _failure(string);
    }
  };
}]);