package adminSharedComment.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import memberComplainComment.model.vo.ComplainComment;
import memberSharedComment.model.vo.SharedComment;

public class SharedCommentDao {

	public ArrayList<SharedComment> viewSharedComment(Connection con, int postNum) {
		// 댓글 불러오는 메서드
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<SharedComment> list = new ArrayList<SharedComment>();
		SharedComment comment = null;
		
		String query = "select comment_no,sc.posting_no,sc.id,comment_content,to_char(comment_date,'yyyy-MM-dd hh24:mi:ss') as comment_date"
						+" from share_comment sc"
						+" join share_board sb"
						+" on (sc.posting_no = sb.posting_no)"
						+" where sc.posting_no=?"
						+" order by comment_date desc";
				
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, postNum);
			pstmt.executeQuery();
			
			rset = pstmt.executeQuery();
			
			if(rset!=null){
				while(rset.next()){
					comment = new SharedComment(rset.getString("comment_date"));
					comment.setCommentNo(rset.getInt("comment_no"));
					comment.setPostingNo(rset.getInt("posting_no"));
					comment.setId(rset.getString("id"));
					comment.setCommentContent(rset.getString("comment_content"));
										
					list.add(comment);
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public int insertComment(Connection con, int postNum, String id, String content) {
		//정보공유 게시판 댓글 insert
		PreparedStatement pstmt = null;
		int result =0;
		//postNum, memberId,content
		String query = "insert into share_comment values (share_comment_seq.nextval,?,?,?,default)";
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, postNum);
			pstmt.setString(2, id);
			pstmt.setString(3, content);
			
			result = pstmt.executeUpdate();
					
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		System.out.println("Dao에서 result: " + result);
		return result;
	}

	public int deleteComment(Connection con, int postNum, int commentNum, String id) {
		//댓글 삭제
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "delete from share_comment where posting_no=? and comment_no=? and id=?";
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, postNum);
			pstmt.setInt(2, commentNum);
			pstmt.setString(3, id);
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public int updateComment(Connection con, int postNum, int commentNum, String id, String content) {
		// 댓글 수정
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "update share_comment set comment_content = ? where posting_no = ? and comment_no = ? and id = ?";
		
		try{
			
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, content);
			pstmt.setInt(2, postNum);
			pstmt.setInt(3, commentNum);
			pstmt.setString(4, id);
			
			result = pstmt.executeUpdate();
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		System.out.println("Dao result 값 : " + result);
		return result;
	}

	

}
