package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.lovesports.orm.models.User;

public class UserDAO {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();
	
	//crud
	//createUser
	public User create(User user){
		em.getTransaction().begin();
		em.persist(user);
		em.getTransaction().commit();
		return user;
	}
	
	//readUserById
	public User read(String username){
		return em.find(User.class, username);
	}
	
	//readAllUser
	@SuppressWarnings("unchecked")
	public List<User> readAll(){
		Query query = em.createQuery("select user from User user");
		return (List<User>)query.getResultList();
	}
	
	//updateUser
	public User update(User user){
		em.getTransaction().begin();
		em.merge(user);
		em.getTransaction().commit();
		return user;
	}
	
	//deleteUser
	public void delete(String username){
		em.getTransaction().begin();
		User user = em.find(User.class, username);
		em.remove(user);
		em.getTransaction().commit();
	}
	
}
