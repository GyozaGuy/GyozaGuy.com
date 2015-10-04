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

controllers = angular.module('controllers',[])
controllers.controller('PostsController', [ '$scope', '$routeParams', '$location', '$resource',
  ($scope, $routeParams, $location, $resource)->
    $scope.search = (keywords)-> $location.path('/').search('keywords', keywords)
    Post = $resource('/posts/:postId', { postId: "@id", format: 'json' })

    if $routeParams.keywords
      # keywords = $routeParams.keywords.toLowerCase()
      # $scope.recipes = recipes.filter (recipe)-> recipe.name.toLowerCase().indexOf(keywords) != -1
      Post.query(keywords: $routeParams.keywords, (results)-> $scope.recipes = results)
    else
      $scope.posts = []
])
