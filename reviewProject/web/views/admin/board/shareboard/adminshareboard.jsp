<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="java.util.*, memberSharedBoard.model.vo.SharedBoard"%>
<%
	ArrayList<SharedBoard> list = (ArrayList<SharedBoard>) request.getAttribute("list");
	int shareBoardListCount = ((Integer) request.getAttribute("shareBoardListCount")).intValue();
	int currentPage = ((Integer) request.getAttribute("currentPage")).intValue();
	int startPage = ((Integer) request.getAttribute("startPage")).intValue();
	int endPage = ((Integer) request.getAttribute("endPage")).intValue();
	int maxPage = ((Integer) request.getAttribute("maxPage")).intValue();
	int limit = ((Integer) request.getAttribute("limit")).intValue();

	String selectSearch = null;
	String inputValue = null;

	if ((String) request.getAttribute("selectSearch") != null) {
		selectSearch = (String) request.getAttribute("selectSearch");
	}
	if ((String) request.getAttribute("inputValue") != null) {
		inputValue = (String) request.getAttribute("inputValue");
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

<style>
.col-sm-8 {
	left: 50px;
}

.btn {
	background: #4D81B0;
	background-image: -webkit-linear-gradient(top, #4D81B0, #4D81B0);
	background-image: -moz-linear-gradient(top, #4D81B0, #4D81B0);
	background-image: -ms-linear-gradient(top, #4D81B0, #4D81B0);
	background-image: -o-linear-gradient(top, #4D81B0, #4D81B0);
	background-image: linear-gradient(to #4D81B0, #4D81B0, #4D81B0);
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
	background: #C2D6E9;
	background-image: -webkit-linear-gradient(top, #C2D6E9, #C2D6E9);
	background-image: -moz-linear-gradient(top, #C2D6E9, #C2D6E9);
	background-image: -ms-linear-gradient(top, #C2D6E9, #C2D6E9);
	background-image: -o-linear-gradient(top, #C2D6E9, #C2D6E9);
	background-image: linear-gradient(to bottom, #C2D6E9, #C2D6E9);
	text-decoration: none;
}
</style>


</head>

<body>
	<%@ include file="../../../../header.jsp"%>

	<br>
	<div align="left" style="margin-left: 10%; margin-right: 10%">
		<div align="left">
			<form class="form-group" role="form" method="post"
				action="/review/adminsbsearch">
				<select class="btn" id="selectSearch" name="selectSearch"
								style="height: 30px; color: #ffffff;">
					
					<option value="searchtitle">제목</option>
					<option value="searchid">작성자</option>
				</select> <input style="height: 25px; width: 200px;" type="search"
					id="inputValue" name="inputValue" placeholder="제목 혹은 작성자로 검색 "
					class="btn2">

				<button type="submit" id="searchSubmit" value="검색" class="btn"
					style="color: #ffffff;">검색</button>
				&nbsp;&nbsp;&nbsp;&nbsp;
			</form>
			<!-- btn-primary class : style.css에 있음 -->
		</div>
		<!--  공지등록 버튼 	-->
	</div>

	<div align="left" style="margin-left: 10%; margin-right: 10%">
		<h2>정보공유 게시판</h2>
		<%
			if (selectSearch == null) {
		%>
		<h3>
			전체 게시글 수 :
			<%=shareBoardListCount%></h3>
		<%
			} else {
		%>
		<h3>
			검색된 게시글 수 :
			<%= request.getAttribute("shareBoardListCount")%></h3>
		<%
			}
		%>
		<div class="table-responsive">
			<table class="table table-striped table-bordered">
				<caption>불건전한 게시글 신고해주세요</caption>
					<tr>
						<th style="background-color: #4D81B0; text-align: center; color: white;">글번호</th>
						<th style="background-color: #4D81B0; text-align: center; color: white;">제목</th>
						<th style="background-color: #4D81B0; text-align: center; color: white;">작성자</th>
						<th style="background-color: #4D81B0; text-align: center; color: white;">작성일</th>
						<th style="background-color: #4D81B0; text-align: center; color: white;">조회수</th>
						<th style="background-color: #4D81B0; text-align: center; color: white;">비고</th>
					</tr>
				<tbody>
					<%
						for (SharedBoard sb : list) {
					%>
					<tr>
						<td style="text-align: center;"><%=sb.getPostingNum()%></td>
						<td style="text-align: center;"><a
							href="/review/adminsbdetail?no=<%=sb.getPostingNum()%>&currentPage=<%=currentPage%>&limit=<%=limit%>&endPage=<%=endPage%>">
								<font color="red"><%=sb.getTitle()%></font></a></td>
						<td style="text-align: center;"><%=sb.getId()%></td>
						<td style="text-align: center;"><%=sb.getPostingDate()%></td>
						<td style="text-align: center;"><%=sb.getHits()%></td>
						<td style="text-align: center;"><a
							href="adminsbfdelete?no=<%=sb.getPostingNum()%>&currentPage=<%=currentPage%>&limit=<%=limit%>&endPage=<%=endPage%>">
								<button class="btn" style="background-color: #C2D6E9; color: white; text-align: center;">게시글 삭제</button>
						</a></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>
		</div>
		<!-- / .table-responsive -->



		<!-- paging -->
		<%
			if (selectSearch == null) {
		%>
		<div class="ui__section" id="ui_pagination" align="center">
			<nav>
				<ul class="pagination">
					<%-- 이전 페이지 있을 경우에 대한 처리 --%>
					<%
						if (currentPage <= 1) {
					%>
					<li><span aria-hidden="true">«</span></li>
					<%
						} else {
					%>
					<li><a aria-label="Previous"
						href="/review/adminsblist?page=<%=currentPage - 1%>"><span
							aria-hidden="true">«</span></a></li>
					<%
						}
					%>
					<%-- 현재 페이지 숫자 보여주기 --%>
					<%
						for (int p = startPage; p <= endPage; p++) {
								if (p == currentPage) {
					%>
					<li class="active"><a style="color: tomato"><%=p%></a></li>
					<%
						} else {
					%>
					<li><a href="adminsblist?page=<%=p%>"><%=p%></a></li>
					<%
						}
							}
					%>
					<%-- 현재 페이지 다음 페이지에 대한 처리 --%>
					<%
						if (currentPage >= maxPage) {
					%>
					<li><span aria-hidden="true">»</span></li>
					<%
						} else {
					%>
					<li><a aria-label="Next"
						href="/review/adminsblist?page=<%=currentPage + 1%>"><span
							aria-hidden="true">»</span></a></li>
					<%
						}
					%>
				</ul>
			</nav>
		</div>
		<%
			} else {
		%>
		<div class="ui__section" id="ui_pagination" align="center">
			<nav>
				<ul class="pagination">
					<%-- 이전 페이지 있을 경우에 대한 처리 --%>
					<%
						if (currentPage <= 1) {
					%>
					<li><a aria-label="Previous"><span aria-hidden="true">«</span></a></li>
					<%
						} else {
					%>
					<li><a aria-label="Previous"
						href="/review/adminsbsearch?selectSearch=<%=selectSearch%>&inputValue=<%=inputValue%>&page=<%=currentPage - 1%>"><span
							aria-hidden="true">«</span></a></li>
					<%
						}
					%>
					<%-- 현재 페이지 숫자 보여주기 --%>
					<%
						for (int p = startPage; p <= endPage; p++) {
								if (p == currentPage) {
					%>
					<li class="active"><a style="color: tomato"><%=p%></a></li>
					<%
						} else {
					%>
					<li><a
						href="/review/adminsbsearch?inputValue=<%=inputValue%>&selectSearch=<%=selectSearch%>&page=<%=p%>"><%=p %></a></li>
					<%
						}
							}
					%>
					<%-- 현재 페이지 다음 페이지에 대한 처리 --%>
					<%
						if (currentPage >= maxPage) {
					%>
					<li><span aria-hidden="true">»</span></li>
					<%
						} else {
					%>
					<li><a aria-label="Next"
						href="/review/adminsbsearch?selectSearch=<%=selectSearch%>&inputValue=<%=inputValue%>&page=<%=currentPage + 1%>"><span
							aria-hidden="true">»</span></a></li>
					<%
						}
					%>
				</ul>
			</nav>
		</div>
		<%
			}
		%>
		<!-- / .ui__section -->
	</div>
	<%@ include file = "../../../../footer.jsp" %>
</body>
</html>