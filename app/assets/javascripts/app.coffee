website = angular.module('website',[
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

# posts = [
#   {
#     id: 1
#     title: 'Test Post 1'
#   },
#   {
#     id: 2
#     title: 'Test Post 2'
#   },
#   {
#     id: 3
#     title: 'Test Post 3'
#   },
#   {
#     id: 4
#     title: 'Test Post 4'
#   },
# ]

controllers = angular.module('controllers',[])
controllers.controller('PostsController', [ '$scope', '$routeParams', '$location', '$resource',
  ($scope, $routeParams, $location, $resource)->
    $scope.search = (keywords)-> $location.path('/').search('keywords', keywords)

    if $routeParams.keywords
      keywords = $routeParams.keywords.toLowerCase()
      $scope.posts = posts.filter (post)-> post.name.toLowerCase().indexOf(keywords) != -1
    else
      $scope.posts = []
])
