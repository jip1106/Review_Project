package memberComplainBoard.model.dao;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import static common.JDBCTemplate.*;
import memberComplainBoard.model.vo.ComplainBoard;

public class ComplainBoardDao {
	public ComplainBoardDao() {
	}

	public int getListCount(Connection con) {

		int result = 0;
		Statement stmt = null;
		ResultSet rset = null;

		String query = "select count(*) from complain_board ";

		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);

			if (rset.next())
				result = rset.getInt(1);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}

		return result;

	}

	// 전체게시글 조회 page 처리 해야함
	public ArrayList<ComplainBoard> selectList(Connection con, int Page, int limit) {

		ArrayList<ComplainBoard> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select * from "
				+ "(select rownum as rnum, posting_no,id,title,content,hits,posting_date,del_yn "
				+ "from (select * from complain_board order by posting_no desc)) " + "where rnum>=? and rnum<=?";

		int startRow = (Page - 1) * limit + 1;
		int endRow = startRow + limit - 1;

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rset = pstmt.executeQuery();

			if (rset != null) {
				list = new ArrayList<ComplainBoard>();

				while (rset.next()) {
					ComplainBoard cb = new ComplainBoard();

					cb.setPostingNo(rset.getInt("posting_no"));
					cb.setId(rset.getString("id"));
					cb.setTitle(rset.getString("title"));
					cb.setContent(rset.getString("content"));
					cb.setHits(rset.getInt("hits"));
					cb.setPostingDate(rset.getDate("posting_date"));
					cb.setDelYN(rset.getInt("del_yn"));
					list.add(cb);
				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return list;
	}

	public int addReadCount() {

		return 0;
	}

	public int addReadCount(Connection con, int postingNo) {
		int result = 0;
		PreparedStatement pstmt = null;

		String query = "update complain_board set hits= hits+1 where posting_no = ?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, postingNo);
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public ComplainBoard selectBoard(Connection con, int bnum) {
		ComplainBoard ComplainBoard = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select * from complain_board where posting_no = ?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, bnum);

			rset = pstmt.executeQuery();

			if (rset.next()) {
				ComplainBoard = new ComplainBoard();

				ComplainBoard.setPostingNo(rset.getInt("posting_no"));
				ComplainBoard.setId(rset.getString("id"));
				ComplainBoard.setTitle(rset.getString("title"));
				ComplainBoard.setContent(rset.getString("content"));
				ComplainBoard.setHits(rset.getInt("hits"));
				ComplainBoard.setPostingDate(rset.getDate("posting_date"));
				ComplainBoard.setDelYN(rset.getInt("del_yn"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return ComplainBoard;
	}

	public int deleteBoard(Connection con, int bnum) {
		int result = 0;
		PreparedStatement pstmt = null;

		String query = "delete from complain_board where posting_no = ?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, bnum);

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int insertBoard(Connection con, ComplainBoard cb) {
		int result = 0;
		PreparedStatement pstmt = null;

		String query = "insert into complain_board values (complain_seq.nextval,"
				+ "?, ?, ?, default,default, default)";

		try {
			pstmt = con.prepareStatement(query);

			pstmt.setString(1, cb.getId());
			pstmt.setString(2, cb.getTitle());
			pstmt.setString(3, cb.getContent());

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;

	}

	public int updateComplainBoard(Connection con, ComplainBoard complainBoard) {
		int result = 0;
		PreparedStatement pstmt = null;

		String query = "update complain_board set title = ?, " + "content = ? where posting_no = ?";

		try {

			pstmt = con.prepareStatement(query);
			pstmt.setString(1, complainBoard.getTitle());
			pstmt.setString(2, complainBoard.getContent());
			pstmt.setInt(3, complainBoard.getPostingNo());
			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public ArrayList<ComplainBoard> selectSearch(Connection con, int Page, int limit, String searchValue, String searchKeyWord) {
		
		ArrayList<ComplainBoard> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = null;
		
		if(searchValue.equals("findByTitle")){
		query = "select * from "
				+ "(select rownum as rnum, posting_no,id,title,content,hits,posting_date,del_yn "
				+ "from (select * from complain_board where title like ? order by posting_no desc)) " + "where rnum>=? and rnum<=?";
		}
		else if(searchValue.equals("findByWriter")){
			query = "select * from "
					+ "(select rownum as rnum, posting_no,id,title,content,hits,posting_date,del_yn "
					+ "from (select * from complain_board where id like ? order by posting_no desc)) " + "where rnum>=? and rnum<=?";
		}

		int startRow = (Page - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		try {
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, "%"+searchKeyWord+"%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			rset = pstmt.executeQuery();

			if (rset != null) {
				list = new ArrayList<ComplainBoard>();

				while (rset.next()) {
					ComplainBoard cb = new ComplainBoard();

					cb.setPostingNo(rset.getInt("posting_no"));
					cb.setId(rset.getString("id"));
					cb.setTitle(rset.getString("title"));
					cb.setContent(rset.getString("content"));
					cb.setHits(rset.getInt("hits"));
					cb.setPostingDate(rset.getDate("posting_date"));
					cb.setDelYN(rset.getInt("del_yn"));
					list.add(cb);
				}
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return list;
	}

	public int getSearchCount(Connection con, String searchValue, String searchKeyWord) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = null;
		
		if(searchValue.equals("findByTitle")){
		 query = "select count(*) from complain_board where title like ?";
		}
		else if(searchValue.equals("findByWriter")){
			query = "select count(*) from complain_board where id like ?";
		}
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%"+searchKeyWord+"%");
			rset = pstmt.executeQuery();
			
			if (rset.next())
				result = rset.getInt(1);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return result;
	}


}
