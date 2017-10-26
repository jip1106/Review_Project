package adminComplainComment.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import memberComplainComment.model.vo.ComplainComment;

public class ComplainCommentDao {

	public ArrayList<ComplainComment> viewComplainComment(Connection con, int postNum) {
		//댓글 불러오는 메서드
		Statement stmt = null;
		ResultSet rset = null;
		ArrayList<ComplainComment> list = new ArrayList<ComplainComment>();
		ComplainComment comment = null;
		
		String query = "select comment_no,cc.posting_no,cc.id,comment_content, to_char(comment_date,'yyyy-MM-dd hh24:mi:ss') as comment_date "
				+ "from complain_comment cc "
				+ "join complain_board cb "
				+ "on (cc.posting_no = cb.posting_no) "
				+ "order by comment_date desc";
		
		try{
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset!=null){
				while(rset.next()){
					comment = new ComplainComment(rset.getString("comment_date"));
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
			close(stmt);
		}
		
		return list;
	}

	public int insertComment(Connection con, int postNum,String id, String content) {
		// 댓글 insert
		PreparedStatement pstmt = null;
		int result =0;
		//postNum, memberId,content
		String query = "insert into complain_comment values (complain_seq.nextval,?,?,?,default)";
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
		// 댓글 삭제
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "delete from complain_comment where posting_no=? and comment_no=? and id=?";
		
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

	

}
