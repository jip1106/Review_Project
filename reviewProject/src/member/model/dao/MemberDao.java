package member.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import common.CryptTemplate;
import member.model.vo.Member;
import member.model.vo.PasswordSecurity;
import memberComplainBoard.model.vo.ComplainBoard;
import memberSharedBoard.model.vo.SharedBoard;

public class MemberDao implements CryptTemplate{
	public MemberDao() {

	}

	public Member selectMember(Connection con, String id, String password) {
		// 로그인 확인(아이디,비밀번호) 확인 , 현재 로그인 유저 확인 메서드
		Member member = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select * from member where id=? and password=?";

		PasswordSecurity ps = new PasswordSecurity(KEY_SIZE, ITERATION_COUNT);
		String encrypt = ps.encrypt(SALT, IV, PASSPHRASE, password);
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, encrypt);

			rset = pstmt.executeQuery();

			if (rset.next()) {
				member = new Member();
				member.setId(id);
				member.setPassword(encrypt);
				member.setName(rset.getString("name"));
				member.setEmail(rset.getString("email"));
				member.setWarningCount(rset.getInt("warning_count"));
				member.setUserType(rset.getInt("user_type"));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return member;
	}

	public int insertMember(Connection con, Member member) {
		// 회원 가입을 위한 메서드
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "insert into member values (?,?,?,?,?,?)";
		
		PasswordSecurity ps = new PasswordSecurity(KEY_SIZE, ITERATION_COUNT);
		String encrypt = ps.encrypt(SALT, IV, PASSPHRASE, member.getPassword());

		try {
			pstmt = con.prepareStatement(query); 
			pstmt.setString(1, member.getId());
			pstmt.setString(2, encrypt);
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getEmail());
			pstmt.setInt(5, member.getWarningCount());
			pstmt.setInt(6, member.getUserType());

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}

	public Member viewMyInformation(Connection con, String id) {
		// 로그인 유저가 유저 정보 확인을 위한 메서드
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		Member member = null;

		String query = "select * from member where id=?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);

			rset = pstmt.executeQuery();

			if (rset.next()) {
				member = new Member();
				member.setId(id);
				member.setPassword(rset.getString("password"));
				member.setName(rset.getString("name"));
				member.setEmail(rset.getString("email"));
				member.setWarningCount(rset.getInt("warning_count"));
				member.setUserType(rset.getInt("user_type"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
			close(rset);
		}
		return member;
	}

	public int updateMember(Connection con, Member member) {
		// 로그인 유저가 회원 정보 변경 하기 위한 메서드
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "update member set password = ?, name =?, email =? where id=?";
		
		PasswordSecurity ps = new PasswordSecurity(KEY_SIZE, ITERATION_COUNT);
		String encrypt = ps.encrypt(SALT, IV, PASSPHRASE, member.getPassword());

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, encrypt);
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getId());

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int deleteMember(Connection con, String id) {
		// 로그인 유저가 회원 탈퇴하기 위한 메서드
		PreparedStatement pstmt = null;
		int result = 0;
		String query = "delete from member where id =?";

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int memberCheckId(Connection con, String id) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select count(*) from member where id = ?";
		int check = 0;

		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);

			rset = pstmt.executeQuery();

			if (rset.next()) {
				check = rset.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return check;
	}

	public String memberfindId(Connection con, String email) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select id from member where email = ?";
		String id = null;
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, email);
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				id = rset.getString(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
			close(rset);
		}
		return id;
	}

	public String memberfindPwd(Connection con, String id, String name, String email) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select password from member where id = ? and name = ? and email = ?";
		String pwd = null;
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, email);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				pwd = rset.getString(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return pwd;
	}

	public int insertChangePassword(Connection con,String id, String pwd) {
		PreparedStatement pstmt = null;
		String query = "update member set password = ? where id = ?";
		int result = 0;
		PasswordSecurity ps = new PasswordSecurity(KEY_SIZE, ITERATION_COUNT);
		String encrypt = ps.encrypt(SALT, IV, PASSPHRASE, pwd);
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, encrypt);
			pstmt.setString(2, id);
			
			result = pstmt.executeUpdate();
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(pstmt);
		}
		
		return result;
	}

	public String selectPwd(Connection con, String id) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select password from member where id = ?";
		String pwd = null;
		
		try{
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, id);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				pwd = rset.getString(1);
			}
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return pwd;
	}
	
	
	 public ArrayList<ComplainBoard> viewMyComplainBoardList(Connection con,String id,int currentPage,int limit) {
	      // 내가 쓴 신고게시글 확인하기 위한 메서드 select 문,id값 기준
	      ArrayList<ComplainBoard> cboardList = null;
	      PreparedStatement pstmt = null;
	      ResultSet rset = null;
	      
	      String query =    "select * from "
	            + "(select rownum as rnum, posting_no,id,title,content,hits,posting_date,del_yn "
	            + "from (select * from complain_board where id=? order by posting_no desc)) "
	            + "where rnum>=? and rnum<=?";
	      
	      int startRow = (currentPage -1)*limit + 1;
	      int endRow = startRow + limit-1;
	      
	      try{
	         pstmt = con.prepareStatement(query);
	         pstmt.setString(1, id);
	         pstmt.setInt(2, startRow);
	         pstmt.setInt(3, endRow);
	         
	         rset = pstmt.executeQuery();
	         
	         cboardList = new ArrayList<ComplainBoard>();
	         
	         if(rset!=null){
	            while(rset.next()){
	               ComplainBoard cboard = new ComplainBoard();
	               
	               cboard.setPostingNo(rset.getInt("posting_no"));
	               cboard.setId(id);
	               cboard.setTitle(rset.getString("title"));
	               cboard.setContent(rset.getString("content"));
	               cboard.setHits(rset.getInt("hits"));
	               cboard.setPostingDate(rset.getDate("posting_date"));
	               cboard.setDelYN(rset.getInt("del_yn"));
	               
	               
	               
	               cboardList.add(cboard);
	            }
	         }
	         
	         
	      }catch(Exception e){
	         e.printStackTrace();
	      }finally{
	         close(rset);
	         close(pstmt);
	      }
	   
	      return cboardList;
	   }

	   public int getMyComplainBoardWriteCount(Connection con, String id) {
	      // 내가 쓴 신고게시글 갯수 알아오는 메서드
	      int result =0;
	      PreparedStatement pstmt = null;
	      ResultSet rset = null;
	      
	      String query = "select count(*) from complain_board where id = ?";
	      
	      try{
	         pstmt = con.prepareStatement(query);
	         pstmt.setString(1, id);
	         
	         rset = pstmt.executeQuery();
	         
	         if(rset.next()){
	            result = rset.getInt(1);
	         }
	         
	      }catch(Exception e){
	         e.printStackTrace();
	      }finally{
	         
	      }
	      return result;
	   }

	   public ArrayList<SharedBoard> viewMySharedBoard(Connection con, String id, int currentPage, int limit) {
	      // 내가 쓴 신고게시글 확인하기 위한 메서드 select 문,id값 기준
	      ArrayList<SharedBoard> sboardList = null;
	      PreparedStatement pstmt = null;
	      ResultSet rset = null;
	      
	      String query = "select * from "
	            + "(select rownum as rnum, posting_no,id,title,content,hits,posting_date,del_yn "
	            + "from (select * from share_board where id=? order by posting_no desc)) "
	            + "where rnum>=? and rnum<=?";

	      int startRow = (currentPage - 1) * limit + 1;
	      int endRow = startRow + limit - 1;

	      try {
	         pstmt = con.prepareStatement(query);
	         pstmt.setString(1, id);
	         pstmt.setInt(2, startRow);
	         pstmt.setInt(3, endRow);

	         rset = pstmt.executeQuery();

	         sboardList = new ArrayList<SharedBoard>();

	         if (rset != null) {
	            while (rset.next()) {
	               SharedBoard sboard = new SharedBoard();

	               sboard.setPostingNum(rset.getInt("posting_no"));
	               sboard.setId(id);
	               sboard.setTitle(rset.getString("title"));
	               sboard.setContent(rset.getString("content"));
	               sboard.setHits(rset.getInt("hits"));
	               sboard.setPostingDate(rset.getDate("posting_date"));
	               sboard.setDelYN(rset.getInt("del_yn"));

	               
	               sboardList.add(sboard);
	            }
	         }

	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         close(rset);
	         close(pstmt);
	      }

	      return sboardList;
	   }
	   
	   public int getMyShareBoardWriteCount(Connection con, String id) {
	      // 내가 쓴 정보공유 게시글 확인하기 위한 메서드
	      int result =0;
	      PreparedStatement pstmt = null;
	      ResultSet rset = null;
	      
	      String query = "select count(*) from share_board where id = ?";
	      
	      try{
	         pstmt = con.prepareStatement(query);
	         pstmt.setString(1, id);
	         
	         rset = pstmt.executeQuery();
	         
	         if(rset.next()){
	            result = rset.getInt(1);
	         }
	         
	      }catch(Exception e){
	         e.printStackTrace();
	      }finally{
	         
	      }
	      return result;
	   }

	public String checkExileMember(Connection con, String email) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String query = "select email from exilemember where email = ?";
		String exileId = null;
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, email);

			rset = pstmt.executeQuery();

			if (rset.next()) {
				exileId = rset.getString(1);
			}
		} catch (Exception e) {

		} finally {
			close(pstmt);
			close(rset);
		}
		return exileId;
	}
}
