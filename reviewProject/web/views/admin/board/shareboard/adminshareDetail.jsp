<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="memberSharedBoard.model.vo.SharedBoard"%>
<% 
	SharedBoard sb = (SharedBoard)request.getAttribute("sb"); 
	int currentPage = ((Integer)request.getAttribute("currentPage")).intValue();
	int limit = (Integer)request.getAttribute("limit");
	int endPage = (Integer)request.getAttribute("endPage");
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
<%@ include file = "../../../../header.jsp" %>

<div class="container">
	<div class="row">
		<div class="col-sm-8 col-md-9">
			<a href="#"><span class="badge"><%= sb.getPostingNum()%>번 공지글 상세보기</span></a> <a
				href="#"><span class="badge">조회수 : <%=sb.getHits() %></span></a> <a
				href="#"><span class="badge">날짜 : <%=sb.getPostingDate() %></span></a>
		</div>
		<div class="nav nav-pills col-md-8 text-right">
			<a href="#">작성자 : <%= sb.getId() %></a> 
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-md-9">
				<div class="well well"><%=sb.getTitle() %></div>
				<div class="panel-body">
					<table>
						<tr>
							<td><%=sb.getContent() %></td>
						</tr>
					</table>
				</div>
				<div class="panel-footer">
					<div class="btn-group btn-group-justified">
						<a href="/review/adminsbfdelete?no=<%= sb.getPostingNum() %>&currentPage=<%=currentPage%>&limit=<%=limit%>&endPage=<%=endPage%>" class="btn btn-default">삭제</a>
						<a href="/review/adminsblist?page=<%=currentPage%>&limit=<%=limit%>&endPage=<%=endPage%>" class="btn btn-default">목 록</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 댓글공간 -->
	<div class="container">
		댓글 쓰는 공간
	
	</div>
	
	<div class="container">
		댓글 보여주는 공간
	</div>
</body>
</html>