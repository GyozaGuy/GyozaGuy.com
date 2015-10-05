website = angular.module('website', [
  'templates',
  'ngRoute',
  'ngResource'
  'controllers',
])

website.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: 'index.html'
        controller: 'PostsController'
      )
])

controllers = angular.module('controllers', [])
