package edu.neu.lovesports.orm.models;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Blog {

	@Id
	private Integer id;
	private String title;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "username")
	private User user;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "groupName")
	private Group group;
	
	@OneToMany(mappedBy = "blog")
	private List<Text> texts;
	
	@OneToMany(mappedBy = "blog")
	private List<BlogReference> blogRefs;
	
	@OneToMany(mappedBy = "blog")
	private List<Comment> comments;
	
	@OneToMany(mappedBy = "blog")
	private List<Img> Imgs;
	
	@OneToMany(mappedBy = "blog")
	private List<Collection> collections;
	
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
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

	public Group getGroup() {
		return group;
	}

	public void setGroup(Group group) {
		this.group = group;
	}

	public List<Text> getTexts() {
		return texts;
	}

	public void setTexts(List<Text> texts) {
		this.texts = texts;
	}

	public List<BlogReference> getBlogRefs() {
		return blogRefs;
	}

	public void setBlogRefs(List<BlogReference> blogRefs) {
		this.blogRefs = blogRefs;
	}

	public List<Comment> getComments() {
		return comments;
	}

	public void setComments(List<Comment> comments) {
		this.comments = comments;
	}

	public List<Img> getImgs() {
		return Imgs;
	}

	public void setImgs(List<Img> imgs) {
		Imgs = imgs;
	}

	public List<Collection> getCollections() {
		return collections;
	}

	public void setCollections(List<Collection> collections) {
		this.collections = collections;
	}

	public Blog(Integer id, String title, User user, Group group) {
		super();
		this.id = id;
		this.title = title;
		this.user = user;
		this.group = group;
	}

	public Blog() {
		super();
	}
	

}
