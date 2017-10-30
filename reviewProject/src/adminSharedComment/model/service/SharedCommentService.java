package adminSharedComment.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import adminComplainComment.model.dao.ComplainCommentDao;
import adminSharedComment.model.dao.SharedCommentDao;
import memberComplainComment.model.vo.ComplainComment;
import memberReviewComment.model.dao.ReviewCommentDao;
import memberReviewComment.model.vo.ReviewComment;
import memberSharedComment.model.vo.SharedComment;

public class SharedCommentService {

	public ArrayList<SharedComment> viewSharedComment(int postNum) {
		// 댓글 불러오는 메서드
		Connection con = getConnection();
		ArrayList<SharedComment> list = new SharedCommentDao().viewSharedComment(con,postNum);
		close(con);
				
		return list;
	}

	public void insertComment(int postNum, String id, String content) {
		// 댓글 입력
		Connection con = getConnection();
		int result = new SharedCommentDao().insertComment(con,postNum,id,content);
		
		if(result>0){
			commit(con);
		}else{
			rollback(con);
		}
		
		close(con);
	}

	public void deleteComment(int postNum, int commentNum, String id) {
		// 댓글 삭제 메서드
		Connection con = getConnection();
		int result = new SharedCommentDao().deleteComment(con,postNum,commentNum,id);
		
		if(result>0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		
	}

	public void updateComment(int postNum, int commentNum, String id, String content) {
		// 댓글 수정 메서드
		Connection con = getConnection();
		int result = new SharedCommentDao().updateComment(con,postNum,commentNum,id,content);
		
		if(result>0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		
	}

	
}
