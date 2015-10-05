controllers = angular.module('controllers')
controllers.controller('PostsController', ['$scope', '$routeParams', '$location', '$resource',
  ($scope, $routeParams, $location, $resource)->
    $scope.search = (keywords)-> $location.path('/').search('keywords', keywords)
    Post = $resource('/posts/:postId', { postId: '@id', format: 'json' })

    if $routeParams.keywords
      Post.query(keywords: $routeParams.keywords, (results)-> $scope.posts = results)
    else
      $scope.posts = []
])
