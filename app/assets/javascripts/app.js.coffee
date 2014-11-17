angular.module 'angularRPG',
  ['ngResource', 'ngRoute', 'ngSanitize',
  'ui.router', 'ngStorage', 'login', 'signUp', 'ui.bootstrap']
.value('BASE_URL', 'http://localhost:3000/api/v1')

.config ($stateProvider, $urlRouterProvider) ->
  $stateProvider
    .state 'home',
     url: 'home'
     templateUrl: 'pages/home.html'
     controller: 'signUpCtrl'

    .state 'signUp',
     url: 'sign_up'
     templateUrl: 'pages/sign_up.html'
     controller: 'signUpCtrl'

    .state 'login',
     url: 'login'
     templateUrl: 'pages/login.html'
     controller: 'loginCtrl'