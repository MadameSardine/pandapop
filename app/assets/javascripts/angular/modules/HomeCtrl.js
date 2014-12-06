var pandapop = angular.module('Pandapop', []);

pandapop.controller('SearchController', ['$scope', 'Youtube', function SearchController($scope, Youtube){
  $scope.executeSearch = function executeSearch(){
    Youtube.searchVideos($scope.query, function(error, data){
      if (!error) {
        $scope.results = data.items;
      }
    });
  };
}]);

pandapop.filter('formatDate', function(){
  return function(dateSTR) {
  var string = dateSTR;
  var array = string.match(/(\d+)(?=[MHS])/ig)||[]; 
  var formatted = array.map(function(item){
    if(item.length<2) return '0'+item;
    return item;
  }).join(':');
    return formatted;
  }
});

pandapop.factory('Youtube', function Youtube($http){
  return {
    searchVideos: function searchVideos(query, callback) {
      $http.post('/get_songs', { 'search-content': query } )
      .success(function (data) {
        callback(null, data);
      })
      .error(function (e) {
        callback(e);
      });
    }
  };
});
