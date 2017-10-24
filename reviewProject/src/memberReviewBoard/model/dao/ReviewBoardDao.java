package memberReviewBoard.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import memberReviewBoard.model.vo.ReviewBoard;
import memberReviewBoard.model.vo.ReviewBoardImage;
import memberReviewBoard.model.vo.ReviewLike;
import memberReviewComment.model.vo.ReviewComment;

public class ReviewBoardDao {

	public int insertReview(Connection con, ReviewBoard review) {  
		PreparedStatement pstmt = null;
		String query = "insert into review_board values(review_seq.nextval,?,?,?,default,default,default,?,?,?,?,default,?,?,?)";
		int result = 0; 
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, review.getId());
			pstmt.setString(2, review.getTitle());
			pstmt.setString(3, review.getContent());
			pstmt.setString(4, review.getLocation());
			pstmt.setString(5, review.getCategory());
			pstmt.setString(6, review.getAddress());
			pstmt.setString(7, review.getStoreName());
			pstmt.setString(8, review.getImageName());
			pstmt.setString(9, review.getRenameImageName());
			pstmt.setInt(10, review.getEvaluation()); 
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			
			close(pstmt);
		}
		
		return result;
	}

	public ArrayList<ReviewBoard> selectReview(Connection con, int currentPage, int limit) {
		PreparedStatement pstmt = null; 
		ResultSet rset = null;
	    String query = 
	              "select * from "
	              + "(select rownum as rnum,posting_no,id,title,content,hits,posting_date,del_yn,location,category,address,store_name,likes,image_name,re_image_name,evaluation "
	              + "from (select * from review_board order by posting_no desc)) "
	              + "where rnum>=? and rnum<=?"; 
		ReviewBoard review = null;
		ArrayList<ReviewBoard> list = new ArrayList<ReviewBoard>();
		int startRow = (currentPage -1) * limit + 1;
		int endRow = startRow + limit - 1;
		
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

	public int reviewDelete(Connection con, int reviewNo) {
		PreparedStatement pstmt = null;
		String query = "delete from review_board where posting_no = ?";
		int result = 0;
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, reviewNo);
			
			result = pstmt.executeUpdate(); 
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		return result; 
	}

	public int reviewLikeUp(Connection con,int reviewNo) {
		PreparedStatement pstmt = null;
		String query = "update review_board set likes=likes+1 where posting_no = ?";
		int result = 0;
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, reviewNo); 
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		System.out.println(result);
		return result;
	}

	public ReviewLike checkLike(Connection con, int reviewNo, String writer) { 
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ReviewLike like = null;
		String query = "select m.id,r.posting_no,l.like_yn from likes l,review_board r,member m where l.id = m.id and r.posting_no = l.posting_no and l.posting_no = ? and l.id = ?";
						 
		try{
			pstmt = con.prepareStatement(query); 
			pstmt.setInt(1, reviewNo);
			pstmt.setString(2, writer);
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				like = new ReviewLike();
				like.setId(rset.getString(1));
				like.setReviewNo(rset.getInt(2));
				like.setLikeCheck(rset.getInt(3));
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return like;
	}

	public int likeStateUp(Connection con, int reviewNo, String writer) { 
		PreparedStatement pstmt = null;
		String query = "update likes set like_yn = 1 where posting_no = ? and id = ?";
		
		int result = 0;
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, reviewNo);
			pstmt.setString(2, writer);
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		System.out.println(result);		
		return result; 
	}

	public ReviewBoard reviewDetail(Connection con,int reviewNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ReviewBoard review = null;
		String query = "select posting_no,id,title,content,hits,posting_date,del_yn,location,category,address,store_name,likes,evaluation,rename_image_name from review_board "
				+"join image using(posting_no) where posting_no = ?";
					  
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, reviewNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
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
				review.setRenameImageName(rset.getString("rename_image_name"));
				review.setEvaluation(rset.getInt("evaluation"));  
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return review;
	}

	public ReviewBoard reviewUpdateView(Connection con, int reviewNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select posting_no,id,title,content,hits,posting_date,del_yn,location,category,address,store_name,likes,image_name,evaluation,original_image_name,rename_image_name from review_board "
				+"join image using(posting_no) where posting_no = ?";
		ReviewBoard review = null;
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, reviewNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
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
				review.setImageName(rset.getString("original_image_name"));
				review.setEvaluation(rset.getInt("evaluation"));
				review.setRenameImageName(rset.getString("rename_image_name"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return review;
	}

	public int reviewUpdate(Connection con, ReviewBoard review) {
		PreparedStatement pstmt = null;
		String query = "update review_board set title = ?,content = ?,location = ?,category = ?,address = ?,store_name = ?,image_name = ?,re_image_name = ?,evaluation = ? where posting_no = ?";
		int result = 0;
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, review.getTitle());
			pstmt.setString(2, review.getContent());
			pstmt.setString(3, review.getLocation());
			pstmt.setString(4, review.getCategory());
			pstmt.setString(5, review.getAddress());
			pstmt.setString(6, review.getStoreName());
			pstmt.setString(7, review.getImageName());
			pstmt.setString(8, review.getRenameImageName());
			pstmt.setInt(9, review.getEvaluation());
			pstmt.setInt(10, review.getPosting_no());
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		return result;
	}

	public ArrayList<ReviewBoard> reviewLocationSearchList(Connection con, int currentPage, int limit,String location,String searchKeyWord) {
		System.out.println("지역검색");
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query =  
					"select * from "
	              + "(select rownum as rnum,posting_no,id,title,content,hits,posting_date,del_yn,location,category,address,store_name,likes,image_name,re_image_name,evaluation "
	              + "from (select * from review_board order by posting_no desc)) "
	              + "where rnum>=? and rnum<=? and location = ? and store_name like ?";  
		ArrayList<ReviewBoard> list = new ArrayList<ReviewBoard>();
		ReviewBoard review = null;
		int startRow = (currentPage -1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			pstmt.setString(3, location);
			pstmt.setString(4, "%"+searchKeyWord+"%");
			
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

	public ArrayList<ReviewBoard> reviewCategorySearchList(Connection con,int currentPage, int limit,String category,String searchKeyWord) {
		System.out.println("카테고리검색");
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query =  
					"select * from "
	              + "(select rownum as rnum,posting_no,id,title,content,hits,posting_date,del_yn,location,category,address,store_name,likes,image_name,re_image_name,evaluation "
	              + "from (select * from review_board order by posting_no desc)) "
	              + "where rnum>=? and rnum<=? and category = ? and store_name like ?"; 
		ArrayList<ReviewBoard> list = new ArrayList<ReviewBoard>();
		ReviewBoard review = null;
		int startRow = (currentPage -1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			pstmt.setString(3, category);
			pstmt.setString(4, "%"+searchKeyWord+"%");
			
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

	public int getReviewListCount(Connection con) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select count(*) from review_board";
		int result = 0;
		
		try{
			pstmt = con.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				result = rset.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return result;
	}

	public int selectImageNo(Connection con) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int result = 0;
		String query = "select max(posting_no) from review_board";
		
		try{
			pstmt = con.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				result = rset.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return result;
	}

	public int insertReviewImage(Connection con, ReviewBoardImage image) {
		PreparedStatement pstmt = null;
		String query = "insert into image values(review_image_seq.nextval,?,?,?)";
		int result = 0;
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, image.getReviewBoardNO()); 
			pstmt.setString(2, image.getOriginalFileName());
			pstmt.setString(3, image.getReFileName());  
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		return result;
	}

	public int reviewHitUp(Connection con, int reviewNo) { 
		PreparedStatement pstmt = null;
		String query ="update review_board set hits=hits+1 where posting_no = ?";
		int result = 0;
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, reviewNo);
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}

/*	public int reviewImageDelete(Connection con, int reviewNo) {
		PreparedStatement pstmt = null;
		String query = "delete from image where posting_no = ?";
		int result = 0;
		System.out.println(reviewNo);
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, reviewNo);
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		return result;
	}*/

	public int reviewImageUpdate(Connection con, ReviewBoard review) {
		PreparedStatement pstmt = null;
		String query = "update image set original_image_name = ?,rename_image_name = ? where posting_no = ?";
		int result = 0;
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, review.getImageName());
			pstmt.setString(2, review.getRenameImageName());
			pstmt.setInt(3, review.getPosting_no());
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		
		return result;
		
	}

	public int insertLike(Connection con,int reviewNo,String writer) {
		PreparedStatement pstmt = null;
		String query = "insert into likes values(?,?,default)"; 
		int result = 0;
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, writer);
			pstmt.setInt(2, reviewNo);
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		System.out.println(result);
		return result;
	}

/*	public int likeDelete(Connection con, int reviewNo) {
		PreparedStatement pstmt = null;
		String query = "delete from likes where posting_no = ?";
		int result = 0;
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, reviewNo);
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		return result;
	}*/

	public int selectLike(Connection con) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select count(*) from likes";
		int result = 0;
		
		try{
			pstmt = con.prepareStatement(query);
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				result = rset.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return result;
	}

	public ArrayList<ReviewBoard> reviewAllSearchList(Connection con, int currentPage, int limit, String location,
			String category, String searchKeyWord) {
		
		System.out.println("전체검색");
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query =  
					"select * from "
	              + "(select rownum as rnum,posting_no,id,title,content,hits,posting_date,del_yn,location,category,address,store_name,likes,image_name,re_image_name,evaluation "
	              + "from (select * from review_board order by posting_no desc)) "
	              + "where rnum>=? and rnum<=? and location = ? and category = ? and store_name like ?"; 
		ArrayList<ReviewBoard> list = new ArrayList<ReviewBoard>();
		ReviewBoard review = null;
		int startRow = (currentPage -1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			pstmt.setString(3, location);
			pstmt.setString(4, category);
			pstmt.setString(5, "%"+searchKeyWord+"%");
			
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

	public ArrayList<ReviewComment> selectCommentList(Connection con, int reviewNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select * from review_comment where posting_no = ? order by comment_no desc";
		ArrayList<ReviewComment> list = new ArrayList<ReviewComment>();
		ReviewComment comment = null;
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, reviewNo);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				comment = new ReviewComment();
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

}
