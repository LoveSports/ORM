package edu.neu.lovesports.orm.models;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Category {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Integer id;
	private String title;
	private String description;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "homepage")
	private Homepage homepage;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "editor")
	private User editor;
	
	@OneToMany(mappedBy = "category")
	private List<Subscription> subs;
	
	@OneToMany(mappedBy = "category")
	private List<BlogReference> blogRefs;
	
	@OneToMany(mappedBy = "category")
	private List<Img> Imgs;

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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Homepage getHomepage() {
		return homepage;
	}

	public void setHomepage(Homepage homepage) {
		this.homepage = homepage;
	}

	public User getEditor() {
		return editor;
	}

	public void setEditor(User editor) {
		this.editor = editor;
	}

	public List<Subscription> getSubs() {
		return subs;
	}

	public void setSubs(List<Subscription> subs) {
		this.subs = subs;
	}

	public List<BlogReference> getBlogRefs() {
		return blogRefs;
	}

	public void setBlogRefs(List<BlogReference> blogRefs) {
		this.blogRefs = blogRefs;
	}

	public List<Img> getImgs() {
		return Imgs;
	}

	public void setImgs(List<Img> imgs) {
		Imgs = imgs;
	}

	public Category(Integer id, String title, String description,
			Homepage homepage, User editor) {
		super();
		this.id = id;
		this.title = title;
		this.description = description;
		this.homepage = homepage;
		this.editor = editor;
	}

	public Category() {
		super();
	}
}