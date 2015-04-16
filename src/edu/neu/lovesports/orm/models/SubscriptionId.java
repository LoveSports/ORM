package edu.neu.lovesports.orm.models;

import java.io.Serializable;

import javax.persistence.Embeddable;

@Embeddable
public class SubscriptionId implements Serializable{

	private static final long serialVersionUID = 1L;
	String user;
	int category;
	public String getUser() {
		return user;
	}
	public void setUser(String user) {
		this.user = user;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public SubscriptionId(String user, int category) {
		super();
		this.user = user;
		this.category = category;
	}
	public SubscriptionId() {
		super();
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + category;
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
		SubscriptionId other = (SubscriptionId) obj;
		if (category != other.category)
			return false;
		if (user == null) {
			if (other.user != null)
				return false;
		} else if (!user.equals(other.user))
			return false;
		return true;
	}
}
