package edu.neu.lovesports.orm.models;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
@IdClass(BlogReferenceId.class)
public class BlogReference {
	@Id
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "blogId")
	private Blog blog;
	
	@Id
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "categoryId")
	private Category category;

	public Blog getBlog() {
		return blog;
	}

	public void setBlog(Blog blog) {
		this.blog = blog;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public BlogReference( Blog blog, Category category) {
		super();
		this.blog = blog;
		this.category = category;
	}

	public BlogReference() {
		super();
	}
}
