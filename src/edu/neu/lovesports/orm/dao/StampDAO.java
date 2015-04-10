package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.lovesports.orm.models.Stamp;

public class StampDAO {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();
	
	//crud
	//create
	public Stamp create(Stamp stamp){
		em.getTransaction().begin();
		em.persist(stamp);
		em.getTransaction().commit();
		return stamp;
	}
	
	//read
	public Stamp read(int id){
		return em.find(Stamp.class, id);
	}
	
	//read
	@SuppressWarnings("unchecked")
	public List<Stamp> readAll(){
		Query query = em.createQuery("select stamp from Stamp stamp");
		return (List<Stamp>)query.getResultList();
	}
	
	//update
	public Stamp update(Stamp stamp){
		em.getTransaction().begin();
		em.merge(stamp);
		em.getTransaction().commit();
		return stamp;
	}
	
	//delete
	public void delete(int id){
		em.getTransaction().begin();
		Stamp stamp = em.find(Stamp.class, id);
		em.remove(stamp);
		em.getTransaction().commit();
	}
	
}
