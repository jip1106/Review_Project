package memberReviewBoard.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import member.model.vo.Member;
import memberReviewBoard.model.dao.ReviewBoardDao;
import memberReviewBoard.model.vo.ReviewBoard;
import memberReviewBoard.model.vo.ReviewBoardImage;
import memberReviewBoard.model.vo.ReviewLike;
import memberReviewComment.model.vo.ReviewComment;

public class ReviewBoardService {

   public int insertReview(ReviewBoard review) {
      Connection con = getConnection();
      ReviewBoardDao rdao = new ReviewBoardDao();

      int result = rdao.insertReview(con, review);
      
      if(result > 0) {
         commit(con);
      } else {
         rollback(con);
      }
      close(con);
      return result;
   }

   public ArrayList<ReviewBoard> selectReview(int currentPage, int limit) {
      Connection con = getConnection();
      ArrayList<ReviewBoard> list = new ReviewBoardDao().selectReview(con, currentPage, limit);
      close(con);
      return list;
   }

   public int reviewDelete(int reviewNo) {
      Connection con = getConnection();
      ReviewBoardDao rdao = new ReviewBoardDao();
      int result = rdao.reviewDelete(con, reviewNo);
      if (result > 0) {
         commit(con);
      }else{
         rollback(con);
      }
      close(con);
      return result;
   }

   public int reviewLikeUp(int reviewNo, String writer){
      Connection con = getConnection(); 
      int result = 0;
      
      ReviewBoardDao rboardDAO = new ReviewBoardDao();
      ReviewLike like = new ReviewLike();
      
      like = rboardDAO.checkLike(con, reviewNo, writer); 
      
      if(like == null){
         if(rboardDAO.insertLike(con,reviewNo,writer) > 0){
            if(rboardDAO.likeStateUp(con,reviewNo,writer) > 0){
               
               if(rboardDAO.reviewLikeUp(con,reviewNo) > 0){ 
                  commit(con);
               }else{
                  rollback(con);
               }
               commit(con);
            }else{
               rollback(con);
            }
            commit(con);
         }else{
            rollback(con);
         }
         result = 1; 
         
      }else if(like != null && like.getLikeCheck() == 1){
         result = 2;
      }
      
      close(con);
   
      return result;
   }

   public ReviewBoard reviewDetail(int reviewNo) {
      Connection con = getConnection();
      ReviewBoard review = new ReviewBoardDao().reviewDetail(con, reviewNo);
      close(con);
      return review;
   }

   public ReviewBoard reviewUpdateView(int reviewNo) {
      Connection con = getConnection();
      ReviewBoard review = new ReviewBoardDao().reviewUpdateView(con, reviewNo);
      close(con);
      return review;
   }

   public int reviewUpdate(ReviewBoard review) {
      Connection con = getConnection();
      ReviewBoardDao rdao = new ReviewBoardDao();
      int result = rdao.reviewUpdate(con, review);
      if (result > 0) {
         if(rdao.reviewImageUpdate(con, review) > 0){
            commit(con);
         }else{
            rollback(con);
         }
         commit(con);
      }else {
         rollback(con);
      }
      return result;
   }

   public ArrayList<ReviewBoard> reviewLocationSearchList(int currentPage, int limit, String location,String searchKeyWord) {
      Connection con = getConnection();
      ArrayList<ReviewBoard> list = new ReviewBoardDao().reviewLocationSearchList(con, currentPage, limit,location,searchKeyWord);  
      close(con);
      return list;
   }

   public int getReviewListCount() {
      Connection con = getConnection();
      int result = new ReviewBoardDao().getReviewListCount(con);
      close(con);
      return result;
   }

   public int selectImageNo() {
      Connection con = getConnection();
      int result = new ReviewBoardDao().selectImageNo(con);
      close(con);
      return result;
   }

   public int insertReviewImage(ReviewBoardImage image) {
      Connection con = getConnection();
      int result = new ReviewBoardDao().insertReviewImage(con, image);

      if (result > 0) {
         commit(con);
      } else {
         rollback(con);
      }
      close(con);
      return result;
   }

   public int reviewHitUp(int reviewNo) {
      Connection con = getConnection();
      int result = new ReviewBoardDao().reviewHitUp(con, reviewNo);

      if (result > 0) {
         commit(con);
      } else {
         rollback(con);
      }
      return result;
   }
   
   public ArrayList<ReviewComment> selectCommentList(int reviewNo) {
      Connection con = getConnection();
      ArrayList<ReviewComment> list = new ReviewBoardDao().selectCommentList(con, reviewNo);
      close(con);
      return list;
   }
   
   public ArrayList<ReviewBoard> selectTop3Restaurant(){
      //식당 좋아요 탑3 뽑아오는 메서드
      Connection con = getConnection();
      ArrayList<ReviewBoard> list = new ReviewBoardDao().selectTop3Restaurant(con);
      close(con);
      return list;
   }
   
   public ArrayList<ReviewBoard> selectTop3Cafe(){
      Connection con = getConnection();
      ArrayList<ReviewBoard> list = new ReviewBoardDao().selectTop3Cafe(con);
      close(con);
      return list;
   }
   public ArrayList<ReviewBoard> selectTop3Hotel(){
      Connection con = getConnection();
      ArrayList<ReviewBoard> list = new ReviewBoardDao().selectTop3Hotel(con);
      close(con);
      return list;
   }
   public ArrayList<ReviewBoard> selectTop3Trans(){
      Connection con = getConnection();
      ArrayList<ReviewBoard> list = new ReviewBoardDao().selectTop3Trans(con);
      close(con);
      return list;
   }
   
   public int getReviewLocationListCount(String location,String searchKeyWord) {
         Connection con = getConnection();
         int count = new ReviewBoardDao().getReviewLocationListCount(con,location,searchKeyWord);
         close(con);
         return count;
      }

      public int getReviewCategoryListCount(String category, String searchKeyWord) {
         Connection con = getConnection();
         int count = new ReviewBoardDao().getReviewCategoryListCount(con,category,searchKeyWord);
         close(con);
         return count;
      }

      public int getReviewAllListCount(String category, String location, String searchKeyWord) {
         Connection con = getConnection();
         int count = new ReviewBoardDao().getReviewAllListCount(con,category,location,searchKeyWord); 
         close(con);
         return count;
      }

   public ArrayList<ReviewBoard> reviewCategorySearchList(int currentPage, int limit, String category, String searchKeyWord) {
      Connection con = getConnection();
      ArrayList<ReviewBoard> list = null; 
      list = new ReviewBoardDao().reviewCategorySearchList(con, currentPage, limit,category,searchKeyWord);  
      close(con);
      return list;
   }

   public ArrayList<ReviewBoard> reviewAllSearchList(int currentPage, int limit, String location, String category,
         String searchKeyWord) {
      Connection con = getConnection();
      ArrayList<ReviewBoard> list = null; 
      list = new ReviewBoardDao().reviewAllSearchList(con, currentPage, limit,location,category,searchKeyWord);  
      close(con);
      return list;
   }
   
}