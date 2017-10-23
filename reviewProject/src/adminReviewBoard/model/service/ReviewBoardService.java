package adminReviewBoard.model.service;

import static common.JDBCTemplate.*;

import java.sql.*;

import adminReviewBoard.model.dao.ReviewBoardDao;
public class ReviewBoardService {

	public int getReviewListCount() {
		// 리뷰 게시판 게시글 갯수 알기 위한 메서드
		Connection con = getConnection();
		int result = new ReviewBoardDao().getReviewListCount(con);
		close(con);
		return result;
	}

}
