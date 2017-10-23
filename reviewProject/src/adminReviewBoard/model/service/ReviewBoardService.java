package adminReviewBoard.model.service;

import static common.JDBCTemplate.*;

import java.sql.*;
import java.util.ArrayList;

import adminReviewBoard.model.dao.ReviewBoardDao;
import memberReviewBoard.model.vo.ReviewBoard;
public class ReviewBoardService {

	public int getReviewListCount() {
		// 리뷰 게시판 게시글 갯수 알기 위한 메서드
		Connection con = getConnection();
		int result = new ReviewBoardDao().getReviewListCount(con);
		close(con);
		return result;
	}

	public ArrayList<ReviewBoard> viewAllReviewBoard(int currentPage, int limit) {
		// 리뷰 게시판에 게시물 보여주기 위한 메서드
		Connection con = getConnection();
		ArrayList<ReviewBoard> list = new ReviewBoardDao().viewAllReviewBoard(con,currentPage,limit);
		close(con);
		return list;
	}

}
