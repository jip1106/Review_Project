<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="memberSharedBoard.model.vo.SharedBoard, member.model.vo.Member"%>
<%
	SharedBoard sb = (SharedBoard)request.getAttribute("sharedboard");
	//Member m = (Member)request.getAttribute("member");
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
		<div class="col-sm-8">
			<h3 class="header">Shareboard Write</h3>
			<p class="text-muted">회원들의 정보를 자유롭게 공유해주세요</p>
		
			<form role="form" action="/review/sinsert" method="post">
			<input type="hidden" name="id" value="<%= member.getId() %>">
				<div class="form-group">
					<label for="title">Title</label> 
					<input type="text" name="title" class="form-control" id="title" placeholder="title" required> 
					<span class="help-block"></span>
				</div>
				
				<div class="form-group">
					<label for="content">Content</label>
					<textarea cols="20" rows="20" name="content" class="form-control" 
						 id="content" placeholder="content" required></textarea>
					 <span class="help-block"></span>  
				</div>
				
				<!-- 
				<div class="form-group">
					<label for="image">image</label> <input type="file" name="image"
						class="form-control" id="image" placeholder="picture"> <span
						class="help-block"></span>
				</div>
				 -->
					<button type="submit" class="btn btn-primary">글작성</button>
					<button type="reset" class="btn btn-primary">작성 취소</button>
					<button  class="btn btn-primary" onclick="javascript:history.go(-1); return false">목 록</button> 
			</form>

		</div>
		</div>
</div>
</body>
</html>