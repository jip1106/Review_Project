package memberReviewBoard.model.vo;

import java.io.Serializable;

public class ReviewLike implements Serializable {
	private String id;
	private int reviewNo;
	private int likeCheck;
	
	public ReviewLike(){}
	
	public ReviewLike(String id, int reviewNo, int likeCheck) {
		super();
		this.id = id;
		this.reviewNo = reviewNo;
		this.likeCheck = likeCheck;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}

	public int getLikeCheck() {
		return likeCheck;
	}

	public void setLikeCheck(int likeCheck) {
		this.likeCheck = likeCheck;
	}

	@Override
	public String toString() {
		return "ReviewLike [id=" + id + ", reviewNo=" + reviewNo + ", likeCheck=" + likeCheck + "]";
	}
	
	
}
