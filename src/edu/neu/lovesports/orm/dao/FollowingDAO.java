package edu.neu.lovesports.orm.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import edu.neu.lovesports.orm.models.FollowingId;
import edu.neu.lovesports.orm.models.User;
import edu.neu.lovesports.orm.models.Following;

public class FollowingDAO {
	EntityManagerFactory factory = Persistence
			.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();

	// crud
	// create
	public Following create(User follower, User followee) {
		Following following = new Following(follower, followee);
		em.getTransaction().begin();
		em.persist(following);
		em.getTransaction().commit();
		return following;
	}

	// delete
	public void delete(User follower, User followee) {
		String flwerName = follower.getUsername();
		String flweeName = followee.getUsername();
		FollowingId id = new FollowingId(flwerName, flweeName);
		Following following = em.find(Following.class, id);
		em.getTransaction().begin();
		em.remove(following);
		em.getTransaction().commit();
	}

}
