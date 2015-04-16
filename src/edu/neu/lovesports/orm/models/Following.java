package edu.neu.lovesports.orm.models;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
@IdClass(FollowingId.class)
public class Following {

	@Id
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "follower")
	private User follower;
	
	@Id
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "followee")
	private User followee;

	public User getFollower() {
		return follower;
	}

	public void setFollower(User follower) {
		this.follower = follower;
	}

	public User getFollowee() {
		return followee;
	}

	public void setFollowee(User followee) {
		this.followee = followee;
	}

	public Following(User follower, User followee) {
		super();
		this.follower = follower;
		this.followee = followee;
	}

	public Following() {
		super();
	}
}
