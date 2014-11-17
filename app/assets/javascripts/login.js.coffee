angular.module 'login',
  ['ngResource', 'ngRoute', 'ngSanitize',
  'ui.router', 'ngStorage']
.value('BASE_URL', 'http://localhost:3000/api/v1')

.controller 'loginCtrl', ["$localStorage", "$scope", "$rootScope", "$state", "UserLogin", "UserShow", ($localStorage, $scope, $rootScope, $state, UserLogin, UserShow) ->

  $scope.signUp = ->
    $state.go('signUp')
  
  $scope.userObject =
    {
      email:''
      password:''
    }
  $scope.loginUser = (userObject) ->
    UserLogin.login(userObject)
      .then (response) ->
        if response.status == 200
          id = response.data.id
          UserShow.get(id)
            .then (response) ->
              $localStorage.currentUser = response.data

          $state.go('dashboard')
        else if response.status == 401
          $rootScope.$broadcast("event:auth:error")

]

.factory 'UserLogin', ["$http", "BASE_URL", ($http, BASE_URL) ->
  UserLogin =
    login: (userObject) ->
      $http.post(BASE_URL+'/users/sign_in', userObject)
]

.factory 'UserShow', ["$http", "BASE_URL", ($http, BASE_URL) ->
  UserShow =
    get: (id) ->
      $http.get(BASE_URL+'/users/'+id)
]

