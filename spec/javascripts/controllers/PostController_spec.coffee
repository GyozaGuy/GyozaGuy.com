describe 'PostController', ->
  scope       = null
  ctrl        = null
  routeParams = null
  httpBackend = null
  flash       = null
  postId      = 42

  fakePost    =
    id: postId
    title: 'Test Post 1'
    content: 'This is a test of the emergency alert system.'

  setupController =(postExists=true)->
    inject(($location, $routeParams, $rootScope, $httpBackend, $controller, _flash_)->
      scope       = $rootScope.$new()
      location    = $location
      httpBackend = $httpBackend
      routeParams = $routeParams
      routeParams.postId = postId
      flash = _flash_

      request = new RegExp("\/posts/#{postId}")
      results = if postExists
        [200, fakePost]
      else
        [404]

      httpBackend.expectGET(request).respond(results[0], results[1])

      ctrl        = $controller('PostController', $scope: scope)
    )

  beforeEach(module('website'))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'post is found', ->
      beforeEach(setupController())
      it 'loads the given post', ->
        httpBackend.flush()
        expect(scope.post[0]).toEqual(fakePost[0])
    describe 'post is not found', ->
      beforeEach(setupController(false))
      it 'loads the given post', ->
        httpBackend.flush()
        expect(scope.post).toBe(null)
        expect(flash.error).toBe("There is no post with ID #{postId}")
