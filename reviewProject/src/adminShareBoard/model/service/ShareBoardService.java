package adminShareBoard.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import adminShareBoard.model.dao.ShareBoardDao;
import memberSharedBoard.model.vo.SharedBoard;

public class ShareBoardService {

	// 정보공유 게시판 글목록 (전체보기)
	public ArrayList<SharedBoard> selectList(int currentPage, int limit) {
		Connection con = getConnection();
		ArrayList<SharedBoard> list = new ShareBoardDao().selectList(con, currentPage, limit);
		close(con);
		return list;
	}

	// 정보공유 게시판 글 조회수 증가
	public void hitsUp(int no) {
		Connection con = getConnection();
		int result = new ShareBoardDao().hitsUp(con, no);
		if (result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
	}

	// 정보공유 게시판 글 상세보기
	public SharedBoard detailSharedBoard(int no) {
		Connection con = getConnection();
		SharedBoard sb = new ShareBoardDao().detailSharedBoard(con, no);
		close(con);
		return sb;
	}

	// 정보공유 게시판 전체 글 개수 세기
	public int getShareBoardListCount() {
		Connection con = getConnection();
		int shareBoardListCount = new ShareBoardDao().getShareBoardListCount(con);
		close(con);
		return shareBoardListCount;
	}

	//정보공유 게시판 작성자(id)로 검색하기
	public ArrayList<SharedBoard> shareBoardSearchId(String id, int currentPage, int limit) {
		Connection con = getConnection();
		ArrayList<SharedBoard> shareBoardList = new ShareBoardDao().shareBoardSearchId(con, id, currentPage, limit);
		close(con);
		return shareBoardList;
	}
	
	//정보공유 게시판 제목(title)로 검색하기
	public ArrayList<SharedBoard> shareBoardSearchTitle(String title, int currentPage, int limit) {
		Connection con = getConnection();
		ArrayList<SharedBoard> shareBoardList = new ShareBoardDao().shareBoardSearchTitle(con,  title, currentPage, limit);
		close(con);
		return shareBoardList;
	}
	
	// 정보공유 게시판 게시글 삭제하기
	public int deleteShareBoard(int postingNum) {
		Connection con = getConnection();
		int result = new ShareBoardDao().deleteShareBoard(con,postingNum);
		
		if(result>0){
			commit(con);
		}else{
			rollback(con);
		}
		return result;
	}
	
	//정보공유게시판 검색된 글 수 세기
	public int getSearchCount(String selectSearch, String inputValue) {
		Connection con = getConnection();
		int listCount = new ShareBoardDao().getSearchCount(con,inputValue,selectSearch);
		close(con);
		return listCount;
	}

}
