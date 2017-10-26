package memberComplainComment.model.dao;

import java.sql.Connection;
import java.util.ArrayList;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import static common.JDBCTemplate.*;
import memberComplainComment.model.vo.ComplainComment;

public class ComplainCommentDao {
   public ComplainCommentDao(){}
   
   public int insertComplainComment(Connection con, int complainNo, String id, String content) {
      PreparedStatement pstmt = null;
      String query="insert into complain_comment values(complain_comment_seq.nextval,?,?,?,default)";
      int result = 0;
      
      try{
         pstmt = con.prepareStatement(query);
         pstmt.setInt(1, complainNo);
         pstmt.setString(2, id);
         pstmt.setString(3, content);
         result = pstmt.executeUpdate();
      }catch(Exception e){
         e.printStackTrace();
      }finally{
         close(pstmt);
      }
      return result;
   }
   
   
   
   public ArrayList<ComplainComment> selectComplainComment(Connection con, int complainNo) {
      PreparedStatement pstmt = null;
      ResultSet rset = null;
      ArrayList<ComplainComment> list = new ArrayList<ComplainComment>();
      ComplainComment comment = null;
      String query = "select * from complain_comment where posting_no = ? order by comment_no desc";
      
      try{
         pstmt = con.prepareStatement(query);
         pstmt.setInt(1, complainNo); 
         rset = pstmt.executeQuery();
         
         while(rset.next()){
            comment = new ComplainComment();
            comment.setCommentNo(rset.getInt("comment_no"));
            comment.setPostingNo(rset.getInt("posting_no"));
            comment.setId(rset.getString("id"));
            comment.setCommentContent(rset.getString("comment_content"));
            comment.setCommentDate(rset.getDate("comment_date"));
            list.add(comment);
            
            
         }
      }catch(Exception e){
         e.printStackTrace();
      }finally{
         close(rset);
         close(pstmt);
      }
      return list;
   }

   public int deleteComplainComment(Connection con, int commentNo, int complainNo) {
      PreparedStatement pstmt = null;
      String query = "delete from complain_comment where comment_no = ? and posting_no = ?";
      int result = 0;
      
      try{
         pstmt = con.prepareStatement(query);
         pstmt.setInt(1, commentNo);
         pstmt.setInt(2, complainNo);
         
         result = pstmt.executeUpdate();
      }catch(Exception e){
         e.printStackTrace();
      }finally{
         close(pstmt);
      }
      
      return result;
   }

   public int updateComplainComment(Connection con, int commentNo, int complainNo, String content) {
      PreparedStatement pstmt = null;
      String query = "update complain_comment set comment_content = ? where comment_no = ? and posting_no = ?";
      int result = 0;
      
      try{
         pstmt = con.prepareStatement(query);
         pstmt.setString(1, content);
         pstmt.setInt(2, commentNo);
         pstmt.setInt(3, complainNo); 
         result = pstmt.executeUpdate();
      }catch(Exception e){
         e.printStackTrace();
      }finally{
         close(pstmt);
      }
      return result;
   }
}