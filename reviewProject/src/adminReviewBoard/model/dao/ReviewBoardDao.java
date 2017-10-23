package adminReviewBoard.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import memberReviewBoard.model.vo.ReviewBoard;

import static common.JDBCTemplate.*;
public class ReviewBoardDao {

	public int getReviewListCount(Connection con) {
		// 리뷰게시판 갯수 알기 위한 메서드
		int result = 0;
		
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from review_board ";
		
		try{
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()){
				result = rset.getInt(1);
			}
			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(stmt);
		}	
				
		return result;
	}

	public ArrayList<ReviewBoard> viewAllReviewBoard(Connection con, int currentPage, int limit) {
		// 리뷰 게시판 게시글 보여주기 위한 메서드
		ArrayList<ReviewBoard> list = new ArrayList<ReviewBoard>();
		ReviewBoard review = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query =  "select * from "
	              + "(select rownum as rnum,posting_no,id,title,content,hits,posting_date,del_yn,location,category,address,store_name,likes,image_name,re_image_name,evaluation "
	              + "from (select * from review_board order by posting_no desc)) "
	              + "where rnum>=? and rnum<=?"; 
		
		int startRow = (currentPage -1 )*limit+1;
		int endRow = startRow + limit -1;
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				review = new ReviewBoard();
				review.setPosting_no(rset.getInt("posting_no")); 
				review.setId(rset.getString("id"));
				review.setTitle(rset.getString("title"));
				review.setContent(rset.getString("content"));
				review.setHits(rset.getInt("hits"));
				review.setPostingDate(rset.getDate("posting_date"));
				review.setDelYN(rset.getInt("del_yn"));
				review.setLocation(rset.getString("location"));
				review.setCategory(rset.getString("category"));
				review.setAddress(rset.getString("address"));
				review.setStoreName(rset.getString("store_name"));
				review.setLikes(rset.getInt("likes"));
				review.setImageName(rset.getString("image_name"));
				review.setRenameImageName(rset.getString("re_image_name"));
				review.setEvaluation(rset.getInt("evaluation"));  
				list.add(review);
			
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		System.out.println("admin Dao ");
		
		return list;
	}

}
