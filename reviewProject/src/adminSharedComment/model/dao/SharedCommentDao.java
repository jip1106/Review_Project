package adminSharedComment.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.util.ArrayList;

import memberSharedComment.model.vo.SharedComment;

public class SharedCommentDao {

	public int insertReviewComment(Connection con, int no, String id, String content) {
		java.sql.PreparedStatement pstmt = null;
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

	public ArrayList<SharedComment> selectReviewComment(Connection con, int no) {
		java.sql.PreparedStatement pstmt = null;
		java.sql.ResultSet rset = null;
		ArrayList<SharedComment> list = new ArrayList<SharedComment>();
		SharedComment comment = null;
		String query = "select * from share_comment where posting_no = ? order by comment_no desc";
		
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
