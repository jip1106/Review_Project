package memberSharedBoard.model.vo;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.getConnection;

import java.sql.Date;
import java.util.ArrayList;

import adminShareBoard.model.dao.ShareBoardDao;
import memberSharedComment.model.vo.SharedComment;

public class SharedBoard implements java.io.Serializable{
	
	private static final long serialVersionUID = 10000L;
	
	private int postingNum;
	private String id;
	private String title;
	private String content;
	private int hits;
	private Date postingDate;
	private int delYN;
	
	public SharedBoard(){
		
	}

	
	public SharedBoard(int postingNum, String id, String title, String content, int hits, Date postingDate, int delYN) {
		super();
		this.postingNum = postingNum;
		this.id = id;
		this.title = title;
		this.content = content;
		this.hits = hits;
		this.postingDate = postingDate;
		this.delYN = delYN;
	}


	public int getPostingNum() {
		return postingNum;
	}

	public void setPostingNum(int postingNum) {
		this.postingNum = postingNum;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getHits() {
		return hits;
	}

	public void setHits(int hits) {
		this.hits = hits;
	}

	public Date getPostingDate() {
		return postingDate;
	}

	public void setPostingDate(Date postingDate) {
		this.postingDate = postingDate;
	}

	public int getDelYN() {
		return delYN;
	}

	public void setDelYN(int delYN) {
		this.delYN = delYN;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "SharedBoard [postingNum=" + postingNum + ", id=" + id + ", title=" + title + ", content=" + content
				+ ", hits=" + hits + ", postingDate=" + postingDate + ", delYN=" + delYN + "]";
	}


	public ArrayList<SharedComment> selectCommentList(int no) {
		java.sql.Connection con = getConnection();
		ArrayList<SharedComment> list = new ShareBoardDao().selectCommentList(con,no);
		close(con);
		return list;
	}
	
		
	

}
