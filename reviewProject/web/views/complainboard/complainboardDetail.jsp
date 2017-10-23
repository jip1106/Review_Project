<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="memberComplainBoard.model.vo.ComplainBoard"%>
    <%
		ComplainBoard Complainboard = (ComplainBoard)request.getAttribute("Complainboard");
    	//int currentPage = ((Integer)request.getAttribute("Page")).intValue();
		
    	//바뀐부분
    	int index = (Integer)request.getAttribute("index");
    	int location = 0;
    	
    	if(index==1){
    		location =1;
    	}
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
<%@include file="../../header.jsp" %>

<div class="container">
	<div class="row">
		<div class="col-sm-8 col-md-9">
			<span class="badge"><%= Complainboard.getPostingNo() %></span>
			<span class="badge">조회수 : <%= Complainboard.getHits() %></span>
			<span class="badge">날짜 : <%= Complainboard.getPostingDate() %></span>
		</div>
		<div class="nav nav-pills col-md-8 text-right">
			<a href="#">작성자 : <%= Complainboard.getId() %></a> 
		</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-sm-8 col-md-9">
				<div class="well well"><%= Complainboard.getTitle() %></div>
				<div class="panel-body">
					<table>
						<tr>
							<td><%= Complainboard.getContent() %></td>
						</tr>
					</table>
				</div>
				<div class="panel-footer">
					<div class="btn-group btn-group-justified">
						<% if(member.getId().equals(Complainboard.getId())){ %>
						<a href="/review/cupdate?bnum=<%= Complainboard.getPostingNo() %>" class="btn btn-default">수정</a>
						<a href="/review/cdelete?bnum=<%= Complainboard.getPostingNo() %>&location=<%=location %>&index=<%=index %>" class="btn btn-default">삭제</a>
						<%-- <a href="/review/clist?Page=<%= currentPage %>" class="btn btn-default">목 록</a> --%>
						<a href="/review/clist?" class="btn btn-default">목 록</a>
						<% }else{ %>
						<%-- <a href="/review/clist?Page=<%= currentPage %>" class="btn btn-default">목 록</a> --%>
						<a href="/review/clist?" class="btn btn-default">목 록</a>
						<% } %>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- 댓글공간 -->
</body>
</html>