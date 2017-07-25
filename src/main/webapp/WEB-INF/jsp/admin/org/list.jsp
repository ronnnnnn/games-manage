<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en" ng-app="org-app">

<head>
    <meta charset="utf-8"/>
    <title>人力资源</title>
    <meta name="description"
          content="app, web app, responsive, responsive layout, admin, admin panel, admin dashboard, flat, flat ui, ui kit, AngularJS, ui route, charts, widgets, components"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/bootstrap.css" type="text/css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/buttons.css" type="text/css"/>
    <script src="${pageContext.request.contextPath}/static/angular/vendor/jquery/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/angular/js/angular.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/angular/controll/org-list.js"></script>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/css/zTreeStyle/zTreeStyle.css"
          type="text/css">
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/js/jquery.ztree.core-3.5.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/js/jquery.ztree.excheck-3.5.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/JQuery zTree v3.5.15/js/jquery.ztree.exedit-3.5.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/ymPrompt/ymPrompt.js"></script>
    <link rel="stylesheet" type="text/css"
          href="${pageContext.request.contextPath}/static/ymPrompt/skin/simple_gray/ymPrompt.css"/>

    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/jslib/jquery-easyui-1.4.4/jquery.easyui.min.js"></script>
    <script type="text/javascript"
            src="${pageContext.request.contextPath}/static/jslib/jquery-easyui-1.4.4/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jslib/ajaxfileupload.js"></script>
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/static/jslib/jquery-easyui-1.4.4/themes/bootstrap/easyui.css"
          type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/jslib/jquery-easyui-1.4.4/themes/icon.css"
          type="text/css">

    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jslib/syUtils.js"></script>

    <style type="text/css">

    </style>

    <script type="text/javascript">

        function addUser() {
            if (pageOrgId != 0) {
                var d = $('<div/>').dialog({
                    width: 630,
                    height: 400,
                    href: '${pageContext.request.contextPath}/page/org/users',
                    modal: true,
                    align: 'center',
                    title: '添加用户',
                    buttons: [{
                        text: '确认加入部门',
                        handler: function () {
                            var rows = $('#admin_user_add_datagrid').datagrid('getChecked');
                            var ids = [];
                            if (rows.length > 0) {
                                $.messager.confirm('确认', '您是否要将当前选中的用户加入该部门？', function (r) {
                                    if (r) {
                                        for (var i = 0; i < rows.length; i++) {
                                            ids.push(rows[i].id);
                                        }

                                        $.ajax({
                                            type: 'post',
                                            url: '${pageContext.request.contextPath}/org/key',
                                            data: {
                                                ids: ids.join(','),
                                                orgId: pageOrgId
                                            },
                                            dataType: 'json',
                                            success: function (data) {
                                                getScope().getUserByOrgId(pageOrgId);
//                                                $.messager.show({
//                                                    title : '提示',
//                                                    msg : "加入成功!"
//                                                });
                                                d.dialog('close');
                                            }
                                        });
                                    }
                                });
                            } else {
                                $.messager.show({
                                    title: '提示',
                                    msg: '请勾选要加入的选项！'
                                });
                            }


                            d.dialog('destroy');
                        }
                    }],
                    onClose: function () {
                        d.dialog('destroy');
                    },
                    onLoad: function () {
                        $('#admin_user_add_datagrid').datagrid({
                            url: '${pageContext.request.contextPath}/user/datagrid',
                            fit: true,
                            pagination: true,
                            idField: 'id',
                            checkOnSelect: false,
                            selectOnCheck: false,
                            fitColumns: true,
                            nowrap: false,
                            rownumbers: true,
                            frozenColumns: [[{
                                field: 'id',
                                title: '编号',
                                width: 150,
                                align: 'center',
                                //hidden : true,
                                checkbox: true
                            }, {
                                field: 'username',
                                title: '帐号',
                                width: 100,
                                align: 'center',
                            }, {
                                field: 'nickname',
                                title: '昵称',
                                width: 100,
                                align: 'center',
                            }, {
                                field: 'phone',
                                title: '手机',
                                width: 200,
                                align: 'center',
                            }, {
                                field: 'createTime',
                                title: '添加时间',
                                width: 150,
                                align: 'center',
//                            formatter : function(value, row, index) {
//                                var tt=new Date(parseInt(value)).toLocaleString().replace(/年|月/g, "-").replace(/日/g, " ");
//                                return tt;
//                            },
                            }]]
                        });
                    }
                });
            } else {
                $.messager.show({
                    title: '提示',
                    msg: '请选中需要加入人员的部门！'
                });
            }
        };

        var pageOrgId = 0;
        function getScope() {
            var appElement = document.querySelector('[ng-controller=org-ctrl]');
            //获取$scope变量
            var $scope = angular.element(appElement).scope();

            //上一行改变了msg的值，如果想同步到Angular控制器中，则需要调用$apply()方法即可
            //$scope.$apply();
            //调用控制器中的getData()方法
            // console.log($scope.getData());
            return $scope;
        }

        var $exscope = getScope();
        function zTreeOnClick(event, treeId, treeNode) {
            //  alert(treeNode.tId + ", " + treeNode.name);
            // $("#org-id").val(treeNode.id);
            pageOrgId = treeNode.id;
            getScope().getUserByOrgId(treeNode.id);

        };

        <%--var zNodes =[--%>
        <%--<c:forEach items="${orgList}" var="org">--%>
        <%--&lt;%&ndash;<c:if test="${not r.rootNode}">&ndash;%&gt;--%>
        <%--{id:${org.id},pId:${org.parentId},name:"${org.organizationName}"},--%>
        <%--&lt;%&ndash;</c:if>&ndash;%&gt;--%>
        <%--</c:forEach>--%>
        <%--];--%>


        var zTree, treeMenu;
        var setting = {
            async: {
                enable: true,
                url: "${pageContext.request.contextPath}/org/tree",
                type: "get",
                // autoParam:["id", "name"]
                //otherParam:{"otherParam":"zTreeAsyncTest"},
                //dataFilter: filter
            },
            callback: {
                onRightClick: OnRightClick,
                onClick: zTreeOnClick
            },
            data: {
                simpleData: {
                    enable: true
                }
            },

        };
        function OnRightClick(event, treeId, treeNode) {
            zTree.selectNode(treeNode);
            showRMenu(event.clientX, event.clientY);
        }

        function showRMenu(x, y) {
            if ($('.treeMenu').length == 0) {
                var menuHtml =
                    "<div class=\"treeMenu\">\n" +
                    "<ul>\n" +
                    "<li onclick=\"addTreeNode()\" ><a href=\"javascript:void(0);\" >新增</a></li>\n" +
                    "<li onclick=\"removeTreeNode()\" class=\"del-menu\"><a href=\"javascript:void(0);\">删除</a></li>\n" +
                    "<li onclick=\"updateTreeNode()\" class=\"upt-menu\"><a href=\"javascript:void(0);\">修改</a></li>\n" +
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
                'position': 'absolute',
                'z-index': 99,
                'left': x,
                'top': y,
            }).show();

            $("body").bind("mousedown", onBodyMouseDown);
        }

        function hideRMenu() {
            if (treeMenu) treeMenu.hide();
            $("body").unbind("mousedown", onBodyMouseDown);
        }

        function onBodyMouseDown(event) {
            if (!(event.target.id == "treeMenu" || $(event.target).parents(".treeMenu").length > 0)) {
                treeMenu.hide();
            }
        }

        function updateTreeNode() {
            hideRMenu();
            var selectNode = zTree.getSelectedNodes()[0];
            var updateHtml =
                "<div id=\"updateTreeNode\" class=\"m20\">\n" +
                "    <table>\n" +
                "      <tr><td>名称</td><td><input type=\"text\" class=\"input\" name=\"name\" id=\"updateNodeName\" value=\"" + selectNode.name + "\"/></td></tr>\n" +
//                    "      <tr><td>菜单URL</td><td><input type=\"text\" class=\"input\" name=\"url\" id=\"updateNodeUrl\" value=\""+selectNode.url+"\"/></td></tr>\n" +
//                    "      <tr><td>菜单图标</td><td><input type=\"text\" class=\"input\" name=\"icon\" id=\"updateIcon\" value=\""+selectNode.icon+"\"/></td></tr>\n" +
//                    "      <tr><td>菜单排序</td><td><input type=\"text\" class=\"input\" name=\"orderNo\" id=\"updateNodeOrderNo\" value=\""+selectNode.orderNo+"\" onkeyup=\"(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)\"/></td></tr>\n" +
                "    </table>\n" +
                "</div>";

            ymPrompt.win({
                title: '修改',
                message: updateHtml,
                width: 300,
                height: 100,
                btn: [['修改', 'yes'], ['取消', 'cancel']],
                handler: function (btn) {
                    var param = {};
                    param['title'] = $('#updateNodeName').val();
//                    param['url'] = $('#updateNodeUrl').val();
//                    param['orderNo'] = $('#updateNodeOrderNo').val();
//                    param['icon'] = $('#updateIcon').val();
                    param['id'] = selectNode.id;
                    if (btn == 'yes') {
                        $.post("${pageContext.request.contextPath}/org/node/update", param, function (result) {
                            if (result == true) {
                                selectNode.name = param['title'];
//                                selectNode.url = param['url'];
//                                selectNode.orderNo = param['orderNo'];
//                                selectNode.icon = param['icon'];
                                zTree.updateNode(selectNode);
                            } else {
                                alert('更新组织异常！');
                            }
                        }, 'json');
                    }
                }
            });
        }

        function addTreeNode() {
            hideRMenu();
            var addHtml =
                "<div id=\"addTreeNode\" class=\"m20\">\n" +
                "    <table>\n" +
                "      <tr><td>组织名称</td><td><input type=\"text\" class=\"input\" name=\"name\" id=\"addNodeName\"/></td></tr>\n" +
//                    "      <tr><td>菜单URL</td><td><input type=\"text\" class=\"input\" name=\"url\" id=\"addNodeUrl\"/></td></tr>\n" +
//                    "      <tr><td>菜单图标</td><td><input type=\"text\" class=\"input\" name=\"icon\" id=\"addIcon\"/></td></tr>\n" +
//                    "      <tr><td>菜单排序</td><td><input type=\"text\" class=\"input\" name=\"orderNo\" value=\"0\" id=\"addNodeOrderNo\" onkeyup=\"(this.v=function(){this.value=this.value.replace(/[^0-9-]+/,'');}).call(this)\"/></td></tr>\n" +
                "    </table>\n" +
                "</div>";

            ymPrompt.win({
                title: '新增',
                message: addHtml,
                width: 300,
                height: 100,
                btn: [['保存', 'yes'], ['取消', 'cancel']],
                handler: function (btn) {
                    var param = {};
                    param['title'] = $('#addNodeName').val();
//                    param['url'] = $('#addNodeUrl').val();
//                    param['orderNo'] = $('#addNodeOrderNo').val();
//                    param['icon'] = $('#addIcon').val();
                    var selectNode = zTree.getSelectedNodes()[0];
                    param['pId'] = selectNode.id;
                    if (btn == 'yes') {
                        $.post("${pageContext.request.contextPath}/org/node", param, function (result) {
                            if (result != null || result != undefined) {
                                var node = {};
                                node['id'] = result.id;
                                node['pId'] = selectNode.id;
                                node['name'] = param['title'];
//                                node['url'] = param['url'];
//                                node['orderNo'] = param['orderNo'];
//                                node['icon'] = param['icon'];
                                zTree.addNodes(selectNode, node);
                            } else {
                                alert('保存组织异常！');
                            }
                        }, 'json');
                    }
                }
            });
        }

        function removeTreeNode() {
            hideRMenu();
            var nodes = zTree.getSelectedNodes();
            var param = {};
            param ['id'] = nodes[0].id;
            if (nodes && nodes.length > 0) {
//                if (nodes[0].isParent) {
//                    var msg = "正在删除的是父节点菜单【"+nodes[0].name+"】，如果删除将连同子菜单一起删掉。\n\n请确认！";
//                    ymPrompt.confirmInfo({title:'警告',message:msg,handler:function(v){
//                        if (v == 'ok') {
//                            $.post($('#baseUrl').val() + "/menu/delete.do",param,function(result){
//                                if (result.code == 0) {
//                                    zTree.removeNode(nodes[0]);
//                                } else {
//                                    alert('删除菜单异常！');
//                                }
//                            },'json');
//                        }}
//                    });
//                } else {
                ymPrompt.confirmInfo({
                    title: '提醒', message: '确认删除菜单：' + nodes[0].name + '?', handler: function (v) {
                        if (v == 'ok') {
                            $.post("${pageContext.request.contextPath}/org/node/delete", param, function (result) {
                                if (result == true) {
                                    zTree.removeNode(nodes[0]);
                                } else {
                                    alert('请先删除部门下的人员和部门！');
                                }
                            }, 'json');
                        }
                    }
                });
//                }
            }
        }

        function checkTreeNode(checked) {
            var nodes = zTree.getSelectedNodes();
            if (nodes && nodes.length > 0) {
                zTree.checkNode(nodes[0], checked, true);
            }
            hideRMenu();
        }

        function resetTree() {
            hideRMenu();
            $.fn.zTree.init($("#menuTree"), setting);
        }

        $(function () {
            $.fn.zTree.init($("#menuTree"), setting);
            zTree = $.fn.zTree.getZTreeObj("menuTree");
        });


    </script>
</head>

<body ng-controller="org-ctrl">
<div class="col-md-12">
    <!--左开始-->
    <div class="col-md-3">
        <div class="panel panel-default">
            <div class="panel-heading"></div>
            <div class="panel-body">
                <ul id="menuTree" class="ztree" style="height: 100%;width: auto;"></ul>
                <%--<input id="org-id" ng-change="getUserByOrgId()" value="0"  ng-model="orgId"/>--%>
            </div>
        </div>
    </div>
    <!--左结束-->
    <!--右开始-->
    <div class="col-md-9">
        <!--查询-->
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">查询</div>
                <div class="panel-body">
                    <form class="form-horizontal" style="width: auto">
                        <div class="form-group">
                            <label for="inputPassword" class="col-md-1 control-label">名称</label>
                            <div class="col-md-5">
                                <input type="text" class="form-control" id="inputPassword" ng-model="name">
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
                <button type="button" class="button button-pill" onclick="addUser()">添加人员</button>
            </div>
        </div>

        <!--按钮组借宿-->
        <!--表格-->
        <div class="col-md-12">
            <div class="panel panel-default">
                <div class="panel-heading">列表</div>
                <div class="panel-body">
                    <table class="table table-hover ">
                        <tr>
                            <th style="font-size: small">ID</th>
                            <th style="font-size: small">用户名</th>
                            <th style="font-size: small">昵称</th>
                            <th style="font-size: small">电话号码</th>
                            <th style="font-size: small">是否锁定</th>
                            <th style="font-size: small">用户类型</th>
                            <th style="font-size: small">创建时间</th>
                            <th style="font-size: small">操作</th>
                        </tr>
                        <tr ng-repeat="item in userList">
                            <td>
                                {{ $index + 1 + ((page.cpage-1) * 10)}}
                            </td>
                            <td ng-bind="item.username" style="font-size: small"></td>
                            <td ng-bind="item.nickname" style="font-size: small"></td>
                            <td ng-bind="item.phone" style="font-size: small"></td>
                            <td style="font-size: small">{{ item.locked | map : status_map : '' : '未知'}}</td>
                            <td style="font-size: small">{{ item.userType | typeFilter }}</td>
                            <td ng-bind="item.createTime" style="font-size: small"></td>
                            <td>
                                <button class="button button-caution button-box" ng-click="deleteOneUser(item.id)"><i
                                        class="glyphicon glyphicon-trash"></i></button>
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
                            <li ng-class="{'active':page.cpage == item}" ng-repeat="item in page.pagenum"
                                ng-click="pageclick(item)"><a href="#" ng-bind="item"></a></li>

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