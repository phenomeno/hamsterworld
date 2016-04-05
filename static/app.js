var app = angular.module('hamsterworld', ['ngRoute', 'ui.bootstrap', 'colorpicker.module']).config(function($routeProvider, $locationProvider) {
  $routeProvider.
  when('/', {
    templateUrl: '/partials/main.html',
    controller: 'MainController'
  }).
  otherwise({
    redirectTo: '/'
  });

  $locationProvider.html5Mode(true);
});
