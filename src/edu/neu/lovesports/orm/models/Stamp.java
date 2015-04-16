package edu.neu.lovesports.orm.models;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
@IdClass(StampId.class)
public class Stamp {
	@Id
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "username")
	private User user;
	
	@Id
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "blogId")
	private Blog blog;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Blog getBlog() {
		return blog;
	}

	public void setBlog(Blog blog) {
		this.blog = blog;
	}

	public Stamp(Blog blog, User user) {
		super();
		this.user = user;
		this.blog = blog;
	}

	public Stamp() {
		super();
	}
}