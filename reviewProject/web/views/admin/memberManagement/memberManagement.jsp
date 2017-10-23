<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.util.ArrayList,admin.model.service.MemberAdminService, admin.model.dao.MemberAdminDao "%>
<%
	ArrayList<Member> list = (ArrayList<Member>) (request.getAttribute("list"));
	int currentPage= (Integer)request.getAttribute("page");
	int startPage = (Integer)request.getAttribute("startPage");
	int endPage = (Integer)request.getAttribute("endPage");
	int maxPage = (Integer)request.getAttribute("maxPage");
	int listCount = (Integer)request.getAttribute("listCount");
	int limit = (Integer)request.getAttribute("limit");
	
	String searchValue = null;
	
	if(request.getAttribute("searchValue")!=null){
		searchValue = request.getParameter("searchValue");
	}
	

	
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<meta charset=utf-8>
<!--<link rel="icon" href="img/favicon.ico">-->

<!-- CSS Global -->
<link href="${pageContext.request.contextPath}/resources/css/styles.css"
	rel="stylesheet">

<!-- CSS Plugins -->
<link
	href="${pageContext.request.contextPath}/resources/fonts/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/animate.css"
	rel="stylesheet">

<!-- Google Fonts -->
<link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700'
	rel='stylesheet' type='text/css'>
<link
	href='http://fonts.googleapis.com/css?family=Roboto+Slab:100,300,400,700'
	rel='stylesheet' type='text/css'>
<title>관리자 회원관리 페이지</title>
<style type="text/css">
#imaginary_container {
	/*  margin-top:20%; /* Don't copy this */ */
	
}

.stylish-input-group .input-group-addon {
	background: white !important;
}

.stylish-input-group .form-control {
	border-right: 0;
	box-shadow: 0 0 0;
	border-color: #ccc;
}

.stylish-input-group button {
	border: 0;
	background: transparent;
}

.btn {
	background: #ff6347;
	background-image: -webkit-linear-gradient(top, #ff6347, #ff6347);
	background-image: -moz-linear-gradient(top, #ff6347, #ff6347);
	background-image: -ms-linear-gradient(top, #ff6347, #ff6347);
	background-image: -o-linear-gradient(top, #ff6347, #ff6347);
	background-image: linear-gradient(to bottom, #ff6347, #ff6347);
	-webkit-border-radius: 4;
	-moz-border-radius: 4;
	border-radius: 4px;
	font-family: Arial;
	color: #ffffff;
	font-size: 20px;
	padding: 10px 20px 10px 20px;
	text-decoration: none;
}

.btn:hover {
	background: #f75234;
	background-image: -webkit-linear-gradient(top, #f75234, #f75234);
	background-image: -moz-linear-gradient(top, #f75234, #f75234);
	background-image: -ms-linear-gradient(top, #f75234, #f75234);
	background-image: -o-linear-gradient(top, #f75234, #f75234);
	background-image: linear-gradient(to bottom, #f75234, #f75234);
	text-decoration: none;
}
</style>
</head>
<body>
	<%@ include file="../../../header.jsp"%>
	<br>
	<br>
	<br>

<form action = "/review/midSearch" method="post"> <!-- 서블릿으로 input 안에 있는 값 -->
	
	<div align="left" style="margin-left: 30%; margin-right: 30%">
		<div class="input-group stylish-input-group">
				<input type="text" class="form-control" placeholder="회원 id 검색" name="searchValue">
				<span class="input-group-addon">
			
					<button type="submit">
						<span class="glyphicon glyphicon-search"></span>
					</button>
			</span>
			
		</div>
	</div>
	
</form>
	<div align="left" style="margin-left: 10%; margin-right: 10%">
		<div class="table-responsive">
			<table class="table table-striped table-bordered" align="center">
				
				<caption>
				<%if(searchValue==null){ %>
					<h2>전체 회원 수 : <%=listCount %></h2>
				<%}else{ %>
					<h2>검색된 회원 수: <%=listCount %></h2> 
				<%}%>	
					<h2><%=member.getName()%>
					관리자님 경고횟수가 3 이상이면 삭제하세요</h2>
				</caption>
				
				<thead>
					<tr>
						<th>회원ID</th>
						<th>이름</th>
						<th>이메일</th>
						<th>경고주기</th>
						<th>경고횟수</th>
						<th>비고</th>
					</tr>
				</thead>
				<%
					for (Member m : list) {
				%>
				<tr>
					<td class="col-md-1"><%=m.getId()%></td>
					<td class="col-md-1"><%=m.getName()%></td>
					<td class="col-md-1"><%=m.getEmail()%></td>
					<td class="col-md-1">
						<%if (m.getUserType() == 1) {%>
						 <a href="/review/warningup?id=<%=m.getId()%>&page=<%=currentPage%>">
						 	<button class="btn" style="color: white" >경고주기</button>
						 </a>
						<%
							}
						%>
					</td>
					<td class="col-md-1" id="warningcount"><%=m.getWarningCount() %></td>
					<td class="col-md-1">
						<%
							if (m.getWarningCount() >= 3 && m.getUserType() == 1) {
						%>
						<!-- 쿼리스트링으로 id 값 서블릿으로 넘김 -->
						<a href = "/review/forceDelete?id=<%=m.getId()%>&page=<%=currentPage%>"><button class="btn" style="color: white">회원삭제</button></a>	<!-- a태그로 쿼리스트링 m.getUserId() -->
						<%
							}
						%>
					</td>
				</tr>
				<%
					}
				%>
			</table>
		</div>
	</div>
	<!-- / .table-responsive -->
	<!-- paging -->

<!-- paging -->
<!-- 검색 안했을 경우 -->
<%if(searchValue==null){ %>
	<div class="ui__section" id="ui_pagination" align="center">
			<nav>
				<ul class="pagination">
					<!-- 이전페이지 처리 -->
					<%if(currentPage<=1){ %> <!-- 현재 페이지가 1페이지면 이전페이지 못하게 -->
						<li><span aria-hidden="true">«««</span></li>
					<%}else{ %>	<!-- 현재 페이지가 2페이지면 이전페이지 누룰 수 있음 할 수 있음 -->
						<li><a href="/review/mlist?page=<%= currentPage-1 %>" aria-label="Previous"><span
								aria-hidden="true">«««</span></a></li>	
					<%} %>
					
					<!-- 페이지 보여주기 -->
					<%for(int p = startPage; p<=endPage; p++){ 
						if(p==currentPage){%>
							<li class="active"><a><%=p %></a></li>					
						<%}else{ %>
							<li><a href = "mlist?page=<%=p %>"><%=p %></a></li>
						<%} %>
					<%} %>
					
					<!-- 다음페이지 처리 -->
					<%if(currentPage>=maxPage){ %>
						<li><span aria-hidden="true">»»»</span></li>					
					<%}else{ %>
						<li><a href="/review/mlist?page=<%= currentPage+1 %>" aria-label="Next">
							<span aria-hidden="true">»»»</span></a></li>
					<%} %>
				</ul>
			</nav>
		</div>		
<%} %>		
<!-- 검색 했을 경우 -->
<%if(searchValue !=null){ %>
	<div class="ui__section" id="ui_pagination" align="center">
			<nav>
				<ul class="pagination">
					<!-- 이전페이지 처리 -->
					<%if(currentPage<=1){ %> <!-- 현재 페이지가 1페이지면 이전페이지 못하게 -->
						<li><span aria-hidden="true">«««</span></li>
					<%}else{ %>	<!-- 현재 페이지가 2페이지면 이전페이지 누룰 수 있음 할 수 있음 -->
						<li><a href="/review/mlist?page=<%= currentPage-1 %>&searchValue=<%=searchValue%>" aria-label="Previous"><span
								aria-hidden="true">«««</span></a></li>	
					<%} %>
					
					<!-- 페이지 보여주기 -->
					<%for(int p = startPage; p<=endPage; p++){ 
						if(p==currentPage){%>
							<li class="active"><a><%=p %></a></li>					
						<%}else{ %>
							<li><a href = "mlist?page=<%=p %>&searchValue=<%=searchValue%>"><%=p %></a></li>
						<%} %>
					<%} %>
					
					<!-- 다음페이지 처리 -->
					<%if(currentPage>=maxPage){ %>
						<li><span aria-hidden="true">»»»</span></li>					
					<%}else{ %>
						<li><a href="/review/mlist?page=<%= currentPage+1 %>&searchValue=<%=searchValue%>" aria-label="Next">
							<span aria-hidden="true">»»»</span></a></li>
					<%} %>
				</ul>
			</nav>
		</div>		
<%} %>
</body>
</html>