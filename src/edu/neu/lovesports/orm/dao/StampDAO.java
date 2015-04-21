package edu.neu.lovesports.orm.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import edu.neu.lovesports.orm.models.Blog;
import edu.neu.lovesports.orm.models.Stamp;
import edu.neu.lovesports.orm.models.StampId;
import edu.neu.lovesports.orm.models.User;

public class StampDAO {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();
	
	//read
	public Stamp read(Blog blog, User user){
		int blogId = blog.getId();
		String username = user.getUsername();
		StampId id = new StampId(blogId, username);
		if(em.find(Stamp.class, id) != null){
			Stamp stamp = em.find(Stamp.class, id);
			em.refresh(stamp);
			return stamp;
		}
		else
			return null;
	}
	
	//create
	public Stamp create(Blog blog, User user){
		Stamp stamp = new Stamp(blog, user);
		em.getTransaction().begin();
		em.persist(stamp);
		em.getTransaction().commit();
		return stamp;
	}
	
	//delete
	public void delete(Blog blog, User user){
		int blogId = blog.getId();
		String username = user.getUsername();
		StampId id = new StampId(blogId, username);
		Stamp stamp = em.find(Stamp.class, id);
		em.getTransaction().begin();
		em.remove(stamp);
		em.getTransaction().commit();
	}
	
}
