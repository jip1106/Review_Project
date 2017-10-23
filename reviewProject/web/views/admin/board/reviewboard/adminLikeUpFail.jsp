<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int currentPage = (Integer)(request.getAttribute("page"));
	int postNo = (Integer)(request.getAttribute("postNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>좋아요 실패</title>
<script type="text/javascript">
	alert("이미 좋아요를 누르셨습니다!");
	location.href="/review/adminReviewDetail?page=<%=currentPage%>&postNo=<%=postNo%>";
			
	
</script>
</head>
<body>

</body>
</html>