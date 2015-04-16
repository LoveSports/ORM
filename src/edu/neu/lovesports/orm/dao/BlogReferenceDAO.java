package edu.neu.lovesports.orm.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import edu.neu.lovesports.orm.models.BlogReferenceId;
import edu.neu.lovesports.orm.models.Category;
import edu.neu.lovesports.orm.models.BlogReference;
import edu.neu.lovesports.orm.models.Blog;

public class BlogReferenceDAO {
	EntityManagerFactory factory = Persistence
			.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();

	// crud
	// create
	public BlogReference create(Blog blog, Category category) {
		BlogReference blogRef = new BlogReference(blog, category);
		em.getTransaction().begin();
		em.persist(blogRef);
		em.getTransaction().commit();
		return blogRef;
	}

	// delete
	public void delete(Blog blog, Category category) {
		int blogId = blog.getId();
		int categoryId = category.getId();
		BlogReferenceId id = new BlogReferenceId(blogId, categoryId);
		BlogReference blogRef = em.find(BlogReference.class, id);
		em.getTransaction().begin();
		em.remove(blogRef);
		em.getTransaction().commit();
	}

}
