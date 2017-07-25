<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en" ng-app="app">

<head>
    <meta charset="utf-8" />
    <title>用户列表</title>
    <meta name="description" content="app, web app, responsive, responsive layout, admin, admin panel, admin dashboard, flat, flat ui, ui kit, AngularJS, ui route, charts, widgets, components" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <%--<link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/bootstrap.css" type="text/css" />--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/buttons.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/multiple-select/multiple-select.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/multiple-select/demos/assets/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-fileinput/css/fileinput.min.css"/>

    <script src="${pageContext.request.contextPath}/static/angular/js/angular.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/angular/controll/user-list.js"></script>
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
            var appElement = document.querySelector('[ng-controller=user-ctrl]');
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

            $('#userType').change(function() {
                getScope().userTypes = $(this).val();
                //getScope().$apply();
                console.log($(this).val());
                //alert($(this).val());
            }).multipleSelect({
                width: '100%'
            });

            $('#a-userType').change(function() {
                getScope().userTypes = $(this).val();
                //getScope().$apply();
                console.log($(this).val());
                //alert($(this).val());
            }).multipleSelect({
                width: '100%'
            });

        });
    </script>


    <script>
        function zTreeOnClick(event, treeId, treeNode) {
            //  alert(treeNode.tId + ", " + treeNode.name);
            // $("#org-id").val(treeNode.id);
            pageOrgId = treeNode.id;
            getScope().getUserByOrgId(treeNode.id);

        };

        var zTree,treeMenu;
        var setting = {
            async: {
                enable: true,
                url : "${pageContext.request.contextPath}/user/tree",
                type : "get",
                // autoParam:["id", "name"]
                //otherParam:{"otherParam":"zTreeAsyncTest"},
                //dataFilter: filter
            },
            callback:{

            },
            data: {
                simpleData: {
                    enable: true
                }
            },

        };

        function resetTree(pageNumber) {
        }

        $(function() {
            $.fn.zTree.init($("#userTree"),setting);
            zTree = $.fn.zTree.getZTreeObj("userTree");
        });

    </script>


</head>

<body  ng-controller="user-ctrl" style="height: auto">
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
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--查询结束-->
    <!--按钮组-->
    <div class="col-md-12" style="margin-bottom:20px;">
        <div class="button-group">
            <button type="button" class="button button-pill" onclick="initAddInput()" data-toggle="modal" data-target="#addUserModal">添加用户</button>
        </div>
    </div>
    <!--按钮组结束-->
    <!--添加用户模态框-->
    <div class="modal fade" id="addUserModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">添加用户</h4>
                </div>
                <div class="modal-body">
                    <form name="registerForm" class="form-horizontal">
                        <div class="form-group">
                            <label for="a-nickname" class="col-sm-3 control-label">昵称</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" id="a-nickname" ng-model="nickname">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="a-username" class="col-sm-3 control-label">用户名</label>
                            <div class="col-sm-7">
                                <input type="text"
                                       class="form-control"
                                       id="a-username"
                                       name="ausername"
                                       ensure-unique="username"
                                       <%--ng-pattern="/^[a-zA-Z]{1,20}$/"--%>
                                       required
                                       ng-model="username">
                            </div>
                            <div class="form-error" ng-show="registerForm.ausername.$invalid && registerForm.ausername.$dirty">
                                <span style="color: red" ng-show="registerForm.ausername.$error.required">不能为空</span>
                                <%--<span style="color: red" ng-show="registerForm.ausername.$error.pattern">不能包含中文及特殊字符</span>--%>
                                <span style="color: red" ng-show="registerForm.ausername.$error.unique">该帐号已存在</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="a-phone" class="col-sm-3 control-label">手机</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control"
                                       id="a-phone"
                                       name="aphone"
                                       ng-model="phone"
                                       placeholder="请输入手机号码"
                                       ensure-unique="phone"
                                       maxlength="11"
                                       required
                                       ng-pattern="/1[3|5|7|8|][0-9]{9}/">
                            </div>
                            <div class="form-error" ng-show="registerForm.aphone.$invalid && registerForm.aphone.$dirty">
                                <span style="color: red" ng-show="registerForm.aphone.$error.required">手机号不能为空</span>
                                <span style="color: red" ng-show="registerForm.aphone.$error.pattern">请输入正确的手机号码</span>
                                <span style="color: red" ng-show="registerForm.aphone.$error.unique">该手机号已存在</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="a-password" class="col-sm-3 control-label">密码</label>
                            <div class="col-sm-7">
                                <input type="text" name="apassword" required class="form-control" id="a-password" ng-model="password">
                            </div>
                            <div class="form-error" ng-show="registerForm.apassword.$invalid && registerForm.apassword.$dirty">
                                <span style="color: red" ng-show="registerForm.apassword.$error.required">密码不能为空</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="a-ms" class="col-sm-3 control-label">角色</label>
                            <div class="col-sm-7">
                                <select id="a-ms" multiple="multiple" ng-model="roleIds" >
                                    <c:forEach items="${roleList}" var="role">
                                        <option value="${role.id}">
                                                ${role.description}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-3 control-label">用户类型</label>
                            <div class="col-sm-7">
                                <select id="a-userType" multiple="multiple" ng-model="userType" >
                                    <option value="2">维修人员</option>
                                    <option value="3">新装人员</option>
                                    <option value="4">营业厅管理人员</option>
                                    <option value="5">系统管理员</option>
                                    <option value="6">配送人员</option>
                                    <option value="7">推广人员</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="a-locked" class="col-sm-3 control-label">是否锁定</label>
                            <div class="col-sm-7">
                                <select  class="form-control" id="a-locked" ng-model="locked">
                                    <option value="true">是</option>
                                    <option value="false">否</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="initAddInput()" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary"  ng-click="addUser()">添加</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>


    <!--添加用户模态框-->
    <div class="modal fade" id="showUserModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">用户关系</h4>
                </div>

                <div class="modal-body">
                    <ul id="userTree" class="ztree" style="height: 100%;width: auto;"></ul>
                    <%--<input id="org-id" ng-change="getUserByOrgId()" value="0"  ng-model="orgId"/>--%>
                </div>


                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="initAddInput()" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary"  ng-click="addUser()">添加</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

    <!--修改密码模态框-->
    <div class="modal fade" id="editModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">修改密码</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal">
                        <div class="form-group">
                            <label for="password" class="col-sm-2 control-label">新密码</label>
                            <div class="col-sm-6">
                                <input type="text" class="form-control" id="password" ng-model="newPassword">
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" onclick="pageUpdatePassword()">修改</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>


    <!--修改用户态框-->
    <div class="modal fade" id="editUserModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">修改信息</h4>
                </div>
                <div class="modal-body">
                    <form name="editForm" class="form-horizontal">
                        <div class="form-group">
                            <label for="a-username" class="col-sm-3 control-label">用户名</label>
                            <div class="col-sm-7">
                                <input type="text"
                                       class="form-control"
                                       id="e-username"
                                       name="eusername"
                                       ensure-unique="username"
                                <%--ng-pattern="/^[a-zA-Z]{1,20}$/"--%>
                                       required
                                       ng-model="username">
                            </div>
                            <div class="form-error" ng-show="editForm.eusername.$invalid && editForm.eusername.$dirty">
                                <span style="color: red" ng-show="editForm.eusername.$error.required">不能为空</span>
                                <%--<span style="color: red" ng-show="registerForm.ausername.$error.pattern">不能包含中文及特殊字符</span>--%>
                                <span style="color: red" ng-show="editForm.eusername.$error.unique">该帐号已存在</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="nickname" class="col-sm-3 control-label">昵称</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" id="nickname" ng-model="nickname">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="phone" class="col-sm-3 control-label">手机</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control"
                                       id="phone"
                                       name="phone"
                                       ng-model="phone"
                                       placeholder="请输入手机号码"
                                       ensure-unique="phone"
                                       maxlength="11"
                                       required
                                       ng-pattern="/1[3|5|7|8|][0-9]{9}/">
                            </div>
                            <div class="form-error" ng-show="editForm.phone.$invalid && editForm.phone.$dirty">
                                <span style="color: red" ng-show="editForm.phone.$error.required">手机号不能为空</span>
                                <span style="color: red" ng-show="editForm.phone.$error.pattern">请输入正确的手机号码</span>
                                <span style="color: red" ng-show="editForm.phone.$error.unique">该手机号已存在</span>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="ms" class="col-sm-3 control-label">角色</label>
                            <div class="col-sm-7">
                                <select id="ms" multiple="multiple" ng-model="roleIds" >
                                    <c:forEach items="${roleList}" var="role">
                                       <option value="${role.id}">
                                            ${role.description}
                                       </option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label  class="col-sm-3 control-label">用户类型</label>
                            <div class="col-sm-7">
                                <select id="userType" multiple="multiple" ng-model="userType" >
                                <%--<select  class="form-control" id="userType" ng-model="userType">--%>
                                    <option value="2">维修人员</option>
                                    <option value="3">新装人员</option>
                                    <option value="4">营业厅管理人员</option>
                                    <option value="5">系统管理员</option>
                                    <option value="6">配送人员</option>
                                    <option value="7">推广人员</option>
                                </select>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="locked" class="col-sm-3 control-label">是否锁定</label>
                            <div class="col-sm-7">
                                <select  class="form-control" id="locked" ng-model="locked">
                                   <option value="true">是</option>
                                   <option value="false">否</option>
                                </select>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" ng-click="updateUserInfo()">修改</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>
    <!-- /.modal -->

    <!--模态框-->
    <div class="modal fade" id="orderModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document" style="width: 800px">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">下级用户订单</h4>
                </div>
                <div class="col-md-12" >
                    <div class="panel panel-default">
                        <div class="panel-heading">查询</div>
                        <div class="panel-body">
                            <form class="form-horizontal">
                                <%--<div class="form-group">--%>
                                    <%--<label class="col-md-1 control-label">时间</label>--%>
                                    <%--<div class="col-md-4">--%>
                                        <%--<input type="text" readonly style="width:320px" name="reportrange" id="reportrange" class="form-control" ng-model="reportrange" value=""/>--%>
                                    <%--</div>--%>
                                <%--</div>--%>
                                <div class="form-group">
                                    <div class="span4">
                                        <div class="control-group">
                                            <label class="col-md-1 control-label">时间</label>
                                            <div class="controls">
                                                <div id="reportrange" class="pull-left dateRange" style="width:350px">
                                                    <i class="glyphicon glyphicon-calendar fa fa-calendar"></i>
                                                    <span id="searchDateRange"></span>
                                                    <input id="dateString" type="hidden"/>
                                                    <b class="caret"></b>
                                                </div>
                                                <div>
                                                    <h1>总价:{{totalMoney}}</h1>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="form-group">
                                    <label class="col-md-1 control-label"></label>
                                    <div class="col-md-1">
                                        <button class="btn " ng-click="orderQuery(1)">条件检索</button>
                                    </div>
                                    <label class="col-md-1 control-label"></label>
                                    <div class="col-md-1" style="margin-left: 10px">
                                        <button class="btn " ng-click="orderReset()">重置</button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <!--查询结束-->

                <div class="col-md-12" style="height: 100%">
                    <div class="panel panel-default">
                        <div class="panel-heading">列表</div>
                        <div class="panel-body">
                            <table class="table table-hover ">
                                <tr>
                                    <th>ID</th>
                                    <th>订单号</th>
                                    <th>类型</th>
                                    <th>描述</th>
                                    <th>支付金额</th>
                                    <th>支付渠道</th>
                                    <th>用户姓名</th>
                                    <th>用户级别</th>
                                    <th>创建时间</th>
                                </tr>
                                <tr ng-repeat="item in userOrderList">
                                    <td>
                                        {{ $index + 1 + ((page.cpage-1) * 10)}}
                                    </td>
                                    <td style="font-size: smaller">{{item.id}}</td>
                                    <td style="font-size: smaller">{{item.statu | orderTypeFilter}}</td>
                                    <td style="font-size: smaller">{{item.description}}</td>
                                    <td style="font-size: smaller">{{item.totalPrice}}</td>
                                    <td style="font-size: smaller">{{item.payType}}</td>
                                    <td style="font-size: smaller">{{item.realName}}</td>
                                    <td style="font-size: smaller">{{item.sysUser.parentIds | gradeFilter}}</td>
                                    <td style="font-size: smaller">{{item.createTime}}</td>
                                </tr>

                            </table>
                        </div>

                    </div>
                    <div class="col-md-12">
                        <div style="float: left;">
                            <span>共{{mpage.count}}条记录 ，当前第{{mpage.cpage}}页/共{{mpage.totalnum}}页</span>
                        </div>
                        <div style="float: right;">
                            <nav aria-label="Page navigation">
                                <ul class="pagination">
                                    <li ng-click="mpageclick('«')">
                                        <a href="#" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <li ng-class="{'active':mpage.cpage == item}" ng-repeat="item in mpage.pagenum" ng-click="mpageclick(item)"><a  href="#" ng-bind="item"></a></li>

                                    <li ng-click="mpageclick('»')">
                                        <a href="#" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
                                        </a>
                                    </li>
                                </ul>
                            </nav>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>


    <!--表格-->
    <div class="col-md-12" style="height: 100%">
        <div class="panel panel-default">
            <div class="panel-heading">列表</div>
            <div class="panel-body">
                <table class="table table-hover ">
                    <tr>
                        <th>ID</th>
                        <th>用户名</th>
                        <th>昵称</th>
                        <th>电话号码</th>
                        <th>角色</th>
                        <th>是否锁定</th>
                        <th>用户类型</th>
                        <th>推荐人</th>
                        <th>创建时间</th>
                        <th>操作</th>
                    </tr>
                    <tr ng-repeat="item in userlist">
                        <td>
                            {{ $index + 1 + ((page.cpage-1) * 10)}}
                        </td>
                        <td  style="font-size: smaller" ng-bind="item.username"></td>
                        <td  style="font-size: smaller" ng-bind="item.nickname"></td>
                        <td style="font-size: smaller" ng-bind="item.phone" ></td>
                        <td style="font-size: smaller">{{ item.roleIds | replaceRoleId : role_map:'':'未知'}}</td>
                        <td style="font-size: smaller">{{ item.locked | map : status_map : '' : '未知'}}</td>
                        <td style="font-size: smaller">{{ item.userType | typeFilter }}</td>
                        <td style="font-size: smaller">{{item.parentUser.nickname}}</td>
                        <td  style="font-size: smaller" ng-bind="item.createTime">
                        </td>
                        <td>
                            <button type="button" class="button  button-primary button-box " data-toggle="modal" data-target="#editModal" onclick="clearInput()" ng-click="setUserId(item.id)">密</button>
                            <button type="button" class="button button-action button-box" data-toggle="modal" data-target="#editUserModal"  ng-click="setUserInfo(item)"><i class="glyphicon glyphicon-edit"></i></button>
                            <button class="button button-caution button-box" ng-click="deleteOneUser(item.id)"><i class="glyphicon glyphicon-trash"></i></button>
                        </td>
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
