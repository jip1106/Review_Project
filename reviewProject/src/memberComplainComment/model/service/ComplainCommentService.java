package memberComplainComment.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import memberComplainComment.model.dao.ComplainCommentDao;
import memberComplainComment.model.vo.ComplainComment;
import java.sql.*;

import com.sun.corba.se.impl.ior.GenericTaggedComponent;

import static common.JDBCTemplate.*;

public class ComplainCommentService {

	public ComplainCommentService() {
	}

	public ArrayList<ComplainComment> viewComplainComment(int postNum) {
		// 댓글 불러오는 메서드
		Connection con = getConnection();
		ArrayList<ComplainComment> list = new ComplainCommentDao().viewComplainComment(con, postNum);
		close(con);

		return list;
	}

	public void deleteComment(int postNum, int commentNum, String id) {
		// 댓글 삭제
		Connection con = getConnection();
		int result = new ComplainCommentDao().deleteComment(con, postNum, commentNum, id);

		if (result > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		close(con);

	}

	public void insertComment(int postNum, String id, String content) {
		// 댓글 입력
		Connection con = getConnection();
		int result = new ComplainCommentDao().insertComment(con, postNum,id,content);
		
		if(result >0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		

	}

	public void updateComment(int postNum, int commentNum, String id, String content) {
		Connection con = getConnection();
		int result = new ComplainCommentDao().updateComment(con,postNum,commentNum,id,content);
		
		if(result>0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
	}

}