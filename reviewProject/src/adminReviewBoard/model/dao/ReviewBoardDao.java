package adminReviewBoard.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import memberReviewBoard.model.vo.ReviewBoard;
import memberReviewBoard.model.vo.ReviewLike;
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
			
		return list;
	}

	public int forceDeleteReviewBoard(Connection con, int postNo) {
		// 관리자가 리뷰게시판 게시물 삭제하기 위한 메서드
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "delete from review_board where posting_no=?";
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1,postNo);
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		return result;
	}

	public int updateReadCount(Connection con, int postNo) {
		// 조회수 처리 증가
		int result = 0;
		PreparedStatement pstmt = null;
		String query ="update review_board set hits=hits+1 where posting_no = ?";
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, postNo);
			
			result = pstmt.executeUpdate();			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}		
		return result;
	}

	public ReviewBoard getReviewBoard(Connection con, int postNo) {
		// 리뷰게시판 가져오는 메서드
		ReviewBoard board = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select posting_no,id,title,content,hits,posting_date,del_yn,location,category,address,store_name,likes,evaluation,rename_image_name from review_board "
				+"join image using(posting_no) where posting_no = ?";
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, postNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				board = new ReviewBoard();
				board.setPosting_no(postNo); 
				board.setId(rset.getString("id"));
				board.setTitle(rset.getString("title"));
				board.setContent(rset.getString("content"));
				board.setHits(rset.getInt("hits"));
				board.setPostingDate(rset.getDate("posting_date"));
				board.setDelYN(rset.getInt("del_yn"));
				board.setLocation(rset.getString("location"));
				board.setCategory(rset.getString("category"));
				board.setAddress(rset.getString("address"));
				board.setStoreName(rset.getString("store_name"));
				board.setLikes(rset.getInt("likes"));
				board.setRenameImageName(rset.getString("rename_image_name"));
				board.setEvaluation(rset.getInt("evaluation"));  
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return board;
	}

	public int addLikeCount(Connection con, int postNo) {
		// 게시물의 좋아요 수 증가.
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "update review_board set likes=likes+1 where posting_no=?";
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, postNo);
			
			result = pstmt.executeUpdate();
						
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public int likeCheck(Connection con, String id, int postNo) {
		// likes 테이블 like_yn =1, id,postNo 인설트
		PreparedStatement pstmt = null;
		String query = "insert into likes values (?,?,?)";
		int result = 0;
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setInt(2, postNo);
			pstmt.setInt(3, 1);
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public ArrayList<ReviewLike> getAllLikesList(Connection con) {
		// Likes 리스트
		Statement stmt = null;
		ResultSet rset = null;
		ArrayList<ReviewLike> likesList= null;
		
		String query = "select * from likes";
		
		try{
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			likesList = new ArrayList<ReviewLike>();
			
			if(rset!=null){
				while(rset.next()){
					ReviewLike like = new ReviewLike();
					like.setId(rset.getString("id"));
					like.setReviewNo(rset.getInt("posting_no"));
					like.setLikeCheck(rset.getInt("like_yn"));
					
					likesList.add(like);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(stmt);
		}
		
		return likesList;
	}


	public int checkLikesInsert(Connection con, String id, int postNo) {
		// likes 테이블에 insert 되 있는지 (좋아요 눌렀는지) 확인하는 메서드
		Statement stmt = null;
		ArrayList<ReviewLike> likeList = null;
		String query = "select * from likes";
		ResultSet rset = null;
		int result = 0;
		System.out.println("Id :  " + id);
		System.out.println("postNo : " + postNo);
		try{
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			likeList = getAllLikesList(con);
			
			if(rset!=null){
				while(rset.next()){
					ReviewLike like = new ReviewLike();
					like.setId(rset.getString("id"));
					like.setReviewNo(rset.getInt("posting_no"));
					like.setLikeCheck(rset.getInt("like_yn"));
					
					likeList.add(like);
				}
			}			
			
			for(ReviewLike like : likeList){
				if(like.getId().equals(id) && (like.getReviewNo()==postNo)){
					result = 1;
					break;
				}else{
					result = 0;
				}
			}
			
			
			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(stmt);
		}
		
		return result;
	}


}
