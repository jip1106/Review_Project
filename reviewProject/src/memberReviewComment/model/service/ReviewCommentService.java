package memberReviewComment.model.service;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import memberReviewComment.model.dao.ReviewCommentDao;
import memberReviewComment.model.vo.ReviewComment;

public class ReviewCommentService {

	public int insertReviewComment(int reviewNo, String id, String content) {
		Connection con = getConnection();
		int result = new ReviewCommentDao().insertReviewComment(con,reviewNo,id,content);
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con); 
		return result;
	}

	public ArrayList<ReviewComment> selectReviewComment(int reviewNo) {
		Connection con = getConnection();
		ArrayList<ReviewComment> list = new ReviewCommentDao().selectReviewComment(con,reviewNo);
		return list;
	}

	public int deleteReviewComment(int commentNo, int reviewNo) {
		Connection con = getConnection();
		int result = new ReviewCommentDao().deleteReviewComment(con,commentNo,reviewNo);
		
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		return result;
	}

	public int updateReviewComment(int commentNo, int reviewNo, String content) {
		Connection con = getConnection();
		int result = new ReviewCommentDao().updateReviewComment(con,commentNo,reviewNo,content);
		
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		return result;
	}

	public ArrayList<ReviewComment> viewReviewComment(int postNum) {
		// 리뷰게시판 댓글 불러오는 메서드
				Connection con = getConnection();
				ArrayList<ReviewComment> list = new ReviewCommentDao().viewReviewComment(con,postNum);
				close(con);
				
				return list;
	}

	public void updateComment(int postNum, int commentNum, String id, String content) {
		Connection con = getConnection();
		int result = new ReviewCommentDao().updateComment(con,postNum,commentNum,id,content);
		
		if(result>0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		
	}

	public void insertComment(int postNum, String id, String content) {
		// 리뷰게시판 댓글 입력 메서드
				Connection con = getConnection();
				int result = new ReviewCommentDao().insertComment(con,postNum,id,content);
				
				if(result>0){
					commit(con);
				}else{
					rollback(con);
				}
				
				close(con);
	}

	public void deleteComment(int postNum, int commentNum, String id) {
		// 댓글 삭제
				Connection con = getConnection();
				int result = new ReviewCommentDao().deleteComment(con,postNum,commentNum,id);
				
				if(result>0){
					commit(con);
				}else{
					rollback(con);
				}
				close(con);
	}

}
