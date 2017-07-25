    var orgApp = angular.module("org-app", []);
    orgApp.controller('org-ctrl', function($scope ,$http) {

        $scope.morgId = 0;

        window.scope = $scope;

    	// $scope.page = {
    	// 	pagenum:[1,2,3,4,5],
    	// 	totalnum:5,
    	// 	count:20,
    	// 	cpage:1
    	// };

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
    	$http.get(getRootPath() + "/user/list/1").success(function(data) {
    		//$scope.deparList = data.deparList;
    		$scope.userList = data.listDate;
    		$scope.page = data.pageModel;
    		$scope.pagenumCount($scope.page.cpage,$scope.page.totalnum);
    	});

    	//删除
    	$scope.deleteOneUser = function(id) {

            $http({
                method : "delete",
                url : getRootPath() + '/org/key/'+ id
            }).then(function successCallback(response) {
                //请求成功的代码
                var reqUrl = "";
                if (response.data == 1) {
                    alert("删除成功!")
                    // if ($scope.orgId == 1){
                    //     reqUrl = '/user/list'
                    // } else {
                        reqUrl = getRootPath() + '/user/list/'+ $scope.morgId
                    // }
                    getData($http,$scope, $scope.page.cpage,reqUrl);
                }else {
                    alert("删除失败!")
                }
            }, function errorCallback(response) {
                //请求失败执行代码
                alert("删除失败!")
            });

    	}

    	$scope.getUserByOrgId = function(orgId) {
    	    var reqUrl = "";
            // if (orgId == 1){
    	     //    reqUrl = '/user/list'
            // } else {
                reqUrl = getRootPath() +  '/user/list/'+ orgId
            // }

    	    $scope.morgId = orgId;
            $http({
                method : "get",
                url : reqUrl
            }).then(function successCallback(response) {
                //请求成功的代码
                $scope.userList = response.data.listDate;
                $scope.page = response.data.pageModel;
                $scope.pagenumCount($scope.page.cpage,$scope.page.totalnum);
            }, function errorCallback(response) {
                //请求失败执行代码
                alert("请求数据失败!")
            });
        }


    	//查询方法
    	$scope.query = function(){
    		// var json = {};
    		// json.username = $scope.username;
    		// json.deparment = $("#deparment").val();
            //分页用
            $scope.type = 2;
            //type=2查找所有用户
    		url = getRootPath() +  "/user/query/" + $scope.name+"?&type=1";
    		$http.get(url).success(function(data) {
                //$scope.deparList = data.deparList;
                $scope.userList = data.listDate;
                $scope.page = data.pageModel;
                $scope.pagenumCount($scope.page.cpage,$scope.page.totalnum);
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
            url = "";
            if ($scope.type == 2 ){
                url = getRootPath() + "/user/query/" + $scope.name + "?pageNumber="+page +"&type=1";
            } else {
                url = getRootPath() + "/user/list/"+$scope.morgId+"/?pageNumber="+page;
            }

            getData($http, $scope, page,url);
        };
    });
//获取数据
function getData($http, $scope, pagenum,url) {
    //pagenum:当前页数   rows：显示的行数
    //var data = { pagenum: pagenum, rows: 10 };

    $http.get(url)
        .success(function(data) {

            $scope.userList = data.listDate;
            $scope.page =  data.pageModel;
            $scope.page.cpage = parseInt(data.page.cpage);
            $scope.page.totalnum = parseInt(data.page.totalnum);
            $scope.pagenumCount(data.page.cpage, data.page.totalnum);
        });
}
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

    orgApp.filter('map', function(){
            var filter = function(input, status_map, append, default_value){
                var r = status_map[input];
                if(r === undefined){ return default_value + append }
                else { return r + append }
            };
            return filter;
    });

    orgApp.filter('typeFilter', function(){
        var filter = function(input){
            var types = {};
            types["0"] = "普通用户";
            types["1"] = "商家";
            types["2"] = "维修人员";
            types["3"] = "新装人员";
            types["4"] = "营业厅管理员";
            types["5"] = "系统管理员";
            types["6"] = "配送人员";
            console.log(input);
            var mtype = input.split(",");
            var typeString = '';
            for (var i = 0 ; i < mtype.length ; i++){
                typeString = typeString + types[mtype[i]] + " ";
            }
            return typeString;
        };
        return filter;
    });

