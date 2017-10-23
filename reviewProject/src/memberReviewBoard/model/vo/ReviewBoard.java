package memberReviewBoard.model.vo;

import java.sql.Date;

import com.sun.xml.internal.bind.v2.model.core.ID;

public class ReviewBoard implements java.io.Serializable{
	
	private int posting_no;
	private String id;
	private String title;
	private String content;
	private int hits;
	private Date postingDate;
	private int delYN;
	private String location;
	private String category;
	private String address;
	private String storeName;
	private String imageName;
	private String renameImageName;
	private int likes;
	private int evaluation;
	
	
	public ReviewBoard(){
		super();
	}
	
	 
	
	public ReviewBoard(int posting_no) {
		super();
		this.posting_no = posting_no;
	}



	public ReviewBoard(int posting_no, String id, String title, String content, int hits, Date postingDate, int delYN,
			String location, String category, String address, String storeName, String imageName, int likes, int evaluation) {
		super();
		this.posting_no = posting_no;
		this.id = id;
		this.title = title;
		this.content = content;
		this.hits = hits;
		this.postingDate = postingDate;
		this.delYN = delYN;
		this.location = location;
		this.category = category;
		this.address = address;
		this.storeName = storeName;
		this.imageName = imageName;
		this.likes = likes;
		this.evaluation = evaluation;
	}
	
	public ReviewBoard(String id, String title, String content, String location, String category, String address,
			String storeName, String imageName,String renameImageName, int evaluation) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.location = location;
		this.category = category;
		this.address = address;
		this.storeName = storeName;
		this.imageName = imageName;
		this.renameImageName = renameImageName; 
		this.evaluation = evaluation;
	}
	
	
	public ReviewBoard(int posting_no, String id, String title, String content, String location, String category,
			String address, String storeName, String imageName, String renameImageName, int evaluation) {
		super();
		this.posting_no = posting_no;
		this.id = id;
		this.title = title;
		this.content = content;
		this.location = location;
		this.category = category;
		this.address = address;
		this.storeName = storeName;
		this.imageName = imageName;
		this.renameImageName = renameImageName;
		this.evaluation = evaluation;
	}

	public String getRenameImageName() {
		return renameImageName;
	}

	public void setRenameImageName(String renameImageName) {
		this.renameImageName = renameImageName;
	}

	public int getPosting_no() { 
		return posting_no;
	}

	public int getEvaluation() {
		return evaluation;
	}

	public void setEvaluation(int evaluation) {
		this.evaluation = evaluation;
	}

	public void setPosting_no(int posting_no) {
		this.posting_no = posting_no;
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

	public String getLocation() {
		return location;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getImageName() {
		return imageName;
	}

	public void setImageName(String imageName) {
		this.imageName = imageName;
	}

	public int getLikes() {
		return likes;
	}

	public void setLikes(int likes) {
		this.likes = likes;
	}

	@Override
	public String toString() {
		return "ReviewBoard [posting_no=" + posting_no + ", id=" + id + ", title=" + title + ", content=" + content
				+ ", hits=" + hits + ", postingDate=" + postingDate + ", delYN=" + delYN + ", location=" + location
				+ ", category=" + category + ", address=" + address + ", storeName=" + storeName + ", imageName="
				+ imageName + ", likes=" + likes + "]";
	}
	
	
	
}

