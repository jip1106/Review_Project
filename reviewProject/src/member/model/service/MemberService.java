package member.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import member.model.dao.MemberDao;
import member.model.vo.Member;
import memberComplainBoard.model.vo.ComplainBoard;
import memberSharedBoard.model.vo.SharedBoard;

public class MemberService {
	public MemberService(){
		
	}

	public Member loginCheck(String id, String password) {
		//로그인 확인(아이디,비밀번호) 확인 메서드
		Connection con = getConnection();
		Member member = new MemberDao().selectMember(con,id,password);
		close(con);
		
		return member;
	}

	public int insertMember(Member member) {
		//회원 가입을 위한 메서드
		Connection con  = getConnection();
		int result = new MemberDao().insertMember(con,member);
		
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		return result;
	}

	public Member viewMyInformation(String id) {
		//로그인 유저가 유저 정보 확인을 위한 메서드
		Connection con = getConnection();
		Member member = new MemberDao().viewMyInformation(con, id);
		close(con);
		
		return member;
	}

	public int updateMember(Member member) {
		//로그인 유저가 회원 정보 변경 하기 위한 메서드
		Connection con = getConnection();
		int result = new MemberDao().updateMember(con,member);
		
		if(result>0)
			commit(con);
		else
			rollback(con);
		
		close(con);
		
		return result;
	}
	
	
	public int deleteMember(String id) {
		//로그인 유저가 회원 탈퇴하기 위한 메서드
		Connection con = getConnection();
		int result = new MemberDao().deleteMember(con,id);
		
		if(result>0)
			commit(con);
		else
			rollback(con);
		
		close(con);
		return result;
	}

	public int memberCheckId(String id) {
		Connection con = getConnection();
		int check = new MemberDao().memberCheckId(con,id);
		close(con);
		return check;
	}

	public String memberfindId(String email) {
		Connection con = getConnection();
		String id = new MemberDao().memberfindId(con,email);
		close(con);
		return id;
	}

	public String memberfindPwd(String id, String name, String email) {
		Connection con = getConnection();
		String pwd = new MemberDao().memberfindPwd(con,id,name,email);
		close(con);
		return pwd;
	}

	public void insertChangePassword(String id, String pwd) {
		Connection con = getConnection();
		int result = new MemberDao().insertChangePassword(con,id,pwd);
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
	}

	public String selectPwd(String id) {
		Connection con = getConnection();
		String pwd = new MemberDao().selectPwd(con,id);
		close(con);
		return pwd;
	}

	public ArrayList<ComplainBoard> viewMyComplainBoardList(String id,int currentPage, int limit){
	      //내가 쓴 신고 게시글 보기 위한 메서드 
	      Connection con = getConnection();
	      ArrayList<ComplainBoard> cboardList = new MemberDao().viewMyComplainBoardList(con,id,currentPage, limit);
	      
	      close(con);
	      
	      return cboardList;
	   }
	   public int getMyComplainBoardWriteCount(String id){
	      //로그인 회원이 신고 게시판에 몇개 글을 썼는지 확인하기 위한 메서드
	      Connection con = getConnection();
	      int result = new MemberDao().getMyComplainBoardWriteCount(con,id);
	      
	      close(con);
	      return result;
	   }
	   
	   public ArrayList<SharedBoard> viewMySharedBoard(String id,int currentPage, int limit){
	      //내가 쓴 공유 게시글 보기 위한 메서드
	      Connection con = getConnection();
	      
	      ArrayList<SharedBoard> sboardList = new MemberDao().viewMySharedBoard(con,id,currentPage,limit);
	      close(con);
	      return sboardList;
	   }
	   
	   public int getMyShareBoardWriteCount(String id){
	      //로그인 회원이 정보공유 게시판에 몇개 글을 썼는지 확인하기 위한 메서드
	      Connection con = getConnection();
	      int result = new MemberDao().getMyShareBoardWriteCount(con,id);
	      
	      close(con);
	      return result;
	   }

	public String checkExileMember(String email) {
		Connection con = getConnection();
		String exileId = new MemberDao().checkExileMember(con, email);
		close(con);
		return exileId;
	}
}
