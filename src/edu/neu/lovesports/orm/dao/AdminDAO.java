package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.lovesports.orm.models.Admin;

public class AdminDAO {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();
	
	//crud
	//createAdmin
	public Admin create(Admin admin){
		em.getTransaction().begin();
		em.persist(admin);
		em.getTransaction().commit();
		return admin;
	}
	
	//readAdminById
	public Admin read(String username){
		return em.find(Admin.class, username);
	}
	
	//readAllAdmin
	@SuppressWarnings("unchecked")
	public List<Admin> readAll(){
		Query query = em.createQuery("select admin from Admin admin");
		return (List<Admin>)query.getResultList();
	}
	
	//updateAdmin
	public Admin update(Admin admin){
		em.getTransaction().begin();
		em.merge(admin);
		em.getTransaction().commit();
		return admin;
	}
	
	//deleteAdmin
	public void delete(String adminname){
		em.getTransaction().begin();
		Admin admin = em.find(Admin.class, adminname);
		em.remove(admin);
		em.getTransaction().commit();
	}
	
}
