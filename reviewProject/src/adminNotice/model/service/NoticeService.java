package adminNotice.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import adminNotice.model.dao.NoticeDao;
import adminNotice.model.vo.Notice;

public class NoticeService {

	public int insertNotice(Notice notice) {
		// 공지글 쓰기 메서드
		Connection con = getConnection();
		int result = new NoticeDao().insertNotice(con,notice);
		
		if(result>0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		
		return result;
	}
	
	public int deleteNotice(int postNo){
		// 공지글 삭제 메서드 :	삭제 버튼 누르면 연결될 서블릿에서 호출할 메서드
		Connection con = getConnection();
		int result = new NoticeDao().deleteNotice(con,postNo);
		
		if(result>0){
			commit(con);
		}else{
			rollback(con);
		}
		
		return result;
	}

	public void addReadCount(int postNo){
		//조회수 증가처리 메서드
		Connection con = getConnection();
		int result = new NoticeDao().updateReadCount(con,postNo);
		
		if(result>0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
	}
	
	public ArrayList<Notice> viewNoticeList(){
		//공지사항 보여주는 메서드(공지사항 테이블에 들어있는 것들 select 해서 관리자 main, 유저main 에 보여주면 됨)
		//보여줄 jsp파일에 Notice,NoticeService, NoticeDao import 해서 이 메서드 부를것.
		Connection con = getConnection();
		ArrayList<Notice> noticeList = new NoticeDao().viewNoticeList(con);
		close(con);
		
		return noticeList;
	}
	
	public Notice viewNoticeDetail(int postNo){
		//공지글 상세보기 메서드
		Connection con = getConnection();
		Notice notice =new NoticeDao().viewNoticeDetail(con,postNo);
		
		close(con);
		
		return notice;
	}

	public int updateNotice(int postNo,String title, String content) {
		// 공지글 수정 메서드
		Connection con = getConnection();
		int result = new NoticeDao().updateNotice(con,postNo,title,content);
		
		if(result>0){
			commit(con);
		}else{
			rollback(con);
		}
		
		close(con);
		
		return result;
	}
	
	
	
	
}
