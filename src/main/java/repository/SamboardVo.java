package repository;

public class SamboardVo {

	public int num;
	public int bnum;
	public String type;
	public String writer;
	public String title;
	
	public SamboardVo(int num, int bnum, String type, String writer, String title) {
		super();
		this.num = num;
		this.bnum = bnum;
		this.type = type;
		this.writer = writer;
		this.title = title;
	}
	
	public SamboardVo() {}
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getBnum() {
		return bnum;
	}
	public void setBnum(int bnum) {
		this.bnum = bnum;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	
	
	
}
