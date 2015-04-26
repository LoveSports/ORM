package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.lovesports.orm.models.Blog;
import edu.neu.lovesports.orm.models.Collection;
import edu.neu.lovesports.orm.models.Stamp;
import edu.neu.lovesports.orm.models.StampId;
import edu.neu.lovesports.orm.models.User;

public class CollectionDAO {
	EntityManagerFactory factory = Persistence
			.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();

	// crud
	// create
	public Collection create(Collection collection) {
		em.getTransaction().begin();
		em.persist(collection);
		em.getTransaction().commit();
		return collection;
	}

	// read
	public Collection read(Blog blog, User user) {
		List<Collection> collections = user.getCollections();
		Collection collection = null;
		for (Collection c : collections) {
			if (c.getBlog().getId().compareTo(blog.getId()) == 0) {
				collection = c;
				break;
			}
		}
		return collection;

	}

	// readAll
	@SuppressWarnings("unchecked")
	public List<Collection> readAll() {
		Query query = em
				.createQuery("select collectionscription from Collection collectionscription");
		return (List<Collection>) query.getResultList();
	}

	// update
	public Collection update(Collection collection) {

		em.getTransaction().begin();
		em.merge(collection);
		em.getTransaction().commit();
		return collection;
	}

	// delete
	public void delete(User user, Blog blog) {
		Query query = em
				.createQuery("select collection from Collection collection where collection.user = :user and collection.blog = :blog");
		query.setParameter("user", user);
		query.setParameter("blog", blog);
		@SuppressWarnings("unchecked")
		List<Collection> collections = (List<Collection>) query.getResultList();
		em.getTransaction().begin();
		for (Collection collection : collections)
			em.remove(collection);
		em.getTransaction().commit();
	}

}
