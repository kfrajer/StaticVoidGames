<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
	<title>JarMatey - Static Void Games</title>
	
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://bootswatch.com/cyborg/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/bs.css"/>">

	<link rel="shortcut icon" href="<c:url value="/images/favicon.png"/>" />

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	
	<style>
		.list-group-item{
			padding: 0px;
		}
		
		ul {
			list-style-position: inside;
			padding-left:0;
		}
		
		h3{
			font-size: 20px;
		}
	</style>
	

</head>
<body style="background-image:url(<c:url value="${backgroundImage}"/>);">
<%@ include file="../include/analytics.jsp"%>
	<%@ include file="../include/navigation3.jsp" %>
	
<div class="container" style="margin-top:10px;">


		<div class="col-xs-2">
			<div class="panel panel-default">
				<div class="panel-heading">JarMatey</div>
				<div class="panel-body">
					<%@ include file="JarMateyNavigation.jsp" %>
				</div>
			</div>
		</div>
	
		<div class="col-xs-10" >
			<div class="panel panel-default">
				<div class="panel-heading">JarMatey</div>
		
				<div class="panel-body" >${content}</div>
			</div>
		</div>
	
    <%@ include file="../include/advertisement.jsp" %>
    <%@ include file="../include/openSource.jsp" %>
</div>

</body>
</html>