package adminShareBoard.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import memberSharedBoard.model.vo.SharedBoard;
import memberSharedComment.model.vo.SharedComment;

public class ShareBoardDao {

	// 정보공유 게시판 글목록 (전체보기)
	public ArrayList<SharedBoard> selectList(Connection con, int currentPage, int limit) {
		ArrayList<SharedBoard> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select * from "
				+ "(select rownum as rnum, posting_no,id,title,content,hits,posting_date,del_yn "
				+ "from (select * from share_board order by posting_no desc)) " + "where rnum>=? and rnum<=?";

		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);

			rset = pstmt.executeQuery();

			if (rset != null) {
				list = new ArrayList<SharedBoard>();

				while (rset.next()) {
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
		} finally {
			close(rset);
			close(pstmt);
		}

		return list;
	}

	public SharedBoard detailSharedBoard(Connection con, int no) {
		SharedBoard sb = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select * from share_board where posting_no = ?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, no);

			rset = pstmt.executeQuery();

			if (rset.next()) {
				sb = new SharedBoard();

				sb.setPostingNum(rset.getInt("posting_no"));
				sb.setId(rset.getString("id"));
				sb.setTitle(rset.getString("title"));
				sb.setContent(rset.getString("content"));
				sb.setHits(rset.getInt("hits"));
				sb.setPostingDate(rset.getDate("posting_date"));
				sb.setDelYN(rset.getInt("del_yn"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return sb;
	}

	public int hitsUp(Connection con, int no) {
		int result = 0;
		PreparedStatement pstmt = null;

		String query = "update share_board set hits = hits + 1 " + "where posting_no = ?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, no);

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public int deleteSharedBoard(Connection con, int no) {
		int result = 0;
		PreparedStatement pstmt = null;

		String query = "delete from share_board where posting_no = ?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, no);

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	// 정보공유 게시판 전체글 개수 세기
	public int getShareBoardListCount(Connection con) {
		int result = 0;
		Statement stmt = null;
		ResultSet rset = null;

		String query = "select count(*) from share_board";

		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);

			if (rset.next()) {
				result = rset.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		return result;
	}

	// 정보공유 게시판 작성자(id)로 검색하기
	public ArrayList<SharedBoard> shareBoardSearchId(Connection con, String id, int currentPage, int limit) {
		ArrayList<SharedBoard> shareBoardlist = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		String query = "select * from "
				+ "(select rownum as rnum, posting_no,id,title,content,hits,posting_date,del_yn "
				+ "from (select * from share_board where id like ? order by posting_no desc)) "
				+ "where rnum>=? and rnum<=?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%" + id + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);

			rset = pstmt.executeQuery();
			if (rset != null) {
				shareBoardlist = new ArrayList<SharedBoard>();

				while (rset.next()) {
					SharedBoard sb = new SharedBoard();
					sb.setPostingNum(rset.getInt("posting_no"));
					sb.setId(rset.getString("id"));
					sb.setTitle(rset.getString("title"));
					sb.setContent(rset.getString("content"));
					sb.setHits(rset.getInt("hits"));
					sb.setPostingDate(rset.getDate("posting_date"));
					sb.setDelYN(rset.getInt("del_yn"));

					shareBoardlist.add(sb);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return shareBoardlist;
	}

	// 정보공유 게시판 제목(title)로 검색하기
	public ArrayList<SharedBoard> shareBoardSearchTitle(Connection con, String title, int currentPage, int limit) {
		ArrayList<SharedBoard> shareBoardlist = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		int startRow = (currentPage - 1) * limit + 1;
		int endRow = startRow + limit - 1;
		
		String query = "select * from "
				+ "(select rownum as rnum, posting_no,id,title,content,hits,posting_date,del_yn "
				+ "from (select * from share_board where title like ? order by posting_no desc)) "
				+ "where rnum>=? and rnum<=?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%" + title + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);

			rset = pstmt.executeQuery();
			if (rset != null) {
				shareBoardlist = new ArrayList<SharedBoard>();

				while (rset.next()) {
					SharedBoard sb = new SharedBoard();
					sb.setPostingNum(rset.getInt("posting_no"));
					sb.setId(rset.getString("id"));
					sb.setTitle(rset.getString("title"));
					sb.setContent(rset.getString("content"));
					sb.setHits(rset.getInt("hits"));
					sb.setPostingDate(rset.getDate("posting_date"));
					sb.setDelYN(rset.getInt("del_yn"));

					shareBoardlist.add(sb);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return shareBoardlist;
	}

	// 정보공유 게시판 게시글 삭제하기
	public int deleteShareBoard(Connection con, int postingNum) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "delete from share_board where posting_no = ?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, postingNum);

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}
	
	// 정보공유 게시판 작성자(id), 제목(title) 검색한 후 글 개수 세기
	public int getSearchCount(Connection con, String inputValue, String selectSearch) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = null;
		int result = 0;
		
		if (selectSearch.equals("searchtitle")) {
			query = "select count(*) from share_board where title like ? order by posting_no desc";
		
			try{
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, "%"+inputValue+"%");
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
		
		if (selectSearch.equals("searchid")) {
			query = "select count(*) from share_board where id like ? order by posting_no desc";
		
			try{
				pstmt = con.prepareStatement(query);
				pstmt.setString(1, "%"+inputValue+"%");
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
		
		return result;
	}

	public ArrayList<SharedComment> selectCommentList(Connection con, int no) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select * from share_comment where posting_no = ? order by comment_no desc";
		ArrayList<SharedComment> list = new ArrayList<SharedComment>();
		SharedComment comment = null;
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, no);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				comment = new SharedComment();
				comment.setCommentNo(rset.getInt("comment_no"));
				comment.setPostingNo(rset.getInt("posting_no"));
				comment.setId(rset.getString("id"));
				comment.setCommentContent(rset.getString("comment_content"));
				comment.setCommentDate(rset.getDate("comment_date"));
				list.add(comment);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return list;
	}

}
