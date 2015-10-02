describe 'PostsController', ->
  scope       = null
  ctrl        = null
  location    = null
  routeParams = null
  resource    = null

  # access injected service later
  httpBackend = null

  setupController =(keywords, results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.keywords = keywords

      # capture the injected service
      httpBackend = $httpBackend

      if results
        request = new RegExp("\/posts.*keywords=#{keywords}")
        httpBackend.expectGET(request).respond(results)

      ctrl        = $controller('PostsController',
                                $scope: scope
                                $location: location)
    )

  beforeEach(module('website'))
  # beforeEach(setupController())

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'when no keywords present', ->
      beforeEach(setupController())

      it 'defaults to no posts', ->
        expect(scope.posts).toEqual([])

  describe 'with keywords', ->
    keywords = 'foo'
    posts = [
      {
        id: 1
        title: 'Test Post 1'
        content: 'This is a test.'
      },
      {
        id: 2
        title: 'Test Post 2'
        content: 'This is a test of the emergency alert system.'
      },
    ]
    beforeEach ->
      setupController(keywords, posts)
      httpBackend.flush()

    # it 'calls the backend', ->
    #   expect(scope.posts).toEqual(posts)

  describe 'search()', ->
    beforeEach ->
      setupController()

    it 'redirects to itself with a keyword param', ->
      keywords = 'foo'
      scope.search(keywords)
      expect(location.path()).toBe('/')
      expect(location.search()).toEqual({keywords: keywords})
