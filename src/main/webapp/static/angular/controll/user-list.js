var app = angular.module("app", []);
    app.controller('user-ctrl', function($scope, $http,$location) {

        window.userScope = $scope

    	$scope.status_map = {
    		true : '是',
			false : '否',
			0 : '否',
			1 : '是'
		};

        //页数计算
        $scope.pagenumCount = function(pagenum, totalnum) {
            var i = makePageNum(pagenum, totalnum);
            $scope.page.pagenum = i;
        };


    	//初始化数据获取
	    // url = '/user/list';
        $scope.names =[{"description":"超级管理员","id":1,"isAvaliable":true,"resourceIds":"41,50,55,60","role":"admin"},{"description":"超级管理员2","id":2,"isAvaliable":true,"resourceIds":"41,50,55,60","role":"admin2"},{"description":"超级管理员3","id":3,"isAvaliable":true,"resourceIds":"41,50,55,60","role":"admin3"}];

        $scope.userlist = [];

    	$http.get(getRootPath() + '/user/list').success(function(data) {
    		$scope.userlist = data.listDate;
    		$scope.page = data.pageModel;
            $scope.pagenumCount($scope.page.cpage,$scope.page.totalnum);
    	});

        $http.get(getRootPath() + '/role/map').success(function(data) {
            $scope.role_map = data;
        });

        $scope.initPage = function () {
            $http.get(getRootPath() + '/user/list').success(function(data) {
                $scope.userlist = data.listDate;
                $scope.page = data.pageModel;
                $scope.pagenumCount($scope.page.cpage,$scope.page.totalnum);
            });
        }


    	//删除当个用户
    	$scope.deleteOneUser = function(id) {
			$http({
				method : "delete",
				url : getRootPath() + '/user/'+ id
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

    	//更新用户
    	$scope.updateUserInfo = function () {
            var rids = '';
            if ($scope.newRoleIds != undefined && $scope.newRoleIds != '') {
              //  alert($scope.newRoleIds);
                if ($scope.newRoleIds.length > 1) {
                    rids = $scope.newRoleIds.join(",");
                } else if ($scope.newRoleIds.length == 1) {
                    rids = $scope.newRoleIds.toString();
                } else {
                    rids = null;
                }
            }

            var types = '';
            if ($scope.userTypes != undefined && $scope.userTypes != '') {
                //  alert($scope.newRoleIds);
                if ($scope.userTypes.length > 1) {
                    types = $scope.userTypes.join(",");
                } else if ($scope.userTypes.length == 1) {
                    types = $scope.userTypes.toString();
                } else {
                    types = null;
                }
            }

            $http({
                method : "post",
                url : getRootPath() + '/user/'+ $scope.currentUserId,
                data: { 'username' : $scope.username,'nickname' : $scope.nickname, 'phone' : $scope.phone,'userType' : types,'locked' : $scope.locked, 'roleIds' : rids}
            }).then(function successCallback(response) {
                //请求成功的代码
                if (response.data) {
                    alert("修改成功!")
                    getData($http,$scope, $scope.page.cpage,null);
                    hideEditUserModal();
                }else {
                    alert("修改失败!")
                }
            }, function errorCallback(response) {
                //请求失败执行代码
                alert("修改失败!")
            });
        }

    	//更改密码
    	$scope.updatePassword = function () {
    	    var param = {};
    	    param['newPassword'] = $scope.newPassword;
            $http({
                method : "patch",
                url :getRootPath() + '/user/'+ $scope.currentUserId,
                data: param
            }).then(function successCallback(response) {
                //请求成功的代码
                if (response.data) {
                    alert("修改成功!")
                    getData($http,$scope, $scope.page.cpage,null);
                }else {
                    alert("修改失败!")
                }
            }, function errorCallback(response) {
                //请求失败执行代码
                alert("修改失败!")
            });
        };

        $scope.setUserId = function (id) {
            $scope.currentUserId = id;
        };

        $scope.setUserInfo = function (item) {
            $scope.username = item.username;
            $scope.currentUserId = item.id;
            $scope.nickname = item.nickname;
            $scope.phone = item.phone;
            $scope.userType = item.typeList;
            $scope.locked = item.locked;
            $scope.roleIds = item.roleList;
            if ($scope.roleIds != undefined && $scope.resourceIds != '') {
                updateUser($scope.roleIds);
            }

            if ($scope.userType != undefined && $scope.userType != '') {
                updateTypes($scope.userType);
            }
            $scope.newRoleIds = $scope.roleIds;
           // $('#ms').multipleSelect("setSelects",[1,3]);
        }

        $scope.initAddModel = function () {
            initAddInput();
            $scope.nickname = '';
            $scope.username = '';
            $scope.phone = '';
            $scope.password = '';
            $scope.locked = '';
            $scope.userType = '';
            $scope.addRoleIds = '';
        }

        $scope.addUser = function () {
            var roleIds = $scope.addRoleIds;
            var mRoleIds = (roleIds == undefined || roleIds == '')? null : roleIds.join(",");
            var auserTypes = $scope.userTypes;
            var muserTypes = (auserTypes == undefined || auserTypes == '')? null : auserTypes.join(",");
            alert(muserTypes);
            $http({
                method : "post",
                url : getRootPath() + '/user',
                data: { 'nickname' : $scope.nickname,
                    'username' : $scope.username,
                    'phone' : $scope.phone,
                    'password' : $scope.password,
                    'roleIds' : mRoleIds,
                    'locked' : $scope.locked,
                    'userType' : muserTypes
                }
            }).then(function successCallback(response) {
                //请求成功的代码
                if (response.data) {
                    alert("添加成功!")
                    getData($http,$scope, $scope.page.cpage,null);
                    $scope.initAddModel();
                    hideAddUserModal();
                }else {
                    alert("添加失败!")
                }
            }, function errorCallback(response) {
                //请求失败执行代码
                alert("添加失败!")
            });
        }

    	//查询方法
    	$scope.query = function(){
            $scope.pageType = 2;
            url = getRootPath() + "/user/query/" + $scope.queryKey +"?&type=2";
            $http.get(url).success(function(data) {
                //$scope.deparList = data.deparList;
                $scope.userlist = data.listDate;
                $scope.page = data.pageModel;
            });
    		
    	};

        $scope.getOrder = function (item) {
            $scope.muserId = item.id;
            $http.get(getRootPath() + '/user/order/' + item.id).success(function(data) {
                //$scope.deparList = data.deparList;
                $scope.userOrderList = data.listDate;
                $scope.totalMoney = data.simpleData['totalMoney'];

                $scope.mpage = data.pageModel;
                showModel();
            });
        }

        $scope.modalPageType = 1;
        $scope.orderQuery = function (pageNumber) {
            $http.get(getRootPath() + '/user/order/' + $scope.muserId+"?dateString="+getDate()+"&pageNumber="+pageNumber).success(function(data) {
                //$scope.deparList = data.deparList;
                $scope.userOrderList = data.listDate;
                $scope.totalMoney = data.simpleData['totalMoney'];
                $scope.mpage = data.pageModel;
                $scope.modalPageType = 2;
            });
        }

        $scope.orderReset = function () {
            $http.get(getRootPath() + '/user/order/' + $scope.muserId).success(function(data) {
                $scope.userOrderList = data.listDate;
                $scope.totalMoney = data.simpleData['totalMoney'];
                $scope.mpage = data.pageModel;
                resetInput();
            });
        }

        $scope.mpageclick = function(mpage) {
            function getPage() {
                var cpage = 0;
                var totalnum = 0;
                cpage = $scope.mpage.cpage;
                totalnum = $scope.mpage.totalnum;
                if (page == "«") {
                    if (cpage > 1) {
                        cpage -= 1;
                    }
                } else if (mpage == "»") {
                    if (cpage < totalnum)
                        cpage += 1;
                } else {
                    cpage = page;
                }
                return cpage;
            }

            mpage = getPage();
            if (modalPageType == 1){
                var url = getRootPath() + "/user/order/" + $scope.muserId +"?pageNumber=" + mpage ;
            }else {
                var url = getRootPath() + '/user/order/' + $scope.muserId+"?dateString="+$scope.reportrange+"&pageNumber="+mpage;
            }
            $http.get(url)
                .success(function(data) {
                        $scope.userOrderList = data.listDate;
                        $scope.mpage = data.pageModel;
                });
        };


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
                rurl = getRootPath() + "/user/query/" + $scope.queryKey +"?type=2&pageNumber=" + page ;
            }else {
                rurl = null;
            }

            getData($http, $scope, page,rurl);
            resetTree(page);
        };
    });
//获取数据
function getData($http, $scope, pagenum,murl) {
    //pagenum:当前页数   rows：显示的行数
    //var data = { pagenum: pagenum, rows: 10 };
    var url = '';

    if (murl == '' || murl == undefined){
        url = getRootPath() + "/user/list?pageNumber=" + pagenum + "&pageSize=" + 10;
    } else {
        url = murl;
    }



    $http.get(url)
        .success(function(data) {
            $scope.userlist = data.listDate;
            $scope.page = data.pageModel;
            $scope.page.cpage = parseInt(data.pageModel.cpage);
            $scope.page.totalnum = parseInt(data.pageModel.totalnum);
            $scope.pagenumCount(data.pageModel.cpage, data.pageModel.totalnum);
        });
}


app.filter('map', function(){
       var filter = function(input, status_map, append, default_value){
       var r = status_map[input];
       if(r === undefined){ return default_value + append }
		      else { return r + append }
	   };
       return filter;
});

app.filter('typeFilter', function(){
    var filter = function(input){
        var types = {};
        types["0"] = "普通用户";
        types["1"] = "商家";
        types["2"] = "维修人员";
        types["3"] = "新装人员";
        types["4"] = "营业厅管理员";
        types["5"] = "系统管理员";
        types["6"] = "配送人员";
        types["7"] = "推广人员";
        var mtype = input.split(",");
        var typeString = '';
        for (var i = 0 ; i < mtype.length ; i++){
            typeString = typeString + types[mtype[i]] + " ";
        }
        return typeString;
    };
    return filter;
});

app.filter('gradeFilter', function(){
    var filter = function(input){
        var parentList = input.split("/");
        if (parentList.length == 3){
            return "直接下级";
        } else if (parentList.length == 4){
            return "二级下级"
        } else if (parentList.length == 5){
            return "三级下级"
        }
    };
    return filter;
});

app.filter('orderTypeFilter', function(){
    var filter = function(input){
        if (input < 20){
            return "宽带新装";
        } else if (20 < input && input < 30){
            return "宽带维修";
        } else if (input == 30){
            return "宽带续费";
        } else if (input > 30){
            return "换卡";
        }
    };
    return filter;
});

app.directive('ensureUnique', ['$http', function($http) {
    return {
        require: 'ngModel',
        link: function(scope, ele, attrs, c) {
            scope.$watch(attrs.ngModel, function() {
                $http({
                    method: 'POST',
                    url:getRootPath() +  '/user/check/' + attrs.ensureUnique,
                    data: {'phone': scope.phone,'id': scope.currentUserId,'username':scope.username}
                }).success(function(data, status, headers, cfg) {
                    c.$setValidity('unique', data);
                }).error(function(data, status, headers, cfg) {
                    c.$setValidity('unique', false);
                });
            });
        }
    }
}]);


app.filter('replaceRoleId', function(){
    var filter = function(input, role_map,append,default_value){
        if (input == '' || input == "0"|| input == undefined){
            return '未分配';
        }
        var ids = input.split(",");
        var result = "";
        for(var j = 0;j < ids.length; j++){
            var index = ids[j];
            result = result  + role_map[index] + ",";
        }
        if(result == undefined){ return default_value + append }
        else { return result }
    };
    return filter;
});


//pagenum:当前页数   totalnum：总页数
function makePageNum(pagenum, totalnum) {
    var num = 5;
    var mid = num / 2;
    if (num % 2 != 0) {
        mid = (num - 1) / 2;
    }
    var i = [];
    var startpage, endpage;
    if (pagenum > mid) {
        startpage = pagenum - mid;
    } else {
        startpage = 1;
    }
    if (pagenum > totalnum - mid || totalnum <= num) {
        endpage = totalnum;
        startpage = totalnum <= num ? 1 : endpage - num + 1;
    } else {
        if (startpage == 1) {
            endpage = num;
        } else {
            endpage = pagenum + mid;
        }

    }
    for (var x = 0; x < (endpage - startpage + 1); x++) {
        i[x] = startpage + x;
    }
    return i;
}

function updateUser(ids) {
    $('#ms').multipleSelect("setSelects",ids);
}

function updateTypes(types) {
    $('#userType').multipleSelect("setSelects",types);
}

function hideEditUserModal() {
    $('#editUserModal').modal("hide");
}

function hideAddUserModal() {
    $('#addUserModal').modal("hide");
}

function initAddInput() {
    $('#a-userType').val('');
    $('#a-locked').val('');
    $('#a-nickname').val('');
    $('#a-username').val('');
    $('#a-password').val('');
    $('#a-ms').val('');
    $('#a-phone').val('');
}

function showModel() {
    $('#orderModal').modal('show');
}

function getDate() {
    return $('#dateString').val();
}

function resetInput() {
    $('#reportrange span').html('');
    $('#dateString').val('');
}

