<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="en" ng-app="setting-app">

<head>
    <meta charset="utf-8" />
    <title>公告列表</title>
    <meta name="description" content="app, web app, responsive, responsive layout, admin, admin panel, admin dashboard, flat, flat ui, ui kit, AngularJS, ui route, charts, widgets, components" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <%--<link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/bootstrap.css" type="text/css" />--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/buttons.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/multiple-select/multiple-select.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/multiple-select/demos/assets/bootstrap/css/bootstrap.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-fileinput/css/fileinput.min.css"/>
    <script src="${pageContext.request.contextPath}/static/angular/js/angular.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/angular/controll/setting-list.js"></script>
    <script src="${pageContext.request.contextPath}/static/multiple-select/demos/assets/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/multiple-select/multiple-select.js"></script>
    <script src="${pageContext.request.contextPath}/static/bootstrap-fileinput/js/fileinput.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/bootstrap-fileinput/js/locales/zh.js"></script>


    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jslib/syUtils.js"></script>

    <!-- jQuery -->
    <%--<script src="${pageContext.request.contextPath}/static/angular/vendor/jquery/jquery.min.js"></script>--%>
    <script src="${pageContext.request.contextPath}/static/angular/vendor/jquery/bootstrap.js"></script>
    <style type="text/css">
        
    </style>

    <!-- /.modal -->
    <script>

        function clearInput() {
            $('#password').val('');
        }

        function getScope() {
            var appElement = document.querySelector('[ng-controller=setting-ctrl]');
            //获取$scope变量
            var $scope = angular.element(appElement).scope();
            //上一行改变了msg的值，如果想同步到Angular控制器中，则需要调用$apply()方法即可
             $scope.$apply();
            //调用控制器中的getData()方法
            // console.log($scope.getData());
            return $scope;
        }


    </script>
    <script>
        $(function () { $('#addSettingModal').modal('hide')});
    </script>

    <script>
        $(function () { $('#addSettingModal').on('hide.bs.modal', function () {
            $('#addType').val('');
            $('#addName').val('');
            $('#addCode').val('');
            $('#addValue').val('');
            $('#addDescription').val('');
            $('#addImageUrl').fileinput('refresh');
        })});
    </script>

    <script>
        //初始化fileinput控件（第一次初始化）
        function initFileInput(ctrlName, uploadUrl) {
            var control = $('#' + ctrlName);

            var extra = '';
            var key = '';
            var imageUrl = '';
            control.fileinput({
                language: 'zh', //设置语言
                uploadUrl: uploadUrl, //上传的地址
                allowedFileExtensions : ['jpg', 'png','gif'],//接收的文件后缀
                showUpload: true, //是否显示上传按钮
                showCaption: false,//是否显示标题
                browseClass: "btn btn-primary", //按钮样式
                initialPreviewConfig:[],
                previewFileIcon: "<i  class='glyphicon glyphicon-king'></i>",
            }).     on("fileuploaded", function(event, data) {
                if(data.response)
                {
                    alert('上传处理成功');
                    var d = data.response['initialPreviewConfig'];
                    var d2 = d[0];
                    imageUrl = d2['caption'];
                    getScope().addValue = imageUrl;
                    getScope().editValue = imageUrl;
                    $('#addValue').val(imageUrl);
                    $('#editValue').val(imageUrl);
                    extra = d2['extra'];
                    key = d2['key'];
                    //getScope().myAddImageUrl = imageUrl;

                }
            })
                .on('fileclear', function(event) {
                    var param = {};
                    param['fileName'] = key;
                    $.ajax({
                        cache: true,
                        type: "POST",
                        url : "/file/delete",
                        data:  param,
                        async: false,
                        error: function(request) {
                            alert("Connection error");
                        },
                        success: function(data) {
                            $("#commonLayout_appcreshi").parent().html(data);
                            $('#addValue').val('');
                            $('#editValue').val('');
                        }
                    });
                })
        }

        $(function () {
            initFileInput("addImageUrl",getRootPath() + "/file/upload");
        })
    </script>

    <script>
        $(function () {
            initFileInput("editImageUrl",getRootPath() + "/file/upload");
        })
    </script>
</head>

<body  ng-controller="setting-ctrl" style="height: auto">

    <!--按钮组-->
    <div class="col-md-12" style="margin-bottom:20px;">
        <div class="button-group">
            <button type="button" class="button button-pill"  data-toggle="modal" data-target="#addSettingModal">添加属性</button>
        </div>
    </div>
    <!--按钮组结束-->
    <!--添加模态框-->
    <div class="modal fade" id="addSettingModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document" style="width: 800px">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">添加属性</h4>
                </div>
                <div class="modal-body" style="width: 800px">
                    <form name="addForm" class="form-horizontal">
                        <div class="form-group">
                            <label for="addType" class="col-sm-2 control-label">类别</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="addType" ng-model="addType">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="addName" class="col-sm-2 control-label">属性名</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="addName" ng-model="addName">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="addCode" class="col-sm-2 control-label">排序编码</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="addCode" ng-model="addCode">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="addValue" class="col-sm-2 control-label">属性值</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="addValue" ng-model="addValue">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="addDescription" class="col-sm-2 control-label">描述</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="addDescription" ng-model="addDescription">
                            </div>
                        </div>
                        <%--<div class="form-group" style="height: 500px">--%>
                            <%--<label for="addImageUrl" class="col-sm-2 control-label">图片</label>--%>
                            <%--<div class="col-sm-10" style="height: 340px;">--%>
                                <%--<input id="addImageUrl" name="file" ng-model="addImageUrl" class="form-control" type="file">--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" ng-click="addSetting()">添加</button>
                </div>
            </div>
            <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
    </div>

    <!--修改模态框-->
    <div class="modal fade" id="editSettingModal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document" style="width: 800px">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">修改属性</h4>
                </div>
                <div class="modal-body" style="width: 800px">
                    <form name="editForm" class="form-horizontal">
                        <div class="form-group">
                            <label for="editType" class="col-sm-2 control-label">类别</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="editType" ng-model="editType">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="editName" class="col-sm-2 control-label">属性名</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="editName" ng-model="editName">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="editCode" class="col-sm-2 control-label">编码</label>
                            <div class="col-sm-10">
                                <input readonly type="text" class="form-control" id="editCode" ng-model="editCode">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="editValue" class="col-sm-2 control-label">属性值</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="editValue" ng-model="editValue">
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="editDescription" class="col-sm-2 control-label">描述</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" id="editDescription" ng-model="editDescription">
                            </div>
                        </div>
                        <%--<div class="form-group" style="height: 500px">--%>
                            <%--<label for="editImageUrl" class="col-sm-2 control-label"></label>--%>
                            <%--<div class="col-sm-10" style="height: 340px;">--%>
                                <%--<input id="editImageUrl" name="file" ng-model="editImageUrl" class="form-control" type="file">--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" ng-click="editSetting()">修改</button>
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
                        <th>类别</th>
                        <th>属性名</th>
                        <th>属性值</th>
                        <th>编码</th>
                        <th>描述</th>
                        <th>操作</th>
                    </tr>
                    <tr ng-repeat="item in settingList">
                        <td>
                            {{ $index + 1 + ((page.cpage-1) * 10)}}
                        </td>
                        <td>{{item.sysType}}</td>
                        <td>{{item.sysName}}</td>
                        <td>{{item.sysValue}}</td>
                        <td>{{item.sysCode}}</td>
                        <td>{{item.sysDescription}}</td>
                        <td>
                            <button type="button" class="button button-action button-box" data-toggle="modal" data-target="#editSettingModal"  ng-click="setSettingInfo(item)"><i class="glyphicon glyphicon-edit"></i></button>
                            <button class="button button-caution button-box" ng-click="deleteSetting(item.id)"><i class="glyphicon glyphicon-trash"></i></button>
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
