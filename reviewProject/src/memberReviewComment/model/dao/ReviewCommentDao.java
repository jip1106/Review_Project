package memberReviewComment.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import memberReviewComment.model.vo.ReviewComment;

public class ReviewCommentDao {

	public int insertReviewComment(Connection con, int reviewNo, String id, String content) {
		PreparedStatement pstmt = null;
		String query="insert into review_comment values(review_comment_seq.nextval,?,?,?,default)";
		int result = 0;
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, reviewNo);
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

	public ArrayList<ReviewComment> selectReviewComment(Connection con, int reviewNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<ReviewComment> list = new ArrayList<ReviewComment>();
		ReviewComment comment = null;
		String query = "select * from review_comment where posting_no = ? order by comment_no desc";
		
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

	public int deleteReviewComment(Connection con, int commentNo, int reviewNo) {
		PreparedStatement pstmt = null;
		String query = "delete from review_comment where comment_no = ? and posting_no = ?";
		int result = 0;
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, commentNo);
			pstmt.setInt(2, reviewNo);
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public int updateReviewComment(Connection con, int commentNo, int reviewNo, String content) {
		PreparedStatement pstmt = null;
		String query = "update review_comment set comment_content = ? where comment_no = ? and posting_no = ?";
		int result = 0;
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, content);
			pstmt.setInt(2, commentNo);
			pstmt.setInt(3, reviewNo); 
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		return result;
	}

}
