<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>

<title>${blog.getTitle()} by ${blog.getMember() } - Static Void Games</title>
<link rel="shortcut icon" href="<c:url value="/images/favicon.png"/>" />

  	<!-- Bootstrap core CSS -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.4/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://bootswatch.com/cyborg/bootstrap.min.css">
    
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/bs.css"/>">
    
    <link rel="stylesheet" type="text/css" href="<c:url value="/css/pageDown.css"/>">

	<script type="text/javascript" src="<c:url value="/js/Markdown.Converter.js" />"></script>
	<script type="text/javascript" src="<c:url value="/js/Markdown.Sanitizer.js" />"></script>
	<script type="text/javascript" src="<c:url value="/js/Markdown.Editor.js" />"></script>
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	
	<style>
		.profilePic{
			width:64px;
			height:64px;
		}
	</style>
	

	<script>
	
	var baseUrl = '<c:url value="/"/>';
	
	function updateAllPoints(){
		
		function updatePoints(index){
			if(index >= $( ".points" ).length){
				return;
			}
			else{
				
				var element = $( ".points" ).eq(index);
				var member = element.attr("class").split(' ')[1];
				
				$.ajax({url: baseUrl+"members/" + member + "/points", success: function(result){
					if(result){
						element.html("[" + result + "]");
					}
					updatePoints(index+1);
	    		}});
			}
		}
		
		updatePoints(0);
		}
	
	$(updateAllPoints);
	</script>
	
</head>

<body style="background-image:url(<c:url value="${backgroundImage}"/>);">
<%@ include file="../include/analytics.jsp"%>
<%@ include file="../include/navigation3.jsp" %>

    <div class="container">

	
	
	<c:if test="${isOwner}">
		<div style="width:200px; margin-left:auto; margin-right:auto;">
			<div class="panel panel-default" style="margin-top:25px;">
				<div class="panel-heading">This is your blog post.</div>
				<div class="panel-body">
					<a href="<c:url value="/blog/${blog.getUrlName()}/edit/" />">Click here to edit it.</a>			
				</div>
			</div>
		</div>
	</c:if>
	
	<div class="col-xs-12" style="margin-top:25px;">
	<div class="panel panel-default">
		<div class="panel-heading"><h2>${blog.getTitle()}</h2>
			<p>Author: <a href="<c:url value="/members/${blog.getMember()}" />">${blog.getMember()}</a> <span class="points ${blog.getMember()}">[]</span></p>
		</div>
	
		<div class="panel-body">${blog.getParsedText()}</div>
	</div>
	</div>
	

	
	
	<c:forEach items="${commentViews}" var="commentView">
		<div class="col-xs-12">
			<div class="panel panel-default">
  				<div class="panel-heading">
	    			<a href="<c:url value="/members/${commentView.getMember().getMemberName()}" />">
	      				<img class="profilePic" src="<c:url value="${commentView.getMemberPictureUrl() != null ? commentView.getMemberPictureUrl() : '/images/defaultProfilePictures/profile1.jpg'}" />"/>
	    				${commentView.getMember().getMemberName()}</a> <span class="points ${commentView.getMember().getMemberName()}">[]</span> - ${commentView.getFormattedDate()}
	    				<%-- TODO: this is stupid, but I can't figure out how to do this in one if statement. Should probably be on the server anyway? --%>
						<c:choose>
							<c:when test="${isOwner}">
								<span style="border:thin solid red; float:right; margin-right:100px;"><a href="<c:url value="/delete/comment/${commentView.getComment().getId()}"/>">Delete</a></span>
							</c:when>
							<c:when test="${loggedInUser eq commentView.getComment().getCommentingMember()}">
								<span style="border:thin solid red; float:right;margin-right:100px;"><a href="<c:url value="/delete/comment/${commentView.getComment().getId()}"/>">Delete</a></span>
							</c:when>
						</c:choose>
						
	    			
  				</div>
  				<div class="panel-body">
  					${commentView.getComment().getParsedComment()}
  				</div>
			</div>
		</div>
	</c:forEach>
	
	<div class="col-xs-12">
		<c:choose>
		<c:when test="${isLoggedIn}">
			<div class="panel panel-default">
				<div class="panel-heading">Leave a comment!</div>
				<div class="panel-body">
					<form action="<c:url value="/add/BlogComment/${blog.getUrlName()}"/>" method="post">
			
						<div class="wmd-panel">
							<div id="wmd-button-bar"></div>
							<textarea class="wmd-input" id="wmd-input" name="commentInput"></textarea>
						</div>
						<div class="wmd-panel"><p>Preview:</p></div>
						<div id="wmd-preview" class="wmd-panel wmd-preview"></div>
						
						<script type="text/javascript">
							(function() {
								var converter = Markdown.getSanitizingConverter();
								var editor = new Markdown.Editor(converter);
								editor.run();
			
							})();
						</script>
			
						<div class="centered"><input type="submit" value="Comment"></div>
			
					</form>
				</div>
			</div>
		</c:when>
		<c:otherwise>
			<div class="panel panel-default">
				<div class="panel-heading">Leave a comment!</div>
				<div class="panel-body"><a href="<c:url value="/login" />">Login</a> to leave a comment!</div>
			</div>
		</c:otherwise>
		</c:choose>
	</div>
	
    <%@ include file="../include/advertisement.jsp" %>
    <%@ include file="../include/openSource.jsp" %>
	</div>
	
</body>
</html>