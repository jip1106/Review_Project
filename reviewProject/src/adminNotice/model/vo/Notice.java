package adminNotice.model.vo;

import java.sql.Date;

public class Notice implements java.io.Serializable{
	
	private int postingNo;
	private String id;
	private String title;
	private String content;
	private int hits;
	private Date postingDate;
	
	public Notice(){}	
	
	public Notice(String id, String title, String content){
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		
	}
	
	public Notice(int postingNo, String id, String title, String content, int hits, Date postingDate) {
		super();
		this.postingNo = postingNo;
		this.id = id;
		this.title = title;
		this.content = content;
		this.hits = hits;
		this.postingDate = postingDate;
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

	@Override
	public String toString() {
		return "Notice [postingNo=" + postingNo + ", id=" + id + ", title=" + title + ", content=" + content
				+ ", hits=" + hits + ", postingDate=" + postingDate + "]";
	}
	
	
}
