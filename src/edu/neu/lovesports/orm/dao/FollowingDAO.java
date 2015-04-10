package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.lovesports.orm.models.User;
import edu.neu.lovesports.orm.models.Following;

public class FollowingDAO {
	EntityManagerFactory factory = Persistence
			.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();

	// crud
	// create
	public Following create(Following following) {
		em.getTransaction().begin();
		em.persist(following);
		em.getTransaction().commit();
		return following;
	}

	// read
	public Following read(int id){
		return em.find(Following.class, id);
	}

	// readAll
	@SuppressWarnings("unchecked")
	public List<Following> readAll() {
		Query query = em
				.createQuery("select followingscription from Following followingscription");
		return (List<Following>) query.getResultList();
	}

	// update
	public Following update(Following following) {

		em.getTransaction().begin();
		em.merge(following);
		em.getTransaction().commit();
		return following;
	}

	// delete
	public void delete(User follower, User followee) {
		Query query = em.createQuery("select following from Following following where following.follower = :follower and following.followee = :followee");
		query.setParameter("follower", follower);
		query.setParameter("followee", followee);
		@SuppressWarnings("unchecked")
		List<Following> followings = (List<Following>)query.getResultList();
		em.getTransaction().begin();
		for (Following following : followings)
			em.remove(following);
		em.getTransaction().commit();
	}

}
