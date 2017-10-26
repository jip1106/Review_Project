package memberSharedComment.model.service;

import static common.JDBCTemplate.*;


import java.sql.Connection;
import java.util.ArrayList;

import memberSharedComment.model.dao.SharedCommentDao;
import memberSharedComment.model.vo.SharedComment;

public class SharedCommentService {

	public int sharedCommentInsert(int sharedNo, String id, String content) {
		Connection con = getConnection();
		int result = new SharedCommentDao().insertSharedComment(con,sharedNo,id,content);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public ArrayList<SharedComment> sharedCommentList(int no) {
		Connection con = getConnection();
		ArrayList<SharedComment> list = new SharedCommentDao().selectSharedComment(con,no);
		close(con);
		System.out.println("service:" + list);
		return list;
	}

	public int deleteSharedComment(int commentNo, int sharedNo) {
		Connection con = getConnection();
		int result = new SharedCommentDao().deleteSharedComment(con, commentNo, sharedNo);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public int updateSharedComment(int commentNo, int sharedNo, String content) {
		Connection con = getConnection();
		int result = new SharedCommentDao().updateSharedComment(con, commentNo, sharedNo, content);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}


}
