<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en" ng-app="res-app">

<head>
    <meta charset="utf-8" />
    <title>人力资源</title>
    <meta name="description" content="app, web app, responsive, responsive layout, admin, admin panel, admin dashboard, flat, flat ui, ui kit, AngularJS, ui route, charts, widgets, components" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/bootstrap.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/buttons.css" type="text/css" />
    <script src="${pageContext.request.contextPath}/static/angular/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/angular/js/angular.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/angular/controll/res-list.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/css/zTreeStyle/zTreeStyle.css" type="text/css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/js/jquery.ztree.excheck-3.5.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/js/jquery.ztree.exedit-3.5.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/ymPrompt/ymPrompt.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/ymPrompt/skin/simple_gray/ymPrompt.css" />

    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jslib/syUtils.js"></script>

    <style type="text/css">

    </style>

    <script type="text/javascript">



        function getScope() {
            var appElement = document.querySelector('[ng-controller=res-ctrl]');
            //获取$scope变量
            var $scope = angular.element(appElement).scope();

            //上一行改变了msg的值，如果想同步到Angular控制器中，则需要调用$apply()方法即可
            $scope.$apply();
            return $scope;
        }


        function zTreeOnClick(event, treeId, treeNode) {
             getScope().getResourceById(treeNode.id);

        };



        var zTree,treeMenu;
        var setting = {
            async: {
                enable: true,
                url : "${pageContext.request.contextPath}/resource/tree",
                type : "get",
            },
            callback:{
                onRightClick:OnRightClick,
                onClick: zTreeOnClick
            },
            data: {
                simpleData: {
                    enable: true,
                }
            },

        };
        function OnRightClick(event, treeId, treeNode) {
            zTree.selectNode(treeNode);
            showRMenu(event.clientX, event.clientY);
        }

        function showRMenu(x, y) {
            if($('.treeMenu').length == 0){
                var menuHtml =
                        "<div class=\"treeMenu\">\n" +
                        "<ul>\n" +
                        "<li onclick=\"addTreeNode()\" ><a href=\"javascript:void(0);\" >新增</a></li>\n" +
                        "<li onclick=\"removeTreeNode()\" class=\"del-menu\"><a href=\"javascript:void(0);\">删除</a></li>\n" +
                        "<li onclick=\"hideRMenu()\"><a href=\"javascript:void(0);\">取消</a></li>\n" +
                        "</ul>\n" +
                        "</div>";
                $('body').append(menuHtml);
                treeMenu = $(".treeMenu");
            }
            var selectNode = zTree.getSelectedNodes()[0];
            if (selectNode && selectNode.id == 0) {
                $('.del-menu,.upt-menu').hide();
            } else {
                $('.del-menu,.upt-menu').show();
            }
            $('.treeMenu').css({
                'position':'absolute',
                'z-index' : 99,
                'left':x,
                'top':y,
            }).show();

            $("body").bind("mousedown", onBodyMouseDown);
        }

        function hideRMenu() {
            if (treeMenu) treeMenu.hide();
            $("body").unbind("mousedown", onBodyMouseDown);
        }

        function onBodyMouseDown(event){
            if (!(event.target.id == "treeMenu" || $(event.target).parents(".treeMenu").length>0)) {
                treeMenu.hide();
            }
        }

        function updateTreeNode() {
            hideRMenu();
            var selectNode = zTree.getSelectedNodes()[0];
            var updateHtml =
                    "<div id=\"updateTreeNode\" class=\"m20\">\n" +
                    "    <table>\n" +
                    "      <tr><td>名称</td><td><input type=\"text\" class=\"input\" name=\"name\" id=\"updateNodeName\" value=\""+selectNode.name+"\"/></td></tr>\n" +
                    "    </table>\n" +
                    "</div>";

            ymPrompt.win({
                title:'修改',
                message:updateHtml,
                width:300,
                height:100,
                btn:[['修改','yes'],['取消','cancel']],
                handler:function(btn){
                    var param = {};
                    param['title'] = $('#updateNodeName').val();
                    param['id'] = selectNode.id;
                    if (btn == 'yes') {
                        $.post("${pageContext.request.contextPath}/res/node/update",param,function(result){
                            if ( result == true ) {
                                selectNode.name = param['title'];
                                zTree.updateNode(selectNode);
                            } else {
                                alert('更新菜单异常！');
                            }
                        },'json');
                    }
                }});
        }

        function addTreeNode() {
            hideRMenu();
            var addHtml =
                    "<div id=\"addTreeNode\" class=\"m20\">\n" +
                    "    <table>\n" +
                    "      <tr><td>资源名称</td><td><input type=\"text\" class=\"input\" name=\"name\" id=\"addNodeName\"/></td></tr>\n" +
                    "      <tr><td>资源编码</td><td><input type=\"text\" class=\"input\" name=\"icon\" id=\"addPriority\"/></td></tr>\n" +
                    "      <tr><td>类别</td><td><select type=\"text\" class=\"input\" name=\"url\" id=\"addType\"><option value=\"menu\">菜单</option><option value=\"button\">按钮</option></select></td></tr>\n" +
                    "      <tr><td>权限字符</td><td><input type=\"text\" class=\"input\" name=\"icon\" id=\"addPermission\"/></td></tr>\n" +
                    "      <tr><td>URL</td><td><input type=\"text\" class=\"input\" name=\"orderNo\"  id=\"addURL\"/></td></tr>\n" +
                    "    </table>\n" +
                    "</div>";

            ymPrompt.win({
                title:'新增',
                message:addHtml,
                width:300,
                height:200,
                btn:[['保存','yes'],['取消','cancel']],
                handler:function(btn){
                    var param = {};
                    param['resourceName'] = $('#addNodeName').val();
                    param['priority'] = $('#addPriority').val();
                    param['type'] = $('#addType').val();
                    param['permission'] = $('#addPermission').val();
                    param['url'] = $('#addURL').val();
                    var selectNode = zTree.getSelectedNodes()[0];
                    //id = parentId
                    param['id'] = selectNode.id;
                    if (btn == 'yes') {
                        $.post("${pageContext.request.contextPath}/resource",param,function(result){
                            if (result != null || result != undefined) {
                                var node = {};
                                node['id'] = result;
                                node['pId'] = selectNode.id;
                                node['name'] = param['resourceName'];
//                                node['url'] = param['url'];
//                                node['orderNo'] = param['orderNo'];
//                                node['icon'] = param['icon'];
                                zTree.addNodes(selectNode, node);
                                getScope().getResourceById(result);
                            } else {
                                alert('保存菜单异常！');
                            }
                        },'json');
                    }
                }});
        }

        function removeTreeNode() {
            hideRMenu();
            var nodes = zTree.getSelectedNodes();
            var param = {};
            param ['id'] = nodes[0].id;
            if (nodes && nodes.length>0) {
                    ymPrompt.confirmInfo({title:'提醒',message:'确认删除菜单：'+nodes[0].name+'?',handler:function(v){
                        if (v == 'ok') {
                            $.ajax({
                                type: 'delete',
                                url : '${pageContext.request.contextPath}/resource/' + nodes[0].id,
                                dataType : 'json',
                                success : function(data) {
                                    if(data){
                                        alert('删除成功');
                                        zTree.removeNode(nodes[0]);
                                    }else {
                                        alert("权限已分配至角色,无法删除");
                                    }
                                }
                            });
                        }
                    }});
//                }
            }
        }

        function checkTreeNode(checked) {
            var nodes = zTree.getSelectedNodes();
            if (nodes && nodes.length>0) {
                zTree.checkNode(nodes[0], checked, true);
            }
            hideRMenu();
        }

        function resetTree() {
            hideRMenu();
            $.fn.zTree.init($("#menuTree"), setting);
        }

        $(function() {
            $.fn.zTree.init($("#menuTree"),setting);
            zTree = $.fn.zTree.getZTreeObj("menuTree");
        });

    </script>
</head>

<body  ng-controller="res-ctrl">

<!--模态框-->
<div class="modal fade" id="editResourceModal" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">修改资源</h4>
            </div>
            <div class="modal-body">
                <form name="editResourceForm" class="form-horizontal">
                    <div class="form-group">
                        <label for="resourceName" class="col-sm-3 control-label">资源名称</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="resourceName" id="resourceName" ng-model="resourceName">
                        </div>
                    </div>
                    <div class="form-error" ng-show="editResourceForm.resourceName.$invalid && editResourceForm.resourceName.$dirty">
                        <span style="color: red" ng-show="editResourceForm.resourceName.$error.required">资源名称不能为空</span>
                    </div>
                    <div class="form-group">
                        <label for="priority" class="col-sm-3 control-label">资源编码</label>
                        <div class="col-sm-7">
                            <input type="text" class="form-control" name="priority" id="priority" ng-model="priority">
                        </div>
                    </div>
                    <div class="form-error" ng-show="editResourceForm.priority.$invalid && editResourceForm.priority.$dirty">
                        <span style="color: red" ng-show="editResourceForm.priority.$error.required">资源编码不能为空</span>
                    </div>
                    <div class="form-group">
                        <label for="type" class="col-sm-3 control-label">类别</label>
                        <div class="col-sm-7">
                            <select  class="form-control" id="type" ng-model="type">
                                <option value="menu">菜单</option>
                                <option value="button">按钮</option>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="permission" class="col-sm-3 control-label">权限字符</label>
                        <div class="col-sm-7">
                            <input type="text"  class="form-control" id="permission" ng-model="permission">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="url" class="col-sm-3 control-label">URL</label>
                        <div class="col-sm-7">
                            <input type="text"  class="form-control" id="url" ng-model="url">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default"  data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary"  ng-click="updateResource()">修改</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>


<div class="col-md-12">
    <!--左开始-->
    <div class="col-md-3">
        <div class="panel panel-default">
            <div class="panel-heading"></div>
            <div class="panel-body">
                <ul id="menuTree" class="ztree" style="height: 100%;width: auto;"></ul>
                <%--<input id="res-id" ng-change="getUserByOrgId()" value="0"  ng-model="orgId"/>--%>
            </div>
        </div>
    </div>
    <!--左结束-->
    <!--右开始-->
    <div class="col-md-9">

        <!--按钮组借宿-->
        <!--表格-->
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">资源详情</div>
                <div class="panel-body">
                    <table class="table table-hover ">
                        <tr>
                            <th  style="font-size: small">ID</th>
                            <th  style="font-size: small">资源名称</th>
                            <th  style="font-size: small">资源编码</th>
                            <th  style="font-size: small">类别</th>
                            <th  style="font-size: small">权限字符</th>
                            <th  style="font-size: small">url</th>
                            <th  style="font-size: small">操作</th>
                        </tr>
                        <tr>
                            <td> {{res.id}} </td>
                            <td> {{res.resourceName}} </td>
                            <td> {{res.priority}} </td>
                            <td> {{res.type}} </td>
                            <td> {{res.permission}} </td>
                            <td> {{res.url}} </td>
                            <td>
                                <button type="button" data-toggle="modal" ng-click="resourceCall()" data-target="#editResourceModal" class="button button-action button-box"><i class="glyphicon glyphicon-edit"></i></button>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>
        </div>
        <!--表格结束-->
    </div>
    <!--右结束-->
</div>

<!-- jQuery -->
<%--<script src="https://cdn.bootcss.com/jquery/1.9.0/jquery.min.js"></script>--%>
<script src="${pageContext.request.contextPath}/static/angular/vendor/jquery/bootstrap.js"></script>
<div id="mydialog-p"></div>
</body>

</html>