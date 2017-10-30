package admin.model.service;

import java.util.ArrayList;

import admin.model.dao.MemberAdminDao;

import static common.JDBCTemplate.*;
import java.sql.*;

import member.model.vo.Member;

public class MemberAdminService {
	
		
	public ArrayList<Member> viewAllMember(int currentPage, int limit) {
		//회원 목록 보여주는 메서드
		Connection con = getConnection();
		ArrayList<Member> mlist = new MemberAdminDao().viewAllMember(con,currentPage,limit);
		close(con);
		
		return mlist;
	}

	public int deleteMember(String id) {
		//회원 관리에서 관리자가 경고횟수 3회 이상인 회원을 삭제하기 위한 메서드
		Connection con = getConnection();
		int result = new MemberAdminDao().deleteMember(con,id);
		
		if(result >0)
			commit(con);
		else
			rollback(con);
		
		close(con);		
		
		return result;
	}

	public int warningCountUp(String id) {
		//회원 관리에서 관리지가 경고를 주기위한 메서드
		Connection con = getConnection();
		int result = new MemberAdminDao().warningCountUp(con, id);
		
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		
		return result;
	}

	public ArrayList<Member> viewSearchIdMember(String id,int currentPage,int limit) {
		Connection con = getConnection();
		ArrayList<Member> list = new MemberAdminDao().viewSearchIdMember(con,id,currentPage,limit);
		
		close(con);
		
		return list;
	}

	public int getMemberCount() {
		// 전체 회원 수 조회
		Connection con = getConnection();
		int result = new MemberAdminDao().getMemberCount(con);
		return result;
	}

	public int getSearchByIdListCount(String id) {
		// 아이디 검색 결과
		Connection con =getConnection();
		int result = new MemberAdminDao().getSearchByIdListCount(con,id);
		close(con);
		
		return result;
	}

	public void insertExileMember(String email) {
		Connection con = getConnection();
		int result = new MemberAdminDao().insertExileMember(con, email);

		if (result > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		close(con);
	}

	public ArrayList<Member> viewWarningCountOverThree() {
		// 경고 수 3회 이상인 회원 뽑아오기
		Connection con = getConnection();
		
		ArrayList<Member> list = new MemberAdminDao().viewWarningCountOverThree(con);
		close(con);
		
		return list;
	}

	
}
