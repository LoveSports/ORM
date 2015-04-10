package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.lovesports.orm.models.Homepage;

public class HomepageDAO {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();
	
	//crud
	//create
	public Homepage create(Homepage homepage){
		em.getTransaction().begin();
		em.persist(homepage);
		em.getTransaction().commit();
		return homepage;
	}
	
	//read
	public Homepage read(int id){
		return em.find(Homepage.class, id);
	}
	
	//read
	@SuppressWarnings("unchecked")
	public List<Homepage> readAll(){
		Query query = em.createQuery("select homepage from Homepage homepage");
		return (List<Homepage>)query.getResultList();
	}
	
	//update
	public Homepage update(Homepage homepage){
		em.getTransaction().begin();
		em.merge(homepage);
		em.getTransaction().commit();
		return homepage;
	}
	
	//delete
	public void delete(int id){
		em.getTransaction().begin();
		Homepage homepage = em.find(Homepage.class, id);
		em.remove(homepage);
		em.getTransaction().commit();
	}
}
