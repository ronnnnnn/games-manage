var app = angular.module("roleApp", []);
app.controller('role-ctrl', function($scope, $http) {

    	//初始化数据获取
    	$http.get(getRootPath() + '/role/list3').success(function(data) {
    		$scope.roleList = data.listDate;
    		$scope.page = data.pageModel;
            // $scope.pagenumCount($scope.page.cpage,$scope.page.totalnum);
    	});

        //1添加 2修改
        $scope.actionType = 1;

        //添加
        $scope.addRole = function () {
            var param = {};
            param['role'] = $scope.role;
            param['description'] = $scope.description;
            param['resourceIds'] = $scope.resourceIds;

            if ($scope.actionType == 2){
                $http({
                    method: "post",
                    url: getRootPath() + '/role/'+$scope.id,
                    data: param
                }).then(function successCallback(response) {
                    //请求成功的代码
                    if (response) {
                        alert("修改成功!");
                        getData($http, $scope, $scope.page.cpage, null);
                        hideAddRoleModal();
                    } else {
                        alert("修改失败!")
                    }
                }, function errorCallback(response) {
                    //请求失败执行代码
                    alert("修改失败!")
                });

            }else {
                //添加
                $http({
                    method: "post",
                    url: getRootPath() + '/role',
                    data: param
                }).then(function successCallback(response) {
                    //请求成功的代码
                    if (response) {
                        alert("添加成功!");
                        getData($http, $scope, $scope.page.cpage, null);
                        hideAddRoleModal();
                    } else {
                        alert("添加失败!")
                    }
                }, function errorCallback(response) {
                    //请求失败执行代码
                    alert("添加失败!")
                });
            }
        }

    $scope.setRoleInfo = function (item) {
        //$scope.resNames = item.sysResourceNames;
        $scope.id = item.id;
        $scope.actionType = 2;
        setInput(item);
        $scope.role = item.role;
        $scope.description = item.description;
        var ids = item.resourceIds;
        if (ids != undefined || ids != null || ids != ''){
            checkTree(ids.split(","));
        }
    }

    $scope.deleteOneRole = function (id) {
        $http({
            method: "delete",
            url: getRootPath() + '/role/' + id ,
        }).then(function successCallback(response) {
            //请求成功的代码
            if (response) {
                alert("删除成功!");
                getData($http, $scope, $scope.page.cpage, null);
                hideAddRoleModal();
            } else {
                alert("删除失败!")
            }
        }, function errorCallback(response) {
            //请求失败执行代码
            alert("删除失败!")
        });
    }


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

        getData($http, $scope, page,null);
    };
});
//获取数据
function getData($http, $scope, pagenum,murl) {
    //pagenum:当前页数   rows：显示的行数
    //var data = { pagenum: pagenum, rows: 10 };
    var url = '';

    if (murl == '' || murl == undefined){
        url = getRootPath() + "/role/list3?pageNumber=" + pagenum + "&pageSize=" + 10;
    } else {
        url = murl;
    }

    $http.get(url)
        .success(function(data) {
            $scope.roleList = data.listDate;
            $scope.page = data.pageModel;
        });
}

function hideAddRoleModal() {
    $('#addRoleModal').modal("hide");
    initInput();
}

//
function initInput() {
    $('#resSel').val('');
    $('#role').val('');
    $('#resourceIds').val('');
    $('#description').val('');
    zTree = $.fn.zTree.getZTreeObj("resTree");
    zTree.checkAllNodes(false);
}

function setInput(item) {
   // $('#resSel').val(item.sysResourceNames);
    $('#role').val(item.role);
    $('#description').val(item.description);
}

function checkTree(ids) {
    zTree = $.fn.zTree.getZTreeObj("resTree");
    for (var i= 0;i<ids.length;i++) {
        var node = zTree.getNodeByParam("id",parseInt(ids[i]), null);
        zTree.checkNode(node, true, true,true);
    }
}



