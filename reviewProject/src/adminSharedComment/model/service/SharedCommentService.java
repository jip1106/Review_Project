package adminSharedComment.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import adminSharedComment.model.dao.SharedCommentDao;
import memberReviewComment.model.dao.ReviewCommentDao;
import memberReviewComment.model.vo.ReviewComment;
import memberSharedComment.model.vo.SharedComment;

public class SharedCommentService {

	public int insertSharedComment(int no, String id, String content) {
		Connection con = getConnection();
		int result = new SharedCommentDao().insertReviewComment(con,no,id,content);
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con); 
		return result;
	}

	public ArrayList<SharedComment> selectSharedComment(int no) {
		Connection con = getConnection();
		ArrayList<SharedComment> list = new SharedCommentDao().selectReviewComment(con,no);
		return list;
	}

	public int updateSharedComment(int commentNo, int shareNo, String content) {
		Connection con = getConnection();
		int result = new SharedCommentDao().updateSharedComment(con,commentNo,shareNo,content);
		
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		return result;
	}

	public int deleteSharedComment(int commentNo, int shareNo) {
		Connection con = getConnection();
		int result = new SharedCommentDao().deleteSharedComment(con,commentNo,shareNo);
		
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		return result;
	}
}
