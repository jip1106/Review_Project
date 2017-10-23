<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="memberReviewBoard.model.vo.ReviewBoard"%>
<% 
	int reviewNo = (Integer)request.getAttribute("reviewNo");
	int currentPage = (Integer)request.getAttribute("currentPage");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset=UTF-8>
<title>likeupfail</title>
<script type="text/javascript">
	alert("이미 좋아요를 누르셨습니다!");
	location.href="/review/ReviewDetail?no=<%=reviewNo%>&page=<%=currentPage%>";
</script>
</head>
<body>

</body>
</html>