describe 'PostsController', ->
  scope       = null
  ctrl        = null
  location    = null
  routeParams = null
  resource    = null

  setupController =(keywords)->
    inject(($location, $routeParams, $rootScope, $resource, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.keywords = keywords

      ctrl        = $controller('PostsController',
                                $scope: scope
                                $location: location)
    )

  beforeEach(module('website'))
  beforeEach(setupController())

  it 'defaults to no posts', ->
    expect(scope.posts).toEqual([])
