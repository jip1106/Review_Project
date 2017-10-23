package memberComplainBoard.model.service;

import java.sql.*;
import java.util.ArrayList;

import com.sun.corba.se.impl.ior.GenericTaggedComponent;

import memberComplainBoard.model.dao.ComplainBoardDao;
import memberComplainBoard.model.vo.ComplainBoard;
import static common.JDBCTemplate.*;

public class ComplainBoardService {

	public ComplainBoardService() {
	}

	public int getListCount() {
		Connection con = getConnection();
		int listCount = new ComplainBoardDao().getListCount(con);
		close(con);
		return listCount;
	}

	// 게시글 조회
	public ArrayList<ComplainBoard> selectList(int Page, int limit) {
		Connection con = getConnection();
		ArrayList<ComplainBoard> list = new ComplainBoardDao().selectList(con, Page, limit);
		close(con);
		return list;
	}

	public void addReadCount(int postingNo) {
		// 조회수 증가 처리 위한 메서드
		Connection con = getConnection();
		int result = new ComplainBoardDao().addReadCount(con, postingNo); // 업데이트
		if (result > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		return;
	}

	public ComplainBoard selectBoard(int bnum) {
		Connection con = getConnection();
		ComplainBoard ComplainBoard = new ComplainBoardDao().selectBoard(con, bnum);
		close(con);
		return ComplainBoard;
	}

	public int deleteBoard(int bnum) {
		Connection con = getConnection();
		int result = new ComplainBoardDao().deleteBoard(con, bnum);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public int insertBoard(ComplainBoard ComplainBoard) {
		Connection con = getConnection();
		int result = new ComplainBoardDao().insertBoard(con, ComplainBoard);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public int ComplainBoardUpdate(ComplainBoard complainBoard) {
		Connection con = getConnection();
		int result = new ComplainBoardDao().updateComplainBoard(con, complainBoard);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		
		return result;
	}

	



	public ArrayList<ComplainBoard> searchList(int Page, int limit, String searchValue, String searchKeyWord) {
		Connection con = getConnection();
		ArrayList<ComplainBoard> list = new ComplainBoardDao().selectSearch(con,Page,limit,searchValue,searchKeyWord);
		close(con);
		return list;
	}

	public int getSearchCount(String searchValue, String searchKeyWord) {
		Connection con = getConnection();
		int SearchCount = new ComplainBoardDao().getSearchCount(con,searchValue,searchKeyWord);
		close(con);
		return SearchCount;
	}

}
