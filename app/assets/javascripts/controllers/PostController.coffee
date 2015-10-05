controllers = angular.module('controllers')
controllers.controller('PostController', ['$scope', '$routeParams', '$resource', 'flash',
  ($scope, $routeParams, $resource, flash)->
    Post = $resource('/posts/:postId', { postId: '@id', format: 'json' })

    Post.get({postId: $routeParams.postId},
      ((post)-> $scope.post = post),
      ((httpResponse)->
        $scope.post = null
        flash.error = "There is no post with ID #{$routeParams.postId}"
      )
    )

])
