website = angular.module('website', [
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

website.config([ '$routeProvider',
  ($routeProvider)->
    $routeProvider
      .when('/',
        templateUrl: 'index.html'
        controller: 'PostsController'
      ).when('/posts/:postId',
        templateUrl: 'show.html'
        controller: 'PostController'
      )
])

controllers = angular.module('controllers', [])
