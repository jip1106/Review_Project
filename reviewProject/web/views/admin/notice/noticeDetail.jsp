<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="adminNotice.model.vo.Notice,adminNotice.model.service.NoticeService,adminNotice.model.dao.NoticeDao" %>
<%
	Notice notice = (Notice)request.getAttribute("notice");
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
<%@include file="../../../../header.jsp" %>

<%if(member.getUserType()==0){ %><!-- 관리자 -->
<div class="container">
	<div class="row">
		<div class="col-sm-8 col-md-9">
			<a href="#"><span class="badge">No. <%=notice.getPostingNo() %></span></a> <a
				href="#"><span class="badge">조회수 : <%=notice.getHits() %></span></a> <a
				href="#"><span class="badge">날짜 : <%=notice.getPostingDate() %></span></a>
		</div>
		<div class="nav nav-pills col-md-8 text-right">
			작성자 : <%=notice.getId() %> 
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-md-9">
				<div class="well well">글 제목 : <%=notice.getTitle() %></div>
				<div class="panel-body">
					<table>
						<tr>
							<td><%=notice.getContent() %></td>
						</tr>
					</table>
				</div>
				<div class="panel-footer">
					
					<div class="btn-group btn-group-justified">
						<%if(member.getId().equals(notice.getId())){ %>
						
							<a href="/review/noticeupdateservlet?postno=<%=notice.getPostingNo()%>&title=<%=notice.getTitle()%>&content=<%=notice.getContent()%>" class="btn btn-default">수정하기</a> 						
							<a href="/review/noticedel?postno=<%=notice.getPostingNo()%>" class="btn btn-default">공지사항 삭제</a> 
						<%}%>
							<a href="views/admin/main/adminMain.jsp" class="btn btn-default">메인 화면으로 가기</a>						
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%}else{ %> <!-- 사용자 -->
<div class="container">
	<div class="row">
		<div class="col-sm-8 col-md-9">
			<a href="#"><span class="badge">No. <%=notice.getPostingNo() %></span></a> <a
				href="#"><span class="badge">조회수 : <%=notice.getHits() %></span></a> <a
				href="#"><span class="badge">날짜 : <%=notice.getPostingDate() %></span></a>
		</div>
		<div class="nav nav-pills col-md-8 text-right">
			작성자 : <%=notice.getId() %> 
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-md-9">
				<div class="well well">글 제목 : <%=notice.getTitle() %></div>
				<div class="panel-body">
					<table>
						<tr>
							<td><%=notice.getContent() %></td>
						</tr>
					</table>
				</div>
				<div class="panel-footer">
					<div class="btn-group btn-group-justified">
						<a href="views/main/main.jsp" class="btn btn-default">메인 화면으로 가기</a>						
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<%} %>

<!-- 댓글공간 -->
</body>
</html>