package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.lovesports.orm.models.Group;

public class GroupDAO {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();
	
	//crud
	//create
	public Group create(Group group){
		em.getTransaction().begin();
		em.persist(group);
		em.getTransaction().commit();
		return group;
	}
	
	//read
	public Group read(String name){
		return em.find(Group.class, name);
	}
	
	//read
	@SuppressWarnings("unchecked")
	public List<Group> readAll(){
		Query query = em.createQuery("select group from Group group");
		return (List<Group>)query.getResultList();
	}
	
	//update
	public Group update(Group group){
		em.getTransaction().begin();
		em.merge(group);
		em.getTransaction().commit();
		return group;
	}
	
	//delete
	public void delete(String name){
		em.getTransaction().begin();
		Group group = em.find(Group.class, name);
		em.remove(group);
		em.getTransaction().commit();
	}
	
}
