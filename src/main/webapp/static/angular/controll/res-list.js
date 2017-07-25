    var resApp = angular.module("res-app", []);
    resApp.controller('res-ctrl', function($scope ,$http) {


        $scope.getResourceById = function (id) {
            $http.get(getRootPath() + "/resource/" + id).success(function(data) {
                 $scope.res = data;
            });
        }

        $scope.resourceCall = function () {
            $scope.resourceName = $scope.res.resourceName ;
            $scope.priority = $scope.res.priority;
            $scope.type = $scope.res.type;
            $scope.permission = $scope.res.permission;
            $scope.url = $scope.res.url;
        }

        $scope.updateResource = function () {
            var param = {};
            param['resourceName'] = $scope.resourceName;
            param['type'] = $scope.type;
            param['priority'] = $scope.priority;
            param['permission'] = $scope.permission;
            param['url'] = $scope.url;
            $http.post(getRootPath() + "/resource/"+$scope.res.id,param).success(function (data) {
                $scope.res = data;
                hideModel();
            });
        }

    });

    function hideModel() {
        $('#editResourceModal').modal("hide");
    }

