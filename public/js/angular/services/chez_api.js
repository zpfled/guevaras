angular.module('twochez').service('ChezApi', [ '$q', function($q) {

  'use strict';

  this.getMenuItems = function () {
    console.log('getMenuItems');
    return $q(function (resolve, reject) {
      Tabletop.init({
        key: 'https://docs.google.com/spreadsheets/d/1DEgK3eUSnEjyuCVzCvAlzTXNmCN-5sKR8ihiE2KIJIo/pub?output=csv',
        callback: function(menuItems) {
          resolve(menuItems);
        },
        simpleSheet: true
      });
    });
  };

  return this;
}]);