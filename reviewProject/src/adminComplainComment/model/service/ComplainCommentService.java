package adminComplainComment.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.util.ArrayList;

import adminComplainComment.model.dao.ComplainCommentDao;
import memberComplainComment.model.vo.ComplainComment;

public class ComplainCommentService {

	public ArrayList<ComplainComment> viewComplainComment(int postNum) {
		// 댓글 불러오는 메서드
		Connection con = getConnection();
		ArrayList<ComplainComment> list = new ComplainCommentDao().viewComplainComment(con,postNum);
		close(con);
		
		return list;
	}

	
}
