package adminComplainComment.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import memberComplainComment.model.vo.ComplainComment;

public class ComplainCommentDao {

	public ArrayList<ComplainComment> viewComplainComment(Connection con, String postNum) {
		//댓글 불러오는 메서드
		Statement stmt = null;
		ResultSet rset = null;
		ArrayList<ComplainComment> list = new ArrayList<ComplainComment>();
		ComplainComment comment = null;
		
		String query = "select comment_no,cc.posting_no,cc.id,comment_content, to_char(comment_date,'YYYY-MM-DD') as comment_date "
				+ "from complain_comment cc "
				+ "join complain_board cb "
				+ "on (cc.posting_no = cb.posting_no)";
		
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

}
