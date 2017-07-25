<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en" ng-app="app">

<head>
    <meta charset="utf-8" />
    <title>安全日志</title>
    <meta name="description" content="app, web app, responsive, responsive layout, admin, admin panel, admin dashboard, flat, flat ui, ui kit, AngularJS, ui route, charts, widgets, components" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <%--<link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/bootstrap.css" type="text/css" />--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/buttons.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/multiple-select/multiple-select.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/multiple-select/demos/assets/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-fileinput/css/fileinput.min.css"/>

    <script src="${pageContext.request.contextPath}/static/angular/js/angular.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/angular/controll/access-record-list.js"></script>
    <script src="${pageContext.request.contextPath}/static/multiple-select/demos/assets/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/multiple-select/multiple-select.js"></script>


    <script src="${pageContext.request.contextPath}/static/angular/vendor/jquery/bootstrap.js"></script>
    <!-- ztree -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/js/jquery.ztree.excheck-3.5.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/js/jquery.ztree.exedit-3.5.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/ymPrompt/ymPrompt.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/ymPrompt/skin/simple_gray/ymPrompt.css" />

    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jslib/syUtils.js"></script>

    <!--时间选择器-->
    <link rel="stylesheet" type="text/css" media="all" href="${pageContext.request.contextPath}/static/daterangepicker/daterangepicker-bs3.css" />
    <link rel="stylesheet" type="text/css" media="all" href="${pageContext.request.contextPath}/static/daterangepicker/daterangepicker-1.3.7.css" />
    <link href="${pageContext.request.contextPath}/static/daterangepicker/font-awesome-4.1.0/css/font-awesome.min.css" rel="stylesheet">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/daterangepicker/moment.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/daterangepicker/daterangepicker-1.3.7.js"></script>

    <style type="text/css">
        
    </style>


    <script type="text/javascript">
        $(document).ready(function (){
            //时间插件
            //$('#reportrange span').html(moment().subtract('hours', 1).format('YYYY-MM-DD HH:mm:ss') + ' - ' + moment().format('YYYY-MM-DD HH:mm:ss'));

            $('#reportrange').daterangepicker(
                {
                    // startDate: moment().startOf('day'),
                    //endDate: moment(),
                    //minDate: '01/01/2012',	//最小时间
                    maxDate : moment(), //最大时间
                    dateLimit : {
                        days : 30
                    }, //起止时间的最大间隔
                    showDropdowns : true,
                    showWeekNumbers : false, //是否显示第几周
                    timePicker : true, //是否显示小时和分钟
                    timePickerIncrement : 60, //时间的增量，单位为分钟
                    timePicker12Hour : false, //是否使用12小时制来显示时间
                    ranges : {
                        //'最近1小时': [moment().subtract('hours',1), moment()],
                        '今日': [moment().startOf('day'), moment()],
                        '昨日': [moment().subtract('days', 1).startOf('day'), moment().subtract('days', 1).endOf('day')],
                        '最近7日': [moment().subtract('days', 6), moment()],
                        '最近30日': [moment().subtract('days', 29), moment()]
                    },
                    opens : 'right', //日期选择框的弹出位置
                    buttonClasses : [ 'btn btn-default' ],
                    applyClass : 'btn-small btn-primary blue',
                    cancelClass : 'btn-small',
                    format : 'YYYY-MM-DD HH:mm:ss', //控件中from和to 显示的日期格式
                    separator : ' to ',
                    locale : {
                        applyLabel : '确定',
                        cancelLabel : '取消',
                        fromLabel : '起始时间',
                        toLabel : '结束时间',
                        customRangeLabel : '自定义',
                        daysOfWeek : [ '日', '一', '二', '三', '四', '五', '六' ],
                        monthNames : [ '一月', '二月', '三月', '四月', '五月', '六月',
                            '七月', '八月', '九月', '十月', '十一月', '十二月' ],
                        firstDay : 1
                    }
                }, function(start, end, label) {//格式化日期显示框

                    $('#reportrange span').html(start.format('YYYY-MM-DD HH:mm:ss') + ' - ' + end.format('YYYY-MM-DD HH:mm:ss'));
                    $('#dateString').val(start.format('YYYY-MM-DD HH:mm:ss') + ' to ' + end.format('YYYY-MM-DD HH:mm:ss'));

                });

            //设置日期菜单被选项  --开始--
            var dateOption ;
            if("${riqi}"=='day') {
                dateOption = "今日";
            }else if("${riqi}"=='yday') {
                dateOption = "昨日";
            }else if("${riqi}"=='week'){
                dateOption ="最近7日";
            }else if("${riqi}"=='month'){
                dateOption ="最近30日";
            }else if("${riqi}"=='year'){
                dateOption ="最近一年";
            }else{
                dateOption = "自定义";
            }
            $(".daterangepicker").find("li").each(function (){
                if($(this).hasClass("active")){
                    $(this).removeClass("active");
                }
                if(dateOption==$(this).html()){
                    $(this).addClass("active");
                }
            });
            //设置日期菜单被选项  --结束--
        })
    </script>

    <script>

        function clearInput() {
            $('#password').val('');
        }

        function getScope() {
            var appElement = document.querySelector('[ng-controller=access-record-ctrl]');
            //获取$scope变量
            var $scope = angular.element(appElement).scope();
            //上一行改变了msg的值，如果想同步到Angular控制器中，则需要调用$apply()方法即可
            // $scope.$apply();
            //调用控制器中的getData()方法
            // console.log($scope.getData());
            return $scope;
        }

        function pageUpdatePassword() {
            getScope().updatePassword();
            $('#editModal').modal("hide");
        }

        function clearAddModel() {
            getScope().initAddModel();
        }

        $(function() {

            $('#a-ms').change(function() {
                getScope().addRoleIds = $(this).val();
                console.log($(this).val());
            }).multipleSelect({
                width: '100%'
            });

            $('#ms').change(function() {
                getScope().newRoleIds = $(this).val();
                //getScope().$apply();
                console.log($(this).val());
                //alert($(this).val());
            }).multipleSelect({
                width: '100%'
            });

            $('#accessRecordType').change(function() {
                getScope().accessRecordTypes = $(this).val();
                //getScope().$apply();
                console.log($(this).val());
                //alert($(this).val());
            }).multipleSelect({
                width: '100%'
            });

            $('#a-accessRecordType').change(function() {
                getScope().accessRecordTypes = $(this).val();
                //getScope().$apply();
                console.log($(this).val());
                //alert($(this).val());
            }).multipleSelect({
                width: '100%'
            });

        });
    </script>



</head>

<body  ng-controller="access-record-ctrl" style="height: auto">
    <!--查询-->
    <div class="col-md-12" >
        <div class="panel panel-default">
            <div class="panel-heading">查询</div>
            <div class="panel-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="inputPassword" class="col-md-1 control-label">用户名</label>
                        <div class="col-md-2">
                            <input type="text" class="form-control" id="inputPassword"  ng-model="queryKey">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="inputPassword" class="col-md-1 control-label"></label>
                        <div class="col-md-2">
                            <button class="btn " ng-click="query()">搜索</button>
                        </div>
                        <div class="col-md-2">
                            <button class="btn " ng-click="initPage()">重置</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--查询结束-->

    <!--表格-->
    <div class="col-md-12" style="height: 100%">
        <div class="panel panel-default">
            <div class="panel-heading">列表</div>
            <div class="panel-body">
                <table class="table table-hover ">
                    <tr>
                        <th>ID</th>
                        <th>用户</th>
                        <th>会话ID</th>
                        <th>IP地址</th>
                        <th>操作记录</th>
                        <th>操作时间</th>
                    </tr>
                    <tr ng-repeat="item in accessRecordList">
                        <td>
                            {{ $index + 1 + ((page.cpage-1) * 10)}}
                        </td>
                        <td  style="font-size: smaller" ng-bind="item.username"></td>
                        <td  style="font-size: smaller" ng-bind="item.sid"></td>
                        <td style="font-size: smaller" ng-bind="item.ipAddress" ></td>
                        <td style="font-size: smaller" ng-bind="item.handleModule" ></td>
                        <td style="font-size: smaller">{{item.lastAccessTime | date : "yyyy-MM-dd HH:mm:ss"}}</td>
                    </tr>
                   
                </table>
            </div>

        </div>
        <div class="col-md-12">
            <div style="float: left;">
                <span>共{{page.count}}条记录 ，当前第{{page.cpage}}页/共{{page.totalnum}}页</span>
            </div>
            <div style="float: right;">
                <nav aria-label="Page navigation">
                    <ul class="pagination">
                        <li ng-click="pageclick('«')">
                            <a href="#" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <li ng-class="{'active':page.cpage == item}" ng-repeat="item in page.pagenum" ng-click="pageclick(item)"><a  href="#" ng-bind="item"></a></li>
                        
                        <li ng-click="pageclick('»')">
                            <a href="#" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>


</body>

</html>
