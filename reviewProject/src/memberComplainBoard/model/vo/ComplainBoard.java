package memberComplainBoard.model.vo;

import java.sql.Date;
import java.util.ArrayList;

public class ComplainBoard implements java.io.Serializable{
	private static final long serialVersionUID = 10000L;
	
	private int postingNo;
	private String id;
	private String title;
	private String content;
	private int hits;
	private Date postingDate;
	private int delYN;
		
	public ComplainBoard(){}
	

	public ComplainBoard(String id, String title, String content) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
	}

	public ComplainBoard(int postingNo, String id, String title, String content, int hits, Date postingDate,
			int delYN) {
		super();
		this.postingNo = postingNo;
		this.id = id;
		this.title = title;
		this.content = content;
		this.hits = hits;
		this.postingDate = postingDate;
		this.delYN = delYN;
	}
	
	
	public int getPostingNo() {
		return postingNo;
	}

	public void setPostingNo(int postingNo) {
		this.postingNo = postingNo;
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

	@Override
	public String toString(){
		return this.postingNo + ", " + this.id + ", " + 
				this.title + ", " + this.content + ", "
				+ this.hits + ", " + this.postingDate + ", "
				+ this.delYN;
	}


}








