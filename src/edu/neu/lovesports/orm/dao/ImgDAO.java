package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.lovesports.orm.models.Img;

public class ImgDAO {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();
	
	//crud
	//create
	public Img create(Img img){
		em.getTransaction().begin();
		em.persist(img);
		em.getTransaction().commit();
		return img;
	}
	
	//read
	public Img read(int id){
		return em.find(Img.class, id);
	}
	
	//read
	@SuppressWarnings("unchecked")
	public List<Img> readAll(){
		Query query = em.createQuery("select img from Img img");
		return (List<Img>)query.getResultList();
	}
	
	//update
	public Img update(Img img){
		em.getTransaction().begin();
		em.merge(img);
		em.getTransaction().commit();
		return img;
	}
	
	//delete
	public void delete(int id){
		em.getTransaction().begin();
		Img img = em.find(Img.class, id);
		em.remove(img);
		em.getTransaction().commit();
	}
	
}
