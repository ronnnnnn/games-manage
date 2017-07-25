<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en" ng-app="roleApp">

<head>
    <meta charset="utf-8" />
    <title>角色管理</title>
    <meta name="description" content="app, web app, responsive, responsive layout, admin, admin panel, admin dashboard, flat, flat ui, ui kit, AngularJS, ui route, charts, widgets, components" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <%--<link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/bootstrap.css" type="text/css" />--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/buttons.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/multiple-select/multiple-select.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/multiple-select/demos/assets/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/my.css" />
    <script src="${pageContext.request.contextPath}/static/angular/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/angular/js/angular.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/angular/controll/role-list.js"></script>
    <script src="${pageContext.request.contextPath}/static/angular/vendor/jquery/bootstrap.js"></script>
    <!--ztree-->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/js/jquery.ztree.excheck-3.5.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/js/jquery.ztree.exedit-3.5.js"></script>

    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jslib/syUtils.js"></script>

    <style type="text/css">
        
    </style>

    <script>
        var zTree;
        var setting = {
            async: {
                enable: true,
                url : "${pageContext.request.contextPath}/resource/tree",
                type : "get",
            },
            check: {
                enable: true,
                chkboxType: {"Y":"", "N":""}
            },
            view: {
                dblClickExpand: false
            },
            data: {
                simpleData: {
                    enable: true
                }
            },
            callback: {
                beforeClick: beforeClick,
                onCheck: onCheck
            }
        };


        function beforeClick(treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("resTree");
            zTree.checkNode(treeNode, !treeNode.checked, null, true);
            return false;
        }

        function onCheck(e, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("resTree"),
                    nodes = zTree.getCheckedNodes(true),
                    v = "";
                    d = "";
            for (var i=0, l=nodes.length; i<l; i++) {
                v += nodes[i].name + ",";
                d += nodes[i].id + ",";
            }

            if (v.length > 0 )  v = v.substring(0, v.length-1);
            if (d.length > 0)   d = d.substring(0, d.length -1)
            $("#resSel").val(v);
            $("#resourceIds").val(d);
            $scope = getScope();
            $scope.resourceIds = d;
            //$scope.$apply();
        }

        function showMenu() {
            var cityObj = $("#resSel");
            var cityOffset = $("#resSel").offset();
            $("#menuContent").css({left: "0px", top: cityObj.outerHeight() + "px"}).slideDown("fast");

            $("body").bind("mousedown", onBodyDown);
        }
        function hideMenu() {
            $("#menuContent").fadeOut("fast");
            $("body").unbind("mousedown", onBodyDown);
        }
        function onBodyDown(event) {
            if (!(event.target.id == "menuBtn" || event.target.id == "resSel" || event.target.id == "menuContent" || $(event.target).parents("#menuContent").length>0)) {
                hideMenu();
            }
        }

        $(document).ready(function(){
            $.fn.zTree.init($("#resTree"), setting);
            zTree = $.fn.zTree.getZTreeObj("resTree");
        });
//        function clearInput() {
//            $('#password').val('');
//        }



        function getScope() {
            var appElement = document.querySelector('[ng-controller=role-ctrl]');
            //获取$scope变量
            var $scope = angular.element(appElement).scope();
            //上一行改变了msg的值，如果想同步到Angular控制器中，则需要调用$apply()方法即可
            //$scope.$apply();
            //调用控制器中的getData()方法
            // console.log($scope.getData());
            return $scope;
        }

//        function pageUpdatePassword() {
//            getScope().updatePassword();
//            $('#editModal').modal("hide");
//        }
//
//        function clearAddModel() {
//            getScope().initAddModel();
//        }

    </script>

    <script>
        $(function () { $('#addRoleModal').modal('hide')});
    </script>

    <script>
        $(function () { $('#addRoleModal').on('hide.bs.modal', function () {
            initInput();
        }) });
    </script>



</head>

<body  ng-controller="role-ctrl" style="height: auto">

    <!--按钮组-->
    <div class="col-md-12" style="margin-bottom:20px;">
        <div class="button-group">
            <button type="button" class="button button-pill" onclick="" data-toggle="modal" data-target="#addRoleModal">添加角色</button>
        </div>
    </div>
    <!--按钮组结束-->
    <!--添加修改角色模态框-->
    <div class="modal fade" id="addRoleModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">角色管理</h4>
                </div>
                <div class="modal-body" style="height: auto">
                    <form name="registerForm" class="form-horizontal">
                        <div class="form-group">
                            <label for="role" class="col-sm-3 control-label">角色</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" id="role" ng-model="role">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="description" class="col-sm-3 control-label">描述</label>
                            <div class="col-sm-7">
                                <input type="text" class="form-control" id="description" ng-model="description">
                            </div>
                        </div>
                        <div class="form-group" style="height: auto">
                            <label class="col-sm-3 control-label">资源</label>
                            <div class="col-sm-7">
                                <input type="hidden" id="resourceIds"  />
                                <input class="form-control" id="resSel" type="text"  onclick="showMenu();" ng-model="resNames"/>
                                <div id="menuContent" class="menuContent" style="background-color:white ;display:none; position: absolute;">
                                    <ul id="resTree" class="ztree" style="margin-top:0; width:180px; height:auto;"></ul>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" onclick="" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary"  ng-click="addRole()">确定</button>
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
                        <th>角色</th>
                        <th>描述</th>
                        <th>资源</th>
                        <th>操作</th>
                    </tr>
                    <tr ng-repeat="item in roleList">
                        <td>
                            {{ $index + 1 + ((page.cpage-1) * 10)}}
                        </td>
                        <td  style="font-size: smaller" ng-bind="item.role"></td>
                        <td  style="font-size: smaller" ng-bind="item.description"></td>
                        <td  style="font-size: smaller" ng-bind="item.sysResourceNames"></td>
                        <td>
                            <button type="button" class="button button-action button-box" data-toggle="modal" data-target="#addRoleModal"  ng-click="setRoleInfo(item)"><i class="glyphicon glyphicon-edit"></i></button>
                            <button class="button button-caution button-box" ng-click="deleteOneRole(item.id)"><i class="glyphicon glyphicon-trash"></i></button>
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
