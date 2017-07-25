var app = angular.module("app", []);
    app.controller('access-record-ctrl', function($scope, $http,$location) {


        $scope.pageType  = 1;

        //初始化数据获取
	    // url = '/access-record/list';
        $scope.names =[{"description":"超级管理员","id":1,"isAvaliable":true,"resourceIds":"41,50,55,60","role":"admin"},{"description":"超级管理员2","id":2,"isAvaliable":true,"resourceIds":"41,50,55,60","role":"admin2"},{"description":"超级管理员3","id":3,"isAvaliable":true,"resourceIds":"41,50,55,60","role":"admin3"}];

        $scope.accessRecordList = [];

    	$http.get(getRootPath() + '/access-record/list').success(function(data) {
    		$scope.accessRecordList = data.listDate;
    		$scope.page = data.pageModel;
    	});


        $scope.initPage = function () {
            $scope.pageType  = 1;
            $scope.queryKey = "";
            $http.get(getRootPath() + '/access-record/list').success(function(data) {
                $scope.accessRecordList = data.listDate;
                $scope.page = data.pageModel;
            });
        }


    	//查询方法
    	$scope.query = function(){
            $scope.pageType = 2;
            var url = getRootPath() + "/access-record/query/" + $scope.queryKey ;
            $http.get(url).success(function(data) {
                //$scope.deparList = data.deparList;
                $scope.accessRecordList = data.listDate;
                $scope.page = data.pageModel;
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
                rurl = getRootPath() + "/access-record/query/" + $scope.queryKey +"?pageNumber=" + page ;
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
        url = getRootPath() + "/access-record/list?pageNumber=" + pagenum + "&pageSize=" + 10;
    } else {
        url = murl;
    }

    $http.get(url)
        .success(function(data) {
            $scope.accessRecordList = data.listDate;
            $scope.page = data.pageModel;
        });
}


function getDate() {
    return $('#dateString').val();
}

