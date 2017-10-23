package adminComplainBoard.model.dao;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import memberComplainBoard.model.vo.ComplainBoard;

public class ComplainBoardDao {
	public ComplainBoardDao(){}

	public int getComplainBoardListCount(Connection con) {
		//신고게시판 게시글 갯수 조회용 메서드
		Statement stmt = null;
		ResultSet rset = null;
		int result = 0;
	
		String query = "select count(*) from complain_board";
		
		try{
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next()){
				result = rset.getInt(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(stmt);
		}
		return result;
	}
	public int getSearchCount(Connection con, String searchValue,String searchMenu) {
		// 신고 게시판에서 검색했을 때, 검색 결과 갯수를 알기위한 메서드
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = null;
		int result = 0;
		
		//Statement stmt 로 해서 안됬었음... 왜 안되지 ㅅㅂ
		if(searchMenu.equals("findByTitle")){
			System.out.println("제목으로 검색");
			query = "select count(*) "
					+ "from complain_board "
					+ "where title like ? order by posting_no desc";
		
			try{
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, "%"+searchValue+"%");
				rset = pstmt.executeQuery();
				
				if(rset.next()){
					result = rset.getInt(1);
				}
				
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				close(rset);
				close(pstmt);
			}
		
		}
		
		if(searchMenu.equals("findByWriter")){
			query = "select count(*) from complain_board where id like ?";
		
			try{
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, "%"+searchValue+"%");
				rset = pstmt.executeQuery();
				
				if(rset.next()){
					result = rset.getInt(1);
				}
				
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				close(rset);
				close(pstmt);
			}
		
		}
		System.out.println("DAO딴 result 값 : " + result);
		
		return result;
	}
	
	public ArrayList<ComplainBoard> viewComplainBoardList(Connection con, int currentPage, int limit) {
		// 한 페이지에 보여주는 신고게시판 게시글 갯수
		ArrayList<ComplainBoard> boardlist = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//rownum 쿼리문 날릴때 앨리어스 할 것.. 안하면 1페이지 이후 값 안나옴
		String query = 
				"select * from "
				+ "(select rownum as rnum, posting_no,id,title,content,hits,posting_date,del_yn "
				+ "from (select * from complain_board order by posting_no desc)) "
				+ "where rnum>=? and rnum<=?";
		
		int startRow = (currentPage-1)*limit +1; //페이지에 보이는 맨 위의 글
		int endRow = startRow + limit-1;				// 맨 마지막 글
		
	
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			if(rset!=null){
				boardlist = new ArrayList<ComplainBoard>();
								
				while(rset.next()){
					ComplainBoard board = new ComplainBoard();
					
					board.setPostingNo(rset.getInt("posting_no"));
					board.setId(rset.getString("id"));
					board.setTitle(rset.getString("title"));
					board.setContent(rset.getString("content"));
					board.setHits(rset.getInt("hits"));
					board.setPostingDate(rset.getDate("posting_date"));
					board.setDelYN(rset.getInt("del_yn"));
													
					boardlist.add(board);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return boardlist;
	}

	public int deleteComplainBoard(Connection con, int postingNum) {
		//관리자가 신고게시판에 허위 신고 게시글 삭제하기 위한 메서드
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "delete from complain_board where posting_no = ?";
		
		try{
			pstmt=con.prepareStatement(query);
			pstmt.setInt(1, postingNum);
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public int addReadCount(Connection con, int postNo) {
		// 조회수 1 증가 처리 위한 메서드
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query ="update complain_board set hits= hits+1 where posting_no = ?";
		
		try{
			pstmt=con.prepareStatement(query);
			pstmt.setInt(1, postNo);
			
			result=pstmt.executeUpdate();
						
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}
	
	public ComplainBoard viewComplainBoardDetail(Connection con, int postNo) {
		// 신고 게시판 상세글 보기위한 메서드
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ComplainBoard board = null;
		
		String query ="select * from complain_board where posting_no = ?";
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, postNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				board = new ComplainBoard();
				
				board.setPostingNo(rset.getInt("posting_no"));
				board.setId(rset.getString("id"));
				board.setTitle(rset.getString("title"));
				board.setContent(rset.getString("content"));
				board.setHits(rset.getInt("hits"));
				board.setPostingDate(rset.getDate("posting_date"));
				board.setDelYN(rset.getInt("del_yn"));
			}
			
			
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return board;
	}

	public ArrayList<ComplainBoard> viewSearchById(Connection con,String id, int currentPage, int limit) {
		// 아이디로 찾은 게시물을 5개씩 보여주는 메서드
		ArrayList<ComplainBoard> boardlist = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		int startRow = (currentPage-1)*limit +1; //페이지에 보이는 맨 위의 글
		int endRow = startRow + limit-1;				// 맨 마지막 글
		
		String query = "select * from "
				+ "(select rownum as rnum, posting_no, id,title,content,hits,posting_date,del_yn "
				+ "from (select * from complain_board where id like ? order by posting_no desc)) "
				+ "where rnum>=? and rnum<=?";
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%"+id+"%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			//System.out.println("Dao 단 id 값" + id);
			
			rset = pstmt.executeQuery();
			
			if(rset!=null){
				
				boardlist = new ArrayList<ComplainBoard>();
								
				while(rset.next()){
					ComplainBoard board = new ComplainBoard();
					
					board.setPostingNo(rset.getInt("posting_no"));
					board.setId(rset.getString("id"));
					board.setTitle(rset.getString("title"));
					board.setContent(rset.getString("content"));
					board.setHits(rset.getInt("hits"));
					board.setPostingDate(rset.getDate("posting_date"));
					board.setDelYN(rset.getInt("del_yn"));
				
					boardlist.add(board);
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		//System.out.println("Dao단 id으로 찾은 게시물들 : " + boardlist);
		
		return boardlist;
	}

	public ArrayList<ComplainBoard> viewSearchByTitle(Connection con,String title, int currentPage, int limit) {
		// 제목으로 찾은 게시물
		ArrayList<ComplainBoard> boardlist = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		int startRow = (currentPage-1)*limit +1; //페이지에 보이는 맨 위의 글
		int endRow = startRow + limit-1;				// 맨 마지막 글
		
		String query = "select * from "
				+ "(select rownum as rnum, posting_no, id,title,content,hits,posting_date,del_yn "
				+ "from (select * from complain_board where title like ? order by posting_no desc)) "
				+ "where rnum>=? and rnum<=?";
	
		try{			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%" + title + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();			
						
			if(rset!=null){
				boardlist = new ArrayList<ComplainBoard>();
				
				while(rset.next()){ 
					ComplainBoard board = new ComplainBoard();
						
					board.setPostingNo(rset.getInt("posting_no"));
					board.setId(rset.getString("id"));
					board.setTitle(rset.getString("title"));
					board.setContent(rset.getString("content"));
					board.setHits(rset.getInt("hits"));
					board.setPostingDate(rset.getDate("posting_date"));
					board.setDelYN(rset.getInt("del_yn"));
					
					boardlist.add(board);
						
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		
		return boardlist;
	}

	
}















