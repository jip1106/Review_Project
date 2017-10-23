package adminNotice.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import adminNotice.model.vo.Notice;

public class NoticeDao {

	public int insertNotice(Connection con, Notice notice) {
		// 공지글 쓰기 insert 문
		int result = 0;
		PreparedStatement pstmt = null;
				
		String query = "insert into notice values "
				+"(notice_seq.nextval,?,?,?,default,default)";
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, notice.getId());
			pstmt.setString(2, notice.getTitle());
			pstmt.setString(3, notice.getContent());
			
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public int deleteNotice(Connection con, int postNo) {
		//공지글 삭제	delete문
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "delete from notice where posting_no = ?";
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, postNo);
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		
		return result;
	}
	

	public int updateReadCount(Connection con, int postNo) {
		// 조회수 증가 처리 메서드 update 문
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update notice set hits= hits+1 where posting_no = ?";
		
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, postNo);
			
			result = pstmt.executeUpdate();			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
	
			close(pstmt);
		}
		
		return result;
	}

	public ArrayList<Notice> viewNoticeList(Connection con) {
		// 공지사항 보여주는 메서드 select 문 (*)
		ArrayList<Notice> noticeList = null;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select * from notice order by posting_no desc";
		
		try{
			noticeList = new ArrayList<Notice>();
			
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			// 노티스 채워넣어야됨
			
			if(rset!=null){
				while(rset.next()){
						
				Notice notice = new Notice();
				notice.setPostingNo(rset.getInt("posting_no"));
				notice.setId(rset.getString("id"));
				notice.setTitle(rset.getString("title"));
				notice.setContent(rset.getString("content"));
				notice.setHits(rset.getInt("hits"));
				notice.setPostingDate(rset.getDate("posting_date"));
					
				noticeList.add(notice);
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(stmt);
		}
		
		return noticeList;
	}

	public Notice viewNoticeDetail(Connection con, int postNo) {
		// 공지글 상세보기 메서드 select문(postNo 로)
		Notice notice = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from notice where posting_no = ?";
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, postNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				notice = new Notice();
				
				notice.setPostingNo(rset.getInt("posting_no"));
				notice.setId(rset.getString("id"));
				notice.setTitle(rset.getString("title"));
				notice.setContent(rset.getString("content"));
				notice.setHits(rset.getInt("hits"));
				notice.setPostingDate(rset.getDate("posting_date"));
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
			
		}
		
		return notice;
	}

	public int updateNotice(Connection con, int postNo,String title,String content) {
		// 공지사항 수정
		int result = 0;
		PreparedStatement pstmt = null;
		String query ="update notice set title = ?, content=? where posting_no=?";
		
		try{
			pstmt= con.prepareStatement(query);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setInt(3, postNo);
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}
	

}
