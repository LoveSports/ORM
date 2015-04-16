package edu.neu.lovesports.orm.models;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.PrimaryKeyJoinColumn;

@Entity
public class Admin {

	@Id
	String username;
	private String title;
	
	@OneToOne
	@PrimaryKeyJoinColumn
	User user;


	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Admin(String username, String title) {
		super();
		this.username = username;
		this.title = title;
	}

	public Admin() {
		super();
	}
}
