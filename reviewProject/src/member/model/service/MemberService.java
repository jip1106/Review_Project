package member.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import admin.model.dao.MemberAdminDao;
import member.model.dao.MemberDao;
import member.model.vo.Member;
import memberComplainBoard.model.vo.ComplainBoard;
import memberSharedBoard.model.vo.SharedBoard;

public class MemberService {
	public MemberService(){
		
	}
	
	public Member checkAlreadyUser(String id) {
		// 아이디 체크하기 위한 메서드
		Connection con = getConnection();
		Member member= new MemberDao().checkAlreadyUser(con,id);
		System.out.println("service딴 id"+ id);
		close(con);
		
		return member;
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

}
