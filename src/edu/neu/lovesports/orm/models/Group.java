package edu.neu.lovesports.orm.models;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "\"GROUP\"")
public class Group {

	@Id
	private String name;
	private String description;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "username")
	private User user;
	
	@OneToMany(mappedBy = "group")
	private List<Blog> blogs;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public List<Blog> getBlogs() {
		return blogs;
	}

	public void setBlogs(List<Blog> blogs) {
		this.blogs = blogs;
	}

	public Group(String name, String description, User user) {
		super();
		this.name = name;
		this.description = description;
		this.user = user;
	}

	public Group() {
		super();
	}


}
