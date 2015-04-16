package edu.neu.lovesports.orm.models;

import java.io.Serializable;

import javax.persistence.Embeddable;

@Embeddable
public class BlogReferenceId implements Serializable{
	private static final long serialVersionUID = -6638670791599217782L;
	int blog;
	int category;
	public int getBlog() {
		return blog;
	}
	public void setBlog(int blog) {
		this.blog = blog;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public BlogReferenceId(int blog, int category) {
		super();
		this.blog = blog;
		this.category = category;
	}
	public BlogReferenceId() {
		super();
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + blog;
		result = prime * result + category;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		BlogReferenceId other = (BlogReferenceId) obj;
		if (blog != other.blog)
			return false;
		if (category != other.category)
			return false;
		return true;
	}
	
}

