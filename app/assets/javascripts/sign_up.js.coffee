angular.module 'signUp',
  ['ngResource', 'ngRoute', 'ngSanitize',
  'ui.router', 'ngStorage']

.value('BASE_URL', 'http://localhost:3000/api/v1')

.config [
  '$httpProvider',
  ($httpProvider) ->
    $httpProvider.defaults.headers.common.Accept = "application/json"
    token = $('meta[name=csrf-token]').attr('content')
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = token
]

.controller 'signUpCtrl', ["UserShow","$localStorage","$scope","$rootScope","$state", "UserSave", (UserShow,$localStorage,$scope,$rootScope,$state,UserSave) ->
  $scope.$storage = $localStorage
  $scope.userObject =
    {
      username:''
      email: ''
      password: ''
      passwordConfirmation: ''
    }
  $scope.createUser = (userObject) ->
    UserSave.save(userObject)
      .then (response) ->
        console.log response
        if response.status == 200
          console.log response.data
          id = response.data.id
          UserShow.get(id)
            .then (response) ->
              $localStorage.currentUser = response.data
              $state.go('home')
        else
          $state.go('signUp')
  $scope.logOut = ->
    $localStorage.$reset()
    $state.go('home')

  $scope.signUp = ->
    $state.go('signUp')

  $scope.logIn = ->
    $state.go('login')

  $scope.projectsIndex = ->
    $state.go('projects')
    
  $scope.dashBoardGo = ->
    $state.go('home')

]

.factory 'UserSave', ["$localStorage", "$http", "BASE_URL", ($localStorage, $http, BASE_URL) ->
  UserSave =
    save: (userObject)->
      console.log "saving"
      $http.post(BASE_URL+'/users',
        {
          user: userObject
        }
      )
]
