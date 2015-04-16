package edu.neu.lovesports.orm.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import edu.neu.lovesports.orm.models.Category;
import edu.neu.lovesports.orm.models.Subscription;
import edu.neu.lovesports.orm.models.SubscriptionId;
import edu.neu.lovesports.orm.models.User;

public class SubscriptionDAO {
	EntityManagerFactory factory = Persistence
			.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();

	// crud
	// create
	public Subscription create(User user, Category category) {
		Subscription sub = new Subscription(user, category);
		em.getTransaction().begin();
		em.persist(sub);
		em.getTransaction().commit();
		return sub;
	}

	// delete
	public void delete(User user, Category category) {
		String username = user.getUsername();
		int categoryId = category.getId();
		SubscriptionId id = new SubscriptionId(username, categoryId);
		Subscription sub = em.find(Subscription.class, id);
		em.getTransaction().begin();
		em.remove(sub);
		em.getTransaction().commit();
	}

}
