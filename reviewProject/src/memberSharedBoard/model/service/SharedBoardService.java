package memberSharedBoard.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import memberSharedBoard.model.dao.SharedBoardDao;
import memberSharedBoard.model.vo.SharedBoard;
import memberSharedComment.model.vo.SharedComment;

public class SharedBoardService {

	public ArrayList<SharedBoard> selectList(int currentPage, int limit) {
		//정보공유 게시판 전체조회
		Connection con = getConnection();
		ArrayList<SharedBoard> list = new SharedBoardDao().selectList(con, currentPage, limit);
		close(con);
		return list;
	}
	
	public int getListCount() {
		//전체 게시글 갯수 조회용
		Connection con = getConnection();
		int listCount = new SharedBoardDao().getListCount(con);
		close(con);
		return listCount;
	}

	public SharedBoard selectSharedBoard(int no) {
		//정보공유 게시판 상세보기
		Connection con = getConnection();
		SharedBoard sharedBoard = new SharedBoardDao().selectOne(con, no);
		return sharedBoard;
	}
	
	public void addReadCount(int no){
		//정보공유 게시판 조회수 증가 메소드
		Connection con = getConnection();
		int result = new SharedBoardDao().updateReadCount(con, no);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
	}
	
	public int insertSharedBoard(SharedBoard sharedBoard){
		Connection con= getConnection();
		int result = new SharedBoardDao().insertSharedBoard(con, sharedBoard);
		if(result >0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}
	
	public int deleteSharedBoard(int no){
		Connection con = getConnection();
		int result = new SharedBoardDao().deleteSharedBoard(con, no);
		if(result >0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}
	
	public ArrayList<SharedBoard> titleSearch(int currentPage, int limit, String searchMenu, String keyword){
		//검색하기
		Connection con = getConnection();
		ArrayList<SharedBoard> list = new SharedBoardDao().titleSearch(con, currentPage, limit, searchMenu, keyword);
		close(con);
		System.out.println(list);
		return list;
	}

	public int updateSharedBoard(SharedBoard sb) {
		Connection con = getConnection();
		int result = new SharedBoardDao().updateSharedBoard(con, sb);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public int getSearchCount(String searchMenu, String keyword) {
		Connection con = getConnection();
		int searchCount = new SharedBoardDao().getSearchCount(con, searchMenu, keyword);
		close(con);
		return searchCount;
	}

	public ArrayList<SharedComment> selectCommentList(int no) {
		//댓글 목록
			Connection con = getConnection();
			ArrayList<SharedComment> list = new SharedBoardDao().selectCommentList(con,no);
			close(con);
			return list;
		}
	}


