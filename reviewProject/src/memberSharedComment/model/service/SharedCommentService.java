package memberSharedComment.model.service;

import static common.JDBCTemplate.*;


import java.sql.Connection;
import java.util.ArrayList;

import adminComplainComment.model.dao.ComplainCommentDao;
import memberComplainComment.model.vo.ComplainComment;
import memberSharedComment.model.dao.SharedCommentDao;
import memberSharedComment.model.vo.SharedComment;

public class SharedCommentService {

	public ArrayList<SharedComment> commentListView(int postNum) {
		// 댓글 불러오는 메서드
		Connection con = getConnection();
		ArrayList<SharedComment> list = new SharedCommentDao().commentListView(con,postNum);
		close(con);
				
		return list;
	}

	public void insertComment(int postNum, String id, String content) {
		//댓글 등록
		Connection con = getConnection();
		int result = new SharedCommentDao().insertComment(con, postNum,id,content);
		
		if(result >0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		
	}

	public void deleteComment(int postNum, int commentNum, String id) {
		// 댓글 삭제
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
