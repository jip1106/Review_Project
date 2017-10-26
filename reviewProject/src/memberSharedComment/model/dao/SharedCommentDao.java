package memberSharedComment.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import static common.JDBCTemplate.*;

import memberSharedComment.model.vo.SharedComment;

public class SharedCommentDao{

	public int insertSharedComment(Connection con, int no, String id, String content) {
		PreparedStatement pstmt = null;
		String query="insert into share_comment values(share_comment_seq.nextval,?,?,?,default)";
		int result = 0;
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, no);
			pstmt.setString(2, id);
			pstmt.setString(3, content);
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		return result;
	}

	public ArrayList<SharedComment> selectSharedComment(Connection con, int no) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		ArrayList<SharedComment> list = new ArrayList<SharedComment>();
		SharedComment comment = null;
		String query = "select * from share_comment where posting_no = ? order by comment_no desc";
		
		System.out.println(list);
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
		System.out.println("dao:" + list);
		return list;
	}

	public int deleteSharedComment(Connection con, int commentNo, int sharedNo) {
		PreparedStatement pstmt = null;
		String query = "delete from share_comment where comment_no = ? and posting_no = ?";
		int result = 0;
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, commentNo);
			pstmt.setInt(2, sharedNo);
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		return result;
	}

	public int updateSharedComment(Connection con, int commentNo, int sharedNo, String content) {
		PreparedStatement pstmt = null;
		String query = "update share_comment set comment_content = ? where comment_no = ? and posting_no = ?";
		int result = 0;
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, content);
			pstmt.setInt(2, commentNo);
			pstmt.setInt(3, sharedNo); 
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		return result;
	}
}
