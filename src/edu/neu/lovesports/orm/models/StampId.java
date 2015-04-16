package edu.neu.lovesports.orm.models;

import java.io.Serializable;

import javax.persistence.Embeddable;

@Embeddable
public class StampId implements Serializable{
	private static final long serialVersionUID = 3251003656738729023L;
	
	int blog;
	String user;
	public int getBlog() {
		return blog;
	}
	public void setBlog(int blog) {
		this.blog = blog;
	}
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public StampId(int blog, String user) {
		super();
		this.blog = blog;
		this.user = user;
	}
	public StampId() {
		super();
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + blog;
		result = prime * result + ((user == null) ? 0 : user.hashCode());
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
		StampId other = (StampId) obj;
		if (blog != other.blog)
			return false;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		return true;
	}
	
}

