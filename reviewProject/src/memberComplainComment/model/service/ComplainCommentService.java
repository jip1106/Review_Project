package memberComplainComment.model.service;


import java.sql.Connection;
import java.util.ArrayList;

import memberComplainComment.model.dao.ComplainCommentDao;
import memberComplainComment.model.vo.ComplainComment;
import java.sql.*;


import com.sun.corba.se.impl.ior.GenericTaggedComponent;

import static common.JDBCTemplate.*;

public class ComplainCommentService {
   
   public ComplainCommentService(){}


   public int insertComplainComment(int complainNo, String id, String content) {
      Connection con = getConnection();
      int result = new ComplainCommentDao().insertComplainComment(con,complainNo,id,content);
      if(result > 0){
         commit(con);
      }else{
         rollback(con);
      }
      close(con); 
      return result;
   }

   public ArrayList<ComplainComment> selectComplainComment(int complainNo) {
      Connection con = getConnection();
      ArrayList<ComplainComment> list = new ComplainCommentDao().selectComplainComment(con,complainNo);
      return list;
   }


   public int deleteComplainComment(int commentNo, int complainNo) {
      Connection con = getConnection();
      int result = new ComplainCommentDao().deleteComplainComment(con,commentNo,complainNo);
      
      if(result > 0){
         commit(con);
      }else{
         rollback(con);
      }
      close(con);
      return result;
   }


   public int updateReviewComment(int commentNo, int complainNo, String content) {
      Connection con = getConnection();
      int result = new ComplainCommentDao().updateComplainComment(con,commentNo,complainNo,content);
      
      if(result > 0){
         commit(con);
      }else{
         rollback(con);
      }
      close(con);
      return result;
   }

   

}