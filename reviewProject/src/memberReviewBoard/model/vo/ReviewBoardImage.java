package memberReviewBoard.model.vo;

import java.io.Serializable;

public class ReviewBoardImage implements Serializable {
	
	private int imageNo;
	private int reviewBoardNO;
	private String originalFileName;
	private String reFileName;
	
	public ReviewBoardImage(){}

	public ReviewBoardImage(int imageNo, int reviewBoardNO, String originalFileName, String reFileName) {
		super();
		this.imageNo = imageNo;
		this.reviewBoardNO = reviewBoardNO;
		this.originalFileName = originalFileName;
		this.reFileName = reFileName;
	}

	public ReviewBoardImage(int reviewBoardNO, String originalFileName, String reFileName) {
		super();
		this.reviewBoardNO = reviewBoardNO;
		this.originalFileName = originalFileName;
		this.reFileName = reFileName;
	}

	public int getImageNo() {
		return imageNo;
	}

	public void setImageNo(int imageNo) {
		this.imageNo = imageNo;
	}

	public int getReviewBoardNO() {
		return reviewBoardNO;
	}

	public void setReviewBoardNO(int reviewBoardNO) {
		this.reviewBoardNO = reviewBoardNO;
	}

	public String getOriginalFileName() {
		return originalFileName;
	}

	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}

	public String getReFileName() {
		return reFileName;
	}

	public void setReFileName(String reFileName) {
		this.reFileName = reFileName;
	}

	@Override
	public String toString() {
		return "ReviewBoardImage [imageNo=" + imageNo + ", reviewBoardNO=" + reviewBoardNO + ", originalFileName="
				+ originalFileName + ", reFileName=" + reFileName + "]";
	}
	
}
