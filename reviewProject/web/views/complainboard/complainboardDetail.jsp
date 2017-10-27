<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import="memberComplainBoard.model.vo.ComplainBoard,memberComplainComment.model.vo.ComplainComment,java.util.ArrayList,java.sql.Date"%>
    <%
      ComplainBoard Complainboard = (ComplainBoard)request.getAttribute("Complainboard"); 
       int currentPage = (Integer)request.getAttribute("Page");       
       
       String id = null;    		
       if(request.getAttribute("id")!=null){
    	   id = (String)request.getAttribute("id");
       }
       
       System.out.println("jsp id :=================== " + id);
        ArrayList<ComplainComment> commentList = (ArrayList<ComplainComment>)request.getAttribute("commentList");
       //바뀐부분
       int index = (Integer)request.getAttribute("index");
       int location = 0;
       
       if(index==1){
          location =1;
       }
       //문자열 자르기
       String str = Complainboard.getId();
    %>
<!DOCTYPE html>
<html lang="en"> 
<head>
   <script type="text/javascript" src="/review/js/jquery-3.2.1.min.js"></script> 
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
     
         <a href="#">작성자 : <%= str %></a> 
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
                  
                  <!--  <a href="/review/clist?Page=<%= currentPage %>" class="btn btn-default">목 록</a> -->
                  <a href="/review/clist" class="btn btn-default">목 록</a>
                     
                  <% }else{ %>
                   <%-- <a href="/review/clist?Page=<%= currentPage %>" class="btn btn-default">목 록</a>--%> 
                  <a href="/review/clist" class="btn btn-default">목 록</a>
                  <% } %>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>

<!-- 댓글공간 -->
<script type="text/javascript">
       $(document).ready(function(){
          var boardNo = "<%=Complainboard.getPostingNo()%>";
          var userId = "<%=member.getId()%>";
          var content = "";
         var commentNo = "";
         $("#sendComment").click(function() {
                        var comment = $("#sendContent").val(); 
                        var queryString = {no: boardNo, id: userId, content: comment};
                        $.ajax({
                                 type : "get",
                                 url : "/review/incomment",
                                 data : queryString,
                                 dataType: "json",
                                 success : function(data) { 
                                    var json = "";
                                    var j = JSON.parse(JSON.stringify(data));
                                    
                                    for (var i in j.list) {
                                       json += "<div class='comment'>";
                                       json += "<div class='comment__content' id='commentresetView'>";
                                       json += "<div class='comment__author_name'>"
                                       json += "아이디: "+decodeURIComponent(j.list[i].userId);
                                       json += "</div>";
                                       json += "시간: "+j.list[i].timePosted;
                                       json += "<br> 댓글내용";
                                       json += "<p>";
                                       json += j.list[i].content;
                                       json += "</p>";
                                       var id = decodeURIComponent(j.list[i].userId);
                                       var nowid="";
                                       nowid = "<%=member.getId()%>";   
                                       if (id == nowid) {
                                          json += "<div class='btn-group pull-right' role='group' aria-label='comment__actions'>";
                                          json += " <a  id='removeComment' class='btn btn-default btn-xs'><i class='fa fa-times'></i> Remove</a>";
                                          json += " <a  id='editComment' class='btn btn-default btn-xs'><i class='fa fa-edit'></i> Edit</a>";
                                          json += "</div>"
                                       }
                                       json += "<input type='hidden' id='commentNo'  value="
                                       json += j.list[i].commentNo
                                       json +=">"
                                       json += "</div></div>";
                                    }
                                     $("#commentView").html(json);
                         
                                     var deletehagoship = "<textarea class='form-control' rows='2' id='sendContent' placeholder='Enter your comment'></textarea>";
                                     $("#deletehagoship").html(deletehagoship);
                                 }
                                 //callback         
                              }); //ajax
                     }); // sendCommentclick 이벤트

         $("#commentView").on("click","#editComment",function() {
                        content = $(this).parent().prev().html().trim();
                        commentNo = $(this).parent().next().val();
                        $("#commentresetView").empty();
                        $("#commentresetView").html("<textarea class='form-control'"+"rows='2' id='comment'>"
                        + content+ "</textarea>"+ "<a id='updateComment' class='btn btn-default btn-xs'>"
                     + "<i class='fa fa-edit'></i> 수정하기</a>");

                     });//editComment (댓글 수정)

         $("#commentView").on("click","#updateComment",function(){
                     if(confirm("댓글을 수정하시겠습니까?")){
                        content = $(this).prev().val();
                        var queryString = {rNo: boardNo, cNo: commentNo, rcontent: content};
                        $.ajax({
                                 type : "get",
                                 url : "/review/upcomment",
                                 data : queryString,
                                 dataType: "json",
                                 success : function(data) {
                                    var json = "";
                                    var j =  JSON.parse(JSON.stringify(data));
                                    for (var i in j.list) {
                                       json += "<div class='comment'>";
                                       json += "<div class='comment__content' id='commentresetView'>";
                                       json += "<div class='comment__author_name'>"
                                       json += "아이디: "+decodeURIComponent(j.list[i].userId);
                                       json += "</div>";
                                       json += "시간: "+j.list[i].timePosted;
                                       json += "<br> 댓글내용";
                                       json += "<p>";
                                       json += j.list[i].content;
                                       json += "</p>";
                                       var id = decodeURIComponent(j.list[i].userId);
                                       
                                       var nowid="";
                                       nowid = "<%=member.getId()%>";

                                       if (id == nowid) {
                                          json += "<div class='btn-group pull-right' role='group' aria-label='comment__actions'>";
                                          json += " <a  id='removeComment'class='btn btn-default btn-xs'><i class='fa fa-times'></i> Remove</a>";
                                          json += " <a  id='editComment' class='btn btn-default btn-xs'><i class='fa fa-edit'></i> Edit</a>";
                                          json += "</div>"
                                       }
                                       json += "<input type='hidden' id='commentNo'  value="
                                       json += j.list[i].commentNo
                                       json +=">"
                                       json += "</div></div>";
                                    }
                                    $("#commentView").html(json);
                                 }
                           }); //ajax
                         }else{
                            location.href = "/review/cdetail?bnum=<%=Complainboard.getPostingNo()%>&Page=<%=currentPage%>";
                         }//confirm
                     }); //commentView 수정하기 버튼
         //삭제하기
         $("#commentView").on("click","#removeComment",function() {
                        if (confirm("댓글을 삭제하시겠습니까?")) {
                           commentNo = $(this).parent().next().val();
                           var queryString = {rNo: boardNo, cNo: commentNo};
                           $.ajax({
                                    type : "get",
                                    url : "/review/decomment",
                                    data : queryString,
                                    dataType: "json",
                                    success : function(data) {
                                       var json = "";
                                       var j =  JSON.parse(JSON.stringify(data));
                                       for (var i in j.list) {
                                          json += "<div class='comment'>";
                                          json += "<div class='comment__content' id='commentresetView'>";
                                          json += "<div class='comment__author_name'>"
                                          json += "아이디: "+decodeURIComponent(j.list[i].userId);
                                          json += "</div>";
                                          json += "시간: "+j.list[i].timePosted;
                                          json += "<br> 댓글내용";
                                          json += "<p>";
                                          json += j.list[i].content;
                                          json += "</p>";
                                          var id = decodeURIComponent(j.list[i].userId);
                                          var nowid="";
                                          nowid = "<%=member.getId()%>";

                                          if (id == nowid) {
                                             json += "<div class='btn-group pull-right' role='group' aria-label='comment__actions'>";
                                             json += " <a id='removeComment'class='btn btn-default btn-xs'><i class='fa fa-times'></i> Remove</a>";
                                             json += " <a  id='editComment' class='btn btn-default btn-xs'><i class='fa fa-edit'></i> Edit</a>";
                                             json += "</div>"
                                          }
                                          json += "<input type='hidden' id='commentNo'  value="
                                          json += j.list[i].commentNo
                                          json +=">"
                                          json += "</div></div>";
                                       }
                                       $("#commentView").html(json);
                                    }
                                 }); //ajax
                        } else {
                           location.href = "/review/cdetail?bnum=<%=Complainboard.getPostingNo()%>&Page=<%=currentPage%>";
                        }
                     }); //commentView 삭제하기 버튼
          
       }); 
</script>
   
   <div class="col-sm-5">
      <div class="badge">댓글을 입력해주세요</div>
   </div> 
         <div class="col-sm-8 col-md-9">
            <div class="comment comment_new">
               <div class="comment__author_img"><%=member.getName()%></div>
               <div class="comment__content">
                  <form>
                     <div class="form-group">
                        <label for="comment-new__textarea" class="sr-only">Enteryour comment</label>
                        <div id="deletehagoship">
                        <textarea class="form-control" rows="2" id="sendContent" placeholder="Enter your comment"></textarea></div>
                     </div>
                     <button type="button" id="sendComment" class="btn btn-primary" >Send Comment</button> 
                  </form>
               </div>
               <!-- / .comment__content -->
            </div>
            <!-- / .comment__new -->
            
            <!-- Comments header -->
            <div class="comment__header">
               <span>List of Comments</span>
            </div>

            <!-- All comments -->
            <div id="commentView">
               <%for(int i = 0; i<commentList.size(); i++){%>
                  <div class="comment">
                     <div class="comment__content" id="commentresetView">
                        <div class="comment__author_name">
                           아이디: <%=commentList.get(i).getId()%> 
                        </div>
                           시간: <%=commentList.get(i).getDate()%><br>
                           댓글내용
                           <p><%=commentList.get(i).getCommentContent()%></p> 
                        <%if(member.getId().equals(commentList.get(i).getId())){%> 
                           <div class="btn-group pull-right" role="group" aria-label="comment__actions" onclick="window.scrollTo(10,10);">
                              <a id="removeComment"class="btn btn-default btn-xs"><i class="fa fa-times"></i>Remove</a> 
                              <a id="editComment"class="btn btn-default btn-xs"><i class="fa fa-edit"></i>Edit</a> 
                           </div>
                           <input type="hidden" id="commentNo" value="<%=commentList.get(i).getCommentNo()%>">
                        <%}%>
                     </div>
                     <!-- / .comment__content -->
                  </div>
                  <!-- / .comment -->
               <%}%>
            </div>
         </div>
 </body>
</html>