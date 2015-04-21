package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.lovesports.orm.models.Blog;
import edu.neu.lovesports.orm.models.User;

public class BlogDAO {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();
	
	//crud
	//create
	public Blog create(Blog blog){
		em.getTransaction().begin();
		em.persist(blog);
		em.getTransaction().commit();
		UserDAO dao = new UserDAO();
		User user = dao.read(blog.getUser().getUsername());
		int size = user.getBlogs().size();
		Blog newBlog = user.getBlogs().get(size-1);
		return newBlog;
	}
	
	//read
	public Blog read(int id){
		Blog blog = em.find(Blog.class, id);
		em.refresh(blog);
		return blog;
	}
	
	//read
	@SuppressWarnings("unchecked")
	public List<Blog> readAll(){
		Query query = em.createQuery("select blog from Blog blog");
		return (List<Blog>)query.getResultList();
	}
	
	//update
	public Blog update(Blog blog){
		em.getTransaction().begin();
		em.merge(blog);
		em.getTransaction().commit();
		return blog;
	}
	
	//delete
	public void delete(int id){
		em.getTransaction().begin();
		Blog blog = em.find(Blog.class, id);
		em.remove(blog);
		em.getTransaction().commit();
	}
	
}
