package edu.neu.lovesports.orm.models;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Token {

	@Id
	private String username;
	private String content;
	

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Token(String username, String content) {
		super();
		this.username = username;
		this.content = content;
	}

	public Token(String username) {
		super();
		this.username = username;
		this.content = null;
	}

	public Token() {
		super();
	}

	
}
