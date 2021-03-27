package repository;

import java.sql.Timestamp;

/*
 * create table BBOARD (
				"ID" number primary key,
				"WRITER" varchar2(50) not null,
				"TITLE" varchar2(100) not null,
				"CONTENT" varchar2(4000) not null,
				"WRITEDATE" timestamp);			
 */

/*
 * alter table BBOARD add (
    "READCOUNT" number(5,0) not null,
    "FILE_NAME" varchar2(45) null,
    "FILE_TYPE" varchar2(500) null,
    "FILE_PATH" varchar2(500) null,
    "FILE_ORIGINAL_NAME" varchar2(45) null
    );
 */

public class BboardVo {
	
	public String id;
	public String writer;
	public String title;
	public Timestamp writedate;
	public String content;
	public int readCount;
	public String fileName;
	public String fileType;
	public String filePath;
	public String fileOriginalName;
	
	
	
	public BboardVo(String id, String writer, String title, Timestamp writedate, String content, int readCount,
			String fileName, String fileType, String filePath, String fileOriginalName) {
		super();
		this.id = id;
		this.writer = writer;
		this.title = title;
		this.writedate = writedate;
		this.content = content;
		this.readCount = readCount;
		this.fileName = fileName;
		this.fileType = fileType;
		this.filePath = filePath;
		this.fileOriginalName = fileOriginalName;
	}

	public BboardVo() {	}

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
	public Timestamp getWritedate() {
		return writedate;
	}
	public void setWritedate(Timestamp writedate) {
		this.writedate = writedate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getFileOriginalName() {
		return fileOriginalName;
	}

	public void setFileOriginalName(String fileOriginalName) {
		this.fileOriginalName = fileOriginalName;
	}
	
}
