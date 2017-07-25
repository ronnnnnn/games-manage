<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">

<head>
    <meta charset="utf-8" />
    <title>游戏管理系统</title>
    <meta name="description" content="app, web app, responsive, responsive layout, admin, admin panel, admin dashboard, flat, flat ui, ui kit, AngularJS, ui route, charts, widgets, components" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/bootstrap.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/animate.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/font-awesome.min.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/simple-line-icons.css" type="text/css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/font.css" type="text/css" />
    <script src="${pageContext.request.contextPath}/static/angular/vendor/jquery/jquery.min.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/angular/css/app.css" type="text/css" />
</head>

<body  style="height: 100%">
<div class="app app-header-fixed"  id="app">
    <!-- navbar -->
    <div class="app-header navbar">
        <!-- navbar header -->
        <div class="navbar-header bg-dark">
            <button class="pull-right visible-xs dk" data-toggle="class:show" data-target=".navbar-collapse">
                <i class="glyphicon glyphicon-cog"></i>
            </button>
            <button class="pull-right visible-xs" data-toggle="class:off-screen" data-target=".app-aside" ui-scroll="app">
                <i class="glyphicon glyphicon-align-justify"></i>
            </button>
            <!-- brand -->
            <a href="main.html" target="content_frame" class="navbar-brand text-lt">
                <i class="fa fa-btc"></i>
                <img src="${pageContext.request.contextPath}/static/angular/img/logo.png" alt="." class="hide">
                <span class="hidden-folded m-l-xs">游戏管理系统</span>
            </a>
            <!-- / brand -->
        </div>
        <!-- / navbar header -->
        <!-- navbar collapse -->
        <div class="collapse pos-rlt navbar-collapse box-shadow bg-white-only">
            <!-- buttons -->
            <div class="nav navbar-nav hidden-xs">
                <a href="#" class="btn no-shadow navbar-btn" data-toggle="class:app-aside-folded" data-target=".app">
                    <i class="fa fa-dedent fa-fw text"></i>
                    <i class="fa fa-indent fa-fw text-active"></i>
                </a>
                <a href class="btn no-shadow navbar-btn" data-toggle="class:hide" data-target="#aside-user">
                    <i class="icon-user fa-fw"></i>
                </a>
            </div>
            <!-- / buttons -->
            <!-- link and dropdown -->
            <!-- / link and dropdown -->
            <!-- search form -->
            <form class="navbar-form navbar-form-sm navbar-left shift" ui-shift="prependTo" role="search">
                <div class="form-group">
                    <div class="input-group">
                        <input type="text" ng-model="selected" typeahead="state for state in states | filter:$viewValue | limitTo:8" class="form-control input-sm bg-light no-border rounded padder" placeholder="Search projects...">
                        <span class="input-group-btn">
                <button type="submit" class="btn btn-sm bg-light rounded"><i class="fa fa-search"></i></button>
              </span>
                    </div>
                </div>
            </form>
            <!-- / search form -->
            <!-- nabar right -->
            <ul class="nav navbar-nav navbar-right">
                <li class="dropdown">
                    <a href="#" data-toggle="dropdown" class="dropdown-toggle clear" data-toggle="dropdown">
                            <span class="thumb-sm avatar pull-right m-t-n-sm m-b-n-sm m-l-sm">
                <img src="${pageContext.request.contextPath}/static/angular/img/a1.jpg" alt="...">
                <i class="on md b-white bottom"></i>
              </span>
                        <span class="hidden-sm hidden-md">系统管理员</span> <b class="caret"></b>
                    </a>
                    <!-- dropdown -->
                    <ul class="dropdown-menu animated fadeInRight w">
                        <li class="wrapper b-b m-b-sm bg-light m-t-n-xs">
                            <div>
                                <p>系统操作</p>
                            </div>
                            <progressbar value="60" class="progress-xs m-b-none bg-white"></progressbar>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/logout">注销</a>
                        </li>
                    </ul>
                    <!-- / dropdown -->
                </li>
            </ul>
            <!-- / navbar right -->
        </div>
        <!-- / navbar collapse -->
    </div>
    <!-- / navbar -->
    <!-- menu -->
    <div class="app-aside hidden-xs bg-dark">
        <div class="aside-wrap">
            <div class="navi-wrap">
                <!-- user -->
                <div class="clearfix hidden-xs text-center " id="aside-user">
                    <div class="dropdown wrapper">
                        <a ui-sref="app.page.profile">
                                <span class="thumb-lg w-auto-folded avatar m-t-sm">
                  <img src="${pageContext.request.contextPath}/static/angular/img/a0.jpg" class="img-full" alt="...">
                </span>
                        </a>
                        <a href="#" data-toggle="dropdown" class="dropdown-toggle hidden-folded">
                                <span class="clear">
                  <span class="block m-t-sm">
                    <strong class="font-bold text-lt">系统管理员</strong>

                  </span>
                                </span>
                        </a>
                        <!-- dropdown -->
                        <!-- / dropdown -->
                    </div>
                    <div class="line dk hidden-folded"></div>
                </div>
                <!-- / user -->
                <!-- nav -->
                <nav ui-nav class="navi">
                    <ul class="nav">
                        <li class="hidden-folded padder m-t m-b-sm text-muted text-xs">
                            <span translate="aside.nav.HEADER">功能列表</span>
                        </li>

                        <c:forEach items="${menus}" var="rootMenu">
                            <li>
                                <a href class="auto">
                                    <span class="pull-right text-muted">
                                <i class="fa fa-fw fa-angle-right text"></i>
                                <i class="fa fa-fw fa-angle-down text-active"></i>
                            </span>
                                    <i class="glyphicon glyphicon-leaf icon text-success"></i>
                                    <span class="font-bold" translate="aside.nav.DASHBOARD">${rootMenu.key}</span>
                                </a>
                                <ul class="nav nav-sub dk">
                                    <c:forEach items="${rootMenu.value}" var="childMenu">
                                        <li ui-sref-active="active">
                                            <a href="${pageContext.request.contextPath}${childMenu.url}" target="content_frame">
                                                <span>${childMenu.resourceName}</span>
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                            </li>
                        </c:forEach>

                    </ul>
                </nav>
                <!-- nav -->
                <!-- aside footer -->
                <!-- <div class="wrapper m-t">
        <div class="text-center-folded">
          <span class="pull-right pull-none-folded">60%</span>
          <span class="hidden-folded" translate="aside.MILESTONE">Milestone</span>
        </div>
        <div class="progress progress-xxs m-t-sm dk">
          <div class="progress-bar progress-bar-info" style="width: 60%;">
          </div>
        </div>
        <div class="text-center-folded">
          <span class="pull-right pull-none-folded">35%</span>
          <span class="hidden-folded" translate="aside.RELEASE">Release</span>
        </div>
        <div class="progress progress-xxs m-t-sm dk">
          <div class="progress-bar progress-bar-primary" style="width: 35%;">
          </div>
        </div>
      </div> -->
                <!-- / aside footer -->
            </div>
        </div>
    </div>
    <!-- / menu -->
    <!-- content -->
    <div class="app-content" style="height: auto">
        <iframe src="${pageContext.request.contextPath}/page/main/" style="width: 100%;" frameborder="0"  id="content_frame" name="content_frame" onload="setIframeHeight(this)">
        </iframe>
    </div>
    <!-- /content -->
    <!-- aside right -->

    <!-- / aside right -->
    <!-- footer -->
    <div class="app-footer wrapper b-t bg-light" style="margin-bottom: 0%">
        <span class="pull-right">1.0.0 <a href="#app" class="m-l-sm text-muted"><i class="fa fa-long-arrow-up"></i></a></span> &copy; 2017 Copyright.
    </div>
    <!-- / footer -->
</div>
<!-- jQuery -->
<script src="${pageContext.request.contextPath}/static/angular/vendor/jquery/bootstrap.js"></script>
<script type="text/javascript">
    + function($) {
        $(function() {
            // class
            $(document).on('click', '[data-toggle^="class"]', function(e) {
                e && e.preventDefault();
                console.log('abc');
                var $this = $(e.target),
                        $class, $target, $tmp, $classes, $targets;
                !$this.data('toggle') && ($this = $this.closest('[data-toggle^="class"]'));
                $class = $this.data()['toggle'];
                $target = $this.data('target') || $this.attr('href');
                $class && ($tmp = $class.split(':')[1]) && ($classes = $tmp.split(','));
                $target && ($targets = $target.split(','));
                $classes && $classes.length && $.each($targets, function(index, value) {
                    if ($classes[index].indexOf('*') !== -1) {
                        var patt = new RegExp('\\s' +
                                $classes[index].replace(/\*/g, '[A-Za-z0-9-_]+').split(' ').join('\\s|\\s') +
                                '\\s', 'g');
                        $($this).each(function(i, it) {
                            var cn = ' ' + it.className + ' ';
                            while (patt.test(cn)) {
                                cn = cn.replace(patt, ' ');
                            }
                            it.className = $.trim(cn);
                        });
                    }
                    ($targets[index] != '#') && $($targets[index]).toggleClass($classes[index]) || $this.toggleClass($classes[index]);
                });
                $this.toggleClass('active');
            });

            // collapse nav
            $(document).on('click', 'nav a', function(e) {
                var $this = $(e.target),
                        $active;
                $this.is('a') || ($this = $this.closest('a'));

                $active = $this.parent().siblings(".active");
                $active && $active.toggleClass('active').find('> ul:visible').slideUp(200);

                ($this.parent().hasClass('active') && $this.next().slideUp(200)) || $this.next().slideDown(200);
                $this.parent().toggleClass('active');

                $this.next().is('ul') && e.preventDefault();

                setTimeout(function() {
                    $(document).trigger('updateNav');
                }, 300);
            });
        });
    }(jQuery);

    function setIframeHeight(iframe) {
        if (iframe) {
            // var iframeWin = iframe.contentWindow || iframe.contentDocument.parentWindow;
            // if (iframeWin.document.body) {
            //     iframe.height = iframeWin.document.documentElement.scrollHeight || iframeWin.document.body.scrollHeight;
            //     iframe.height = window.innerHeight-50-51;
            // }
            iframe.height = window.innerHeight-50-51;
            // $("#external-frame").height(($(window).height()-50-51)+"px");

        }


    };

    window.onload = function() {

        setIframeHeight(document.getElementById('content_frame'));
    };

</script>
</body>

</html>