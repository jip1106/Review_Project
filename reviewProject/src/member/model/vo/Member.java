package member.model.vo;

public class Member implements java.io.Serializable{
	
	private String id;
	private String password;
	private String name;
	private String email;	
	private int warningCount;	//3번 이상이면 회원탈퇴됨
	private int userType;	//0이면 관리자 1이면 사용자
	
	public Member(){
		super();
	}

	public Member(String id, String password, String name, String email, int warningCount, int userType) {
		super();
		this.id = id;
		this.password = password;
		this.name = name;
		this.email = email;
		this.warningCount = warningCount;
		this.userType = userType;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getWarningCount() {
		return warningCount;
	}

	public void setWarningCount(int warningCount) {
		this.warningCount = warningCount;
	}

	public int getUserType() {
		return userType;
	}

	public void setUserType(int userType) {
		this.userType = userType;
	}
	
	@Override
	public String toString(){
		return this.id + " , " + this.password + " , " + this.name + " , " + this.email + " ," + this.warningCount + " , " + this.userType;
	} 
}
