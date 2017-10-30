package admin.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import member.model.vo.Member;

public class MemberAdminDao {

	public ArrayList<Member> viewAllMember(Connection con,int currentPage, int limit) {
		//회원 목록 보여주는 메서드
		ArrayList<Member> mlist = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
				
		String query = "select * from "
				+ "(select rownum as rnum, id,password,name,email,warning_count,user_type from "
				+ "(select * from member order by user_type,name asc)) where rnum>=? and rnum<=?";
		
		int startRow = (currentPage-1)*limit +1; //페이지에 보이는 맨 위의 글
		int endRow = startRow + limit-1;				// 맨 마지막 글
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset = pstmt.executeQuery();
			
			if(rset!=null){
				mlist = new ArrayList<Member>();
				
				while(rset.next()){
					Member member = new Member();
					member.setId(rset.getString("id"));
					member.setPassword(rset.getString("password"));
					member.setName(rset.getString("name"));
					member.setEmail(rset.getString("email"));
					member.setWarningCount(rset.getInt("warning_count"));
					member.setUserType(rset.getInt("user_type"));
					
					mlist.add(member);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		
		return mlist;
	}

	public int deleteMember(Connection con, String id) {
		//경고횟수 3이상인 회원을 강제삭제 하기 위한 메서드
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = "delete from member where id =?";
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public int warningCountUp(Connection con, String id) {
		//회원에게 경고 주기 위한 메서드
		PreparedStatement pstmt = null;
		int result = 0;
		
		String query = "update member "
				+ "set warning_count= (select warning_count from member where id=?) +1 "
				+ "where id=?";
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		System.out.println("result : " + result);
		return result;
	}

	public ArrayList<Member> viewSearchIdMember(Connection con, String id,int currentPage, int limit) {
		//아이디 검색 하기 위한 메서드
		ArrayList<Member> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
/*		String query = "select * from member where id like ? order by id";*/
		String query = "select * from "
				+"(select rownum as rnum,id,password,name,email,warning_count,user_type "
				+"from (select * from member where id like ? order by user_type asc,name asc)) "
				+"where rnum>=? and rnum<=?";
		
		int startRow = (currentPage-1)*limit +1; //페이지에 보이는 맨 위의 글
		int endRow = startRow + limit-1;				// 맨 마지막 글
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%" + id + "%");
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset = pstmt.executeQuery();
			
			if(rset !=null){
				list = new ArrayList<Member>();
				
				while(rset.next()){
					Member member = new Member();
					
					member.setId(rset.getString("id"));
					member.setPassword(rset.getString("password"));
					member.setName(rset.getString("name"));
					member.setEmail(rset.getString("email"));
					member.setWarningCount(rset.getInt("warning_count"));
					member.setUserType(rset.getInt("user_type"));
					
					list.add(member);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			
		}
		return list;
	}

	public int getMemberCount(Connection con) {
		// 전체 회원 수 조회
		int result = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from member";
		
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

	public int getSearchByIdListCount(Connection con, String id) {
		// 검색 된 결과 리스트 갯수 리턴
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int result = 0;
		
		String query = "select count(*) from member where id like ? order by user_type asc,name asc";
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%"+id+"%");
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
		return result;
	}

	public int insertExileMember(Connection con, String email) {
		PreparedStatement pstmt = null;
		String query = "insert into ExileMember values(?)";
		int result = 0;

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, email);

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public ArrayList<Member> viewWarningCountOverThree(Connection con) {
		// 경고횟수 많은 회원 3명 뽑아오기
		Statement stmt = null;
		ResultSet rset = null;
		ArrayList<Member> list = new ArrayList<Member>();
		
		String query = "select * from "
				+ "(select rownum as rnum,id,password,name,email,warning_count,user_type "
				+ "from (select * from member where warning_count>=3 order by warning_count desc)) "
				+ "where rnum>=1 and rnum<=3";
		try{
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			if(rset!=null){
				while(rset.next()){
					Member member = new Member();
					member.setId(rset.getString("id"));
					member.setPassword(rset.getString("password"));
					member.setName(rset.getString("name"));
					member.setEmail(rset.getString("email"));
					member.setWarningCount(rset.getInt("warning_count"));
					member.setUserType(rset.getInt("user_type"));
					
					list.add(member);
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
