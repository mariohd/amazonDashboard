<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator"
	prefix="decorator"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/page" prefix="page"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/decorators/jstl.jsp"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>AWS Dashboard</title>
    
    <link href="<c:url value="/vendor/bootstrap/css/bootstrap.min.css"/>" rel="stylesheet">
    <link href="<c:url value="/vendor/metisMenu/metisMenu.min.css"/>" rel="stylesheet">
    <link href="<c:url value="/css/template/sb-admin-2.min.css"/>" rel="stylesheet">
    <link href="<c:url value="/css/template/amazonDashboard.css"/>" rel="stylesheet">
    <link href="<c:url value="/vendor/font-awesome/css/font-awesome.min.css" />" rel="stylesheet" type="text/css">
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>

<body>

    <div id="wrapper">

        <!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.html">AWS Dashboard</a>
            </div>
            
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li>
                            <a href="<c:url value="/"/>">
                            <em class="fa fa-dashboard fa-fw"></em> Dashboard</a>
                        </li>
                        <li>
                            <a href="<c:url value="/instances/list" />"><i class="fa fa-desktop fa-fw"></i> Instances</a>
                    	</li>
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>

        <!-- Page Content -->
        <div id="page-wrapper">
        	<decorator:body />
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <script src="<c:url value="/vendor/jquery/jquery.min.js"/>"></script>
    <script src="<c:url value="/vendor/bootstrap/js/bootstrap.min.js"/>"></script>
    <script src="<c:url value="/vendor/metisMenu/metisMenu.min.js"/>"></script>
    <script src="<c:url value="/js/template/sb-admin-2.min.js"/>"></script>
</body>
</html>
