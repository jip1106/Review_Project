package memberSharedBoard.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import memberSharedBoard.model.vo.SharedBoard;

public class SharedBoardDao {

	public ArrayList<SharedBoard> selectList(Connection con, int currentPage, int limit) {
		//정보공유 게시판 전체 조회용 메소드
		ArrayList<SharedBoard> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from ("
				+ "select rownum rnum, posting_no, id, "
				+ "title, content, hits, posting_date, del_yn "
				+ "from (select * from share_board "
				+ "order by posting_no desc)) "
				+ "where rnum >= ? and rnum <= ?";
		
		int startRow = (currentPage -1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			if(rset != null){
				list = new ArrayList<SharedBoard>();
				
				while(rset.next()){
					SharedBoard sb = new SharedBoard();
					
					sb.setPostingNum(rset.getInt("posting_no"));
					sb.setId(rset.getString("id"));
					sb.setTitle(rset.getString("title"));
					sb.setContent(rset.getString("content"));
					sb.setHits(rset.getInt("hits"));
					sb.setPostingDate(rset.getDate("posting_date"));
					sb.setDelYN(rset.getInt("del_yn"));
					
					list.add(sb);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public SharedBoard selectOne(Connection con, int no) {
		SharedBoard sb = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from share_board where posting_no=?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, no);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				sb = new SharedBoard();
				
				sb.setPostingNum(no);
				sb.setId(rset.getString("id"));
				sb.setTitle(rset.getString("title"));
				sb.setContent(rset.getString("content"));
				sb.setHits(rset.getInt("hits"));
				sb.setPostingDate(rset.getDate("posting_date"));
				sb.setDelYN(rset.getInt("del_yn"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return sb;
	}

	public int updateReadCount(Connection con, int no) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update share_board set hits = hits+1"
				+ "where posting_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, no);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		return result;
		
	}

	public int insertSharedBoard(Connection con, SharedBoard sharedBoard) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query ="insert into share_board values "
				+ "((select max(posting_no) + 1 from share_board), "
				+ "?, ?, ?, default, sysdate, default)";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, sharedBoard.getId());
			pstmt.setString(2, sharedBoard.getTitle());
			pstmt.setString(3, sharedBoard.getContent());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		return result;
	}

	public int deleteSharedBoard(Connection con, int no) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "delete from share_board where posting_no =?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, no);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public ArrayList<SharedBoard> titleSearch(Connection con, int currentPage, int limit, String searchMenu, String keyword) {
		ArrayList<SharedBoard> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = null;
		
			if(searchMenu.equals("findByTitle")){
				 query ="select * from ("
							+ "select rownum rnum, posting_no, id, "
							+ "title, content, hits, posting_date, del_yn "
							+ "from (select * from share_board "
							+ "where title like ? "
							+ "order by posting_no desc )) "
							+ "where rnum >= ? and rnum <= ? ";
					
			}else if(searchMenu.equals("findByWriter")){
				query="select * from ("
						+ "select rownum rnum, posting_no, id, "
						+ "title, content, hits, posting_date, del_yn "
						+ "from (select * from share_board "
						+ "where id like ? "
						+ "order by posting_no desc )) "
						+ "where rnum >= ? and rnum <= ? ";
			}
			
		int startRow = (currentPage -1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%" +keyword+ "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
		
			rset = pstmt.executeQuery();
			
			if(rset != null) {
				list = new ArrayList<SharedBoard>();
				
				while(rset.next()) {
					SharedBoard sb = new SharedBoard();
					
					sb.setPostingNum(rset.getInt("posting_no"));
					sb.setId(rset.getString("id"));
					sb.setTitle(rset.getString("title"));
					sb.setContent(rset.getString("content"));
					sb.setHits(rset.getInt("hits"));
					sb.setPostingDate(rset.getDate("posting_date"));
					sb.setDelYN(rset.getInt("del_yn"));
					
					list.add(sb);
				}
		
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}	
			
	public int updateSharedBoard(Connection con, SharedBoard sb) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update share_board set title=?, content=? where posting_no=?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, sb.getTitle());
			pstmt.setString(2, sb.getContent());
			pstmt.setInt(3, sb.getPostingNum());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		return result;
	}

	public int getListCount(Connection con) {
		int result = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from share_board";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset.next())
				result = rset.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(stmt);
		}
		return result;
	}

	public int getSearchCount(Connection con, String searchMenu, String keyword) {
		int result = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = null;
		
		if(searchMenu.equals("findByTitle")){
			query = "select count(*) from share_board where title like ? ";
		}else if(searchMenu.equals("findByWriter")){
			query = "select count(*) from share_board where id like ?";
		}
	
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%"+keyword+"%");
			rset = pstmt.executeQuery();
			
			if(rset.next())
				result = rset.getInt(1);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return result;
	}
}
