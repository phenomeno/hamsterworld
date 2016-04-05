angular.module("hamsterworld").controller("MainController", function($scope, $http, MainService){
  $scope.hamsters = [];
  $scope.hamster = {};
  $scope.display_hamster = {};
  $scope.display_flag = true;

  $scope.getHamsters = function() {
      MainService.getHamsters(function(data){
        if (data) {
          console.log(data);
          $scope.hamsters = data;
        }
      });
  };

  $scope.addHamster = function() {
    MainService.postHamster($scope.hamster, function(data){
      if (data) {
        $scope.hamster = {};
        $scope.getHamsters();
      }
    });
  };

  $scope.editHamster = function() {
    MainService.putHamster($scope.display_hamster, function(data) {
      if (data) {
        /* Q: Should server return what was edited to verify on the client side? */
        $scope.getHamsters();
      }
    });
  };

  $scope.deleteHamster = function() {
    MainService.deleteHamster($scope.display_hamster, function(data) {
      if(data) {
        $scope.display_flag = true;
        $scope.getHamsters();
      }
    });
  };

  $scope.displayHamster = function(hamster) {
    $scope.display_flag = false;
    $scope.display_hamster = hamster;
  };

  $scope.getHamsters();
});
