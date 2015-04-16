package edu.neu.lovesports.orm.models;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
@IdClass(SubscriptionId.class)
public class Subscription {
	@Id
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "username")
	private User user;

	@Id
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "categoryId")
	private Category category;

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Subscription(User user, Category category) {
		super();
		this.user = user;
		this.category = category;
	}

	public Subscription() {
		super();
	}
	
}
