package edu.neu.lovesports.orm.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
public class Blog {

	@Id
	private Integer id;
	private String title;
	private String text;
	private int present;
	@Temporal(TemporalType.TIMESTAMP)
	private Date createDate;
	@Temporal(TemporalType.TIMESTAMP)
	private Date modifyDate;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "username")
	private User user;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "groupName")
	private Group group;
	
	@OneToMany(mappedBy = "blog")
	private List<BlogReference> blogRefs;
	
	@OneToMany(mappedBy = "blog")
	private List<Comment> comments;
	
	@OneToMany(mappedBy = "blog")
	private List<Stamp> stamps;
	
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

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}
	
	public int getPresent() {
		return present;
	}

	public void setPresent(int present) {
		this.present = present;
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

	public List<Collection> getCollections() {
		return collections;
	}

	public void setCollections(List<Collection> collections) {
		this.collections = collections;
	}

	public List<Stamp> getStamps() {
		return stamps;
	}

	public void setStamps(List<Stamp> stamps) {
		this.stamps = stamps;
	}

	public Blog(Integer id, String title, String text, Date createDate,
			Date modifyDate, User user, Group group) {
		super();
		this.id = id;
		this.title = title;
		this.text = text;
		this.createDate = createDate;
		this.modifyDate = modifyDate;
		this.user = user;
		this.group = group;
		this.present = 1;
	}

	public Blog() {
		super();
	}
}
