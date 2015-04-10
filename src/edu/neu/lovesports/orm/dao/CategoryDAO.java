package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.lovesports.orm.models.Category;

public class CategoryDAO {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();
	
	//crud
	//create
	public Category create(Category category){
		em.getTransaction().begin();
		em.persist(category);
		em.getTransaction().commit();
		return category;
	}
	
	//read
	public Category read(int id){
		return em.find(Category.class, id);
	}
	
	//read
	@SuppressWarnings("unchecked")
	public List<Category> readAll(){
		Query query = em.createQuery("select category from Category category");
		return (List<Category>)query.getResultList();
	}
	
	//update
	public Category update(Category category){
		em.getTransaction().begin();
		em.merge(category);
		em.getTransaction().commit();
		return category;
	}
	
	//delete
	public void delete(int id){
		em.getTransaction().begin();
		Category category = em.find(Category.class, id);
		em.remove(category);
		em.getTransaction().commit();
	}
	
}
