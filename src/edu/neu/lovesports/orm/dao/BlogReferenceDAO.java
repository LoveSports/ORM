package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.lovesports.orm.models.Category;
import edu.neu.lovesports.orm.models.BlogReference;
import edu.neu.lovesports.orm.models.Blog;

public class BlogReferenceDAO {
	EntityManagerFactory factory = Persistence
			.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();

	// crud
	// create
	public BlogReference create(BlogReference blogRef) {
		em.getTransaction().begin();
		em.persist(blogRef);
		em.getTransaction().commit();
		return blogRef;
	}

	// read
	public BlogReference read(int id){
		return em.find(BlogReference.class, id);
	}

	// readAll
	@SuppressWarnings("unchecked")
	public List<BlogReference> readAll() {
		Query query = em
				.createQuery("select blogRefscription from BlogReference blogRefscription");
		return (List<BlogReference>) query.getResultList();
	}

	// update
	public BlogReference update(BlogReference blogRef) {

		em.getTransaction().begin();
		em.merge(blogRef);
		em.getTransaction().commit();
		return blogRef;
	}

	// delete
	public void delete(Blog blog, Category category) {
		Query query = em.createQuery("select blogRef from BlogReference blogRef where blogRef.blog = :blog and blogRef.category = :category");
		query.setParameter("blog", blog);
		query.setParameter("category", category);
		@SuppressWarnings("unchecked")
		List<BlogReference> blogRefs = (List<BlogReference>)query.getResultList();
		em.getTransaction().begin();
		for (BlogReference blogRef : blogRefs)
			em.remove(blogRef);
		em.getTransaction().commit();
	}

}
