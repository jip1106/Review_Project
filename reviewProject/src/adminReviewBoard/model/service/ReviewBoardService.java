package adminReviewBoard.model.service;

import static common.JDBCTemplate.*;

import java.sql.*;
import java.util.ArrayList;

import adminReviewBoard.model.dao.ReviewBoardDao;
import memberReviewBoard.model.vo.ReviewBoard;
import memberReviewBoard.model.vo.ReviewLike;
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

	public int forceDeleteReviewBoard(int postNo) {
		// 리뷰게시판 게시물 삭제 메서드
		Connection con = getConnection();
		int result = new ReviewBoardDao().forceDeleteReviewBoard(con,postNo);
		
		if(result>0){
			commit(con);
		}else{
			rollback(con);
		}
		
		close(con);
				
		return result;
	}

	public void addReadCount(int postNo) {
		// 조회수 증가 처리
		Connection con = getConnection();
		int result = new ReviewBoardDao().updateReadCount(con,postNo);
		
		if(result>0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		
	}

	public ReviewBoard getReviewBoard(int postNo) {
		// 게시글 번호로 리뷰 게시판 게시글 가져오는 메서드
		Connection con = getConnection();
		ReviewBoard board = new ReviewBoardDao().getReviewBoard(con,postNo);
		close(con);
		
		return board;
	}

	public void addLikeCount(int postNo) {
		// 게시물의 좋아요 수 증가
		Connection con = getConnection();
		int result = new ReviewBoardDao().addLikeCount(con,postNo);
		
		if(result>0){
			commit(con);
		}else{
			rollback(con);
		}
		
	}

	public int likeCheck(String id, int postNo) {
		// likes 테이블 like_yn 1로 올리고, 아이디, 게시물 likes 테이블에 넣음
		Connection con = getConnection();
		int result = new ReviewBoardDao().likeCheck(con,id,postNo);
		
		if(result>0){
			commit(con);
		}else{
			rollback(con);
		}
		return result;
	}

	public int checkLikesInsert(String id, int postNo) {
		// 좋아요 누른 아이디랑 게시물 체크하는 메서드
		Connection con = getConnection();
		int result = new ReviewBoardDao().checkLikesInsert(con,id,postNo);
		close(con);
		
		return result;
	}
	
	public ArrayList<ReviewLike> getAllLikesList(){
		Connection con = getConnection();
		ArrayList<ReviewLike> list = new ReviewBoardDao().getAllLikesList(con);
		close(con);
		return list;
	}

}
