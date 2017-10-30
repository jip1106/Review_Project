<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="memberComplainBoard.model.vo.ComplainBoard, java.util.ArrayList"%>
	<%
	ArrayList<ComplainBoard> list = (ArrayList<ComplainBoard>)request.getAttribute("list");
	int listCount = ((Integer)request.getAttribute("listCount")).intValue();
	int currentPage = ((Integer)request.getAttribute("Page")).intValue();
	
	int startPage = ((Integer)request.getAttribute("startPage")).intValue();
	int endPage = ((Integer)request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer)request.getAttribute("maxPage")).intValue();
	
	String searchValue = (String)request.getAttribute("searchValue");
	String searchKeyWord = (String)request.getAttribute("searchKeyWord");
	
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
<%@ include file="../../header.jsp" %>

<br><br>
<div class="row">
		<div class="col-sm-5">    
			<form class="form-inline topbar__search" role="form" action="/review/csearch" method="get" >
				<select class="selectpicker" name="searchValue" id="findType">
					<option value="findByTitle">제목</option>
				</select> 
				<label class="sr-only" for="nav-search">Search</label> 
				<input type="text" class="form-control" id="searchKeyWord" name="searchKeyWord">
				<button type="submit" id="searchSubmit">
					<i class="fa fa-search"></i>
				</button>
			</form>
		</div>
</div>

<div class="ui__section" id="ui_tables">  
	<h2 class="header">신고게시판</h2>
	<div class="table-responsive">
		<table class="table table-striped table-bordered">
		<%if(searchKeyWord == null){ %>
		<h3 align="left">총 게시글 갯수 : <%= listCount %></h3>
		<%}else{ %>
		<h3 align="left"> 검색된 게시글 수 : <%= request.getAttribute("SearchCount") %></h3>
		<%} %>
			<caption>불건전한 게시글 신고해주세요</caption>
			<thead>
				<tr>
					<th class="col-md-1">글번호</th>
					<th class="col-md-6">제목</th>
					<th class="col-md-1">작성자</th>
					<th class="col-md-1">작성일</th>
					<th class="col-md-1">조회수</th> 
				</tr>
			</thead>
			<tbody>
			<%
			for(ComplainBoard cb : list){
				%>
			<tr>
					<td class="col-md-1"><%= cb.getPostingNo() %></td>
					<td class="col-md-6"><a href="/review/cdetail?bnum=<%= cb.getPostingNo() %>&Page=<%= currentPage %>"><%= cb.getTitle() %></a></td> 
					<td class="col-md-1"><%= cb.getId() %></td>
					<td class="col-md-1"><%= cb.getPostingDate() %></td>
					<td class="col-md-1"><%= cb.getHits() %></td>
				</tr>
				<% } %>
			</tbody> 
		</table>
	</div>
	
	<!-- / .table-responsive -->
	
	<!-- 글작성버튼 -->
	<div class="ui__section" id="ui_buttons" align="right">
		<a href="/review/views/complainboard/complainboardWriteForm.jsp" class="btn btn-sm btn-primary">글작성</a> 
	</div>
	
	<!-- paging -->
	<div class="ui__section" id="ui_pagination" align="center">
		<nav>
			<ul class="pagination">
			<% if(searchKeyWord == null || searchKeyWord.equals("")) {%>
			<% if(currentPage <= 1){ %>
					<li><span aria-hidden="true">««</span></li>
				<%}else{ %>
					<li><a href="/review/clist?Page=<%= currentPage-1 %>" aria-label="Previous"><span
								aria-hidden="true">««</span></a></li>
				<% } %>
				
				<% for(int p = startPage; p<=endPage; p++){ 
					if(p==currentPage){%>
						<li class="active"><a><%= p %></a></li>
			 <%}else{ %>
			 	<li><a href="/review/clist?Page=<%= p %>"><%= p %></a></li>
			<% } %>
			<%} %>
			<%if(currentPage>=maxPage){ %>
				<li><span aria-hidden="true">»»</span></li>		
			<%}else{%>
			<li><a href="/review/clist?Page=<%= currentPage+1 %>"
				 aria-label="Next"><span aria-hidden="true">»»</span></a></li>
			<%} %>
			<%}else{ %>
			
			
			<!-- 여기부터 검색 -->
				<% if(currentPage <= 1){ %>
					<li><span aria-hidden="true">««</span></li>
				<%}else{ %>
					<li><a href="/review/csearch?searchValue=<%= searchValue%>&searchKeyWord=<%= searchKeyWord%>&Page=<%= currentPage-1 %>" aria-label="Previous"><span
								aria-hidden="true">««</span></a></li>
				<% } %>
				
				<% for(int p = startPage; p<=endPage; p++){ 
					if(p==currentPage){%>
						<li class="active"><a><%= p %></a></li>
			 <%}else{ %>
			 	<li><a href="/review/csearch?searchValue=<%= searchValue%>&searchKeyWord=<%= searchKeyWord%>&Page=<%= p%>"><%= p %></a></li>
			<% } %>
			<%} %>
			<%if(currentPage>=maxPage){ %>
				<li><span aria-hidden="true">»»</span></li>		
			<%}else{%>
			<li><a href="/review/csearch?searchValue=<%= searchValue%>&searchKeyWord=<%= searchKeyWord%>&Page=<%= currentPage+1 %>"
				 aria-label="Next"><span aria-hidden="true">»»</span></a></li>
				 
			<%}} %>
			</ul>
		</nav>
	</div>
	<!-- / .ui__section -->
</div>
</body>
</html>