package adminReviewBoard.model.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import static common.JDBCTemplate.*;
public class ReviewBoardDao {

	public int getReviewListCount(Connection con) {
		// 리뷰게시판 갯수 알기 위한 메서드
		int result = 0;
		
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from review_board ";
		
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

}
