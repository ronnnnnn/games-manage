var app = angular.module("setting-app", []);
    app.controller('setting-ctrl', function($scope, $http) {

        $http.get(getRootPath() + '/setting/list').success(function(data) {
    		$scope.settingList = data.listDate;
    		$scope.page = data.pageModel;
        });


        $scope.addSetting = function () {
            var param = {};
            param['sysType'] = $scope.addType;
            param['sysName'] = $scope.addName;
            param['sysCode'] = $scope.addCode;
            param['sysValue'] = $scope.addValue;
            param['sysDescription'] = $scope.addDescription;

            $http({
            	method : "post",
            	url : getRootPath() +'/setting',
                data : param
            }).then(function successCallback(response) {
            	//请求成功的代码
            	if (response.data) {
            		alert("添加成功!");
                    hideAddSettingModal();
            		getData($http,$scope, $scope.page.cpage,null);
            	}else {
            		alert("添加失败!")
            	}
            }, function errorCallback(response) {
            	//请求失败执行代码
            	alert("添加失败!")
            });

        }

        //删除
        $scope.deleteSetting = function(id) {
			$http({
				method : "delete",
				url : getRootPath() + '/setting/'+ id
			}).then(function successCallback(response) {
				//请求成功的代码
				if (response.data) {
					alert("删除成功!")
					getData($http,$scope, $scope.page.cpage,null);
				}else {
					alert("删除失败!")
				}
			}, function errorCallback(response) {
				//请求失败执行代码
				alert("删除失败!")
			});
        };

        //设置信息
        $scope.setSettingInfo = function (item) {
            $('#editImageUrl').fileinput('refresh');
            $scope.editType = item.sysType;
            $scope.editName = item.sysName;
            $scope.editCode = item.sysCode;
            $scope.editValue = item.sysValue;
            $scope.editDescription = item.sysDescription;
            $scope.id = item.id;
        }

        //更新
        $scope.editSetting = function () {
            var param = {};
            param['id'] = $scope.id;
            param['sysType'] = $scope.editType;
            param['sysName'] = $scope.editName;
            param['sysCode'] = $scope.editCode;
            param['sysValue'] = $scope.editValue;
            param['sysDescription'] = $scope.editDescription;

            $http({
                method : "post",
                url : getRootPath() + '/setting/'+ $scope.id,
                data: param
            }).then(function successCallback(response) {
                //请求成功的代码
                if (response.data) {
                    alert("修改成功!")
                    getData($http,$scope, $scope.page.cpage,null);
                    hideEditSettingModal();
                }else {
                    alert("修改失败!")
                }
            }, function errorCallback(response) {
                //请求失败执行代码
                alert("修改失败!")
            });
        }

        //查询方法
        $scope.pageType = 1;
        $scope.query = function(){
            $scope.pageType = 2;
            url = getRootPath() + "/setting/query/" + $scope.queryKey;
            $http.get(url).success(function(data) {
                //$scope.deparList = data.deparList;
                $scope.settingList = data.listDate;
                $scope.page = data.pageModel;
            });

        };

        $scope.resetQuery = function () {
            $scope.pageType = 1;
            $scope.queryKey = '';
            getData($http,$scope, 1,null);
        }
        //
        //
        $scope.pageclick = function(page) {
            function getPage() {
                var cpage = 0;
                var totalnum = 0;
                cpage = $scope.page.cpage;
                totalnum = $scope.page.totalnum;
                if (page == "«") {
                    if (cpage > 1) {
                        cpage -= 1;
                    }
                } else if (page == "»") {
                    if (cpage < totalnum)
                        cpage += 1;
                } else {
                    cpage = page;
                }
                return cpage;
            }

            page = getPage();

            var rurl = '';
            if ($scope.pageType == 2){
                rurl = getRootPath() + "/setting/query/" + $scope.queryKey +"?pageNumber=" + page ;
            }else {
                rurl = null;
            }

            getData($http, $scope, page,rurl);
        };
    });
    //获取数据
    function getData($http, $scope, pagenum,murl) {
        //pagenum:当前页数   rows：显示的行数
        //var data = { pagenum: pagenum, rows: 10 };
        var url = '';

        if (murl == '' || murl == undefined){
            url = getRootPath() + "/setting/list?pageNumber=" + pagenum + "&pageSize=" + 10;
        } else {
            url = murl;
        }

        $http.get(url)
            .success(function(data) {
                $scope.settingList = data.listDate;
                $scope.page = data.pageModel;
            });
    }


    function hideEditSettingModal() {
        $('#editSettingModal').modal("hide");
    }

    function hideAddSettingModal() {
        $('#addSettingModal').modal("hide");
    }

   function getAddSysValue() {
        return $('#addValue').val();
   }

    function getEditSysValue() {
        return $('#editValue').val();
    }
