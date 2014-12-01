var pandapop = angular.module('Pandapop', []);

pandapop.controller('SearchController', ['$scope', 'Youtube', function SearchController($scope, Youtube){
  $scope.executeSearch = function executeSearch(){
    Youtube.searchVideos($scope.query, function(error, data){
      if (!error) {
        console.log(data)
        $scope.videos = data.items;
      }
    });
  };
}]);

pandapop.factory('Youtube', function Youtube($http){
  return {
    searchVideos: function searchVideos(query, callback) {
      $http.post('/get_songs', { 'search-content': query } )
      .success(function (data) {
        console.log(data);
        callback(null, data);
      })
      .error(function (e) {
        callback(e);
      });
    }
  };
});

