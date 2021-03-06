<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="memberSharedBoard.model.vo.SharedBoard"%>
<%
	SharedBoard sb = (SharedBoard)request.getAttribute("sharedBoard");
	int currentPage = (Integer)request.getAttribute("currentPage");
%>    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <meta charset=utf-8>
    <!--<link rel="icon" href="img/favicon.ico">-->
	
	<!-- CSS Global -->
    <link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet">

    <!-- CSS Plugins -->
    <link href="${pageContext.request.contextPath}/resources/fonts/font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/resources/css/animate.css" rel="stylesheet">

    <!-- Google Fonts -->
    <link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700' rel='stylesheet' type='text/css'>
    <link href='http://fonts.googleapis.com/css?family=Roboto+Slab:100,300,400,700' rel='stylesheet' type='text/css'>
</head>
<body>
<%@ include file = "../../header.jsp" %>
<div class="container">
	<div class="row">
		<div align="left" style="margin-left: 15%; margin-right: 15%">
			<h3 style="color: black;"><b>Shareboard Update</b></h3>
			<p class="text-muted">회원들의 정보를 자유롭게 공유해주세요</p>
			
			<form role="form" name="" action="/review/supdate?no=<%=sb.getPostingNum() %>&page=<%=currentPage %>" method="post">
			<input type="hidden" name="no" value="<%= sb.getPostingNum() %>">
			
				<div class="form-group">
					<label for="title">Title</label> 
					<input type="text" name="title" class="form-control" 
					id="title" placeholder="title" value="<%= sb.getTitle() %>"> 
					<span class="help-block"></span>
				</div>
				
				<div class="form-group">
					<label for="content">Content</label>
					<textarea cols="20" rows="20" name="content" class="form-control"  
					id="content" placeholder="content">
					<%= sb.getContent()%>
					</textarea>
					 <span class="help-block"></span>  
				</div>
				
				<!--  
				<div class="form-group">
					<label for="image">image</label> <input type="file" name="image"
						class="form-control" id="image" placeholder="picture"> <span
						class="help-block"></span>
				</div>
				
				-->
				<div align="center">
					<button type="submit" class="btn btn-primary" style="background: red; width: 160px">수정하기</button>
					<button type="reset" class="btn btn-primary" onclick=" return reviewWriteCancel()" style="background: red; width: 160px">작성 취소</button>
					<button class="btn btn-primary" onclick="javascript:history.go(-1); return false" style="background: red; width: 160px">뒤로가기</button> 
				</div>
			</form>
		</div>
		</div>
</div>
<%@include file="../../footer.jsp" %> 
</body>
</html>