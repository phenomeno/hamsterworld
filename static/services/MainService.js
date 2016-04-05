angular.module('hamsterworld').service('MainService', function($http) {
  this.getHamsters = function(callback) {
    $http.get('/api/v1/hamsters', config={params: {page: 1}}).
    success(function(data) {
      callback(data);
    }).
    error(function(error) {
      callback(error);
    });
  };

  this.postHamster = function(hamster, callback) {
    $http.post('/api/v1/hamsters', config={hamster: hamster}).
    success(function(data) {
      callback(data);
    }).
    error(function(error) {
      callback(error);
    });
  };

  this.putHamster = function(hamster, callback) {
    $http.put('/api/v1/hamsters/'+hamster.id, config={hamster: hamster}).
    success(function(data) {
      callback(data);
    }).
    error(function(error) {
      callback(error);
    });
  };

  this.deleteHamster = function(hamster, callback) {
    $http.delete('/api/v1/hamsters/'+hamster.id, config={hamster: hamster}).
    success(function(data) {
      callback(data);
    }).
    error(function(error) {
      callback(error);
    });
  };

});
