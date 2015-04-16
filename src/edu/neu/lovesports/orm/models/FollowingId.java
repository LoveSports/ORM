package edu.neu.lovesports.orm.models;

import java.io.Serializable;

import javax.persistence.Embeddable;
@Embeddable
public class FollowingId implements Serializable{

	private static final long serialVersionUID = 1L;
	String follower;
	String followee;
	public String getFollower() {
		return follower;
	}
	public void setFollower(String follower) {
		this.follower = follower;
	}
	public String getFollowee() {
		return followee;
	}
	public void setFollowee(String followee) {
		this.followee = followee;
	}
	public FollowingId(String follower, String followee) {
		super();
		this.follower = follower;
		this.followee = followee;
	}
	public FollowingId() {
		super();
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result
				+ ((followee == null) ? 0 : followee.hashCode());
		result = prime * result
				+ ((follower == null) ? 0 : follower.hashCode());
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
		FollowingId other = (FollowingId) obj;
		if (followee == null) {
			if (other.followee != null)
				return false;
		} else if (!followee.equals(other.followee))
			return false;
		if (follower == null) {
			if (other.follower != null)
				return false;
		} else if (!follower.equals(other.follower))
			return false;
		return true;
	}
	
}
