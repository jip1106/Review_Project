package adminComplainBoard.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import adminComplainBoard.model.dao.ComplainBoardDao;
import memberComplainBoard.model.vo.ComplainBoard;

public class ComplainBoardService {
	public ComplainBoardService(){}
	

	public int getComplainBoardListCount() {
		// 신고게시판 게시글 갯수 조회를 위한 메서드
		Connection con = getConnection();
		int listCount = new ComplainBoardDao().getComplainBoardListCount(con);		
		
		close(con);
		
		return listCount;
	}
	
	public int getSearchCount(String searchValue,String searchMenu) {
		// 관리자가 신고게시판 게시글을 제목으로 검색했을때 ,검색 결과 갯수 조회를 위한 메서드
		Connection con = getConnection();
		int listCount = new ComplainBoardDao().getSearchCount(con,searchValue,searchMenu);
		
		close(con);
		return listCount;
	}

	public ArrayList<ComplainBoard> viewComplainBoardList(int currentPage, int limit) {
		// 한 페이지에 보여주는 게시글 리스트
		Connection con = getConnection();
		ArrayList<ComplainBoard> list = new ComplainBoardDao().viewComplainBoardList(con,currentPage,limit);
		close(con);
		
		return list;
	}

	public int deleteComplainBoard(int postingNum) {
		//관리자가 신고 게시글 중 허위 신고 게시글 삭제하기 위한 메서드
		Connection con = getConnection();
		int result = new ComplainBoardDao().deleteComplainBoard(con,postingNum);
		
		if(result>0){
			commit(con);
		}else{
			rollback(con);
		}
		return result;
	}

	public void addReadCount(int postNo) {
		//조회수 증가 처리 위한 메서드
		Connection con = getConnection();
		int result = new ComplainBoardDao().addReadCount(con,postNo);	//업데이트
		
		if(result>0){
			commit(con);
		}else{
			rollback(con);
		}
		
		return;
	}
	
	public ComplainBoard viewComplainBoardDetail(int postNo) {
		// 신고게시판 게시글 제목 눌렀을 때 상세보기 내용 보기 위한 메서드
		Connection con = getConnection();
		ComplainBoard board = new ComplainBoardDao().viewComplainBoardDetail(con, postNo);
		close(con);
		
		
		return board;
	}

	public ArrayList<ComplainBoard> viewSearchById(String id,int currentPage, int limit) {
		//id로 검색한 신고 게시판 내용
		Connection con = getConnection();
		ArrayList<ComplainBoard> boardList = new ComplainBoardDao().viewSearchById(con,id,currentPage,limit);
		System.out.println("Service단 id 값 : " + id);
		close(con);
		
		return boardList;
	}

	public ArrayList<ComplainBoard> viewSearchByTitle(String title,int currentPage, int limit) {
		// 제목으로 검색한 신고 게시판 내용 보여주기
		Connection con = getConnection();
		ArrayList<ComplainBoard> boardList = new ComplainBoardDao().viewSearchByTitle(con,title,currentPage,limit);
		
		close(con);
		return boardList;
	}

	

	
	
	
}










