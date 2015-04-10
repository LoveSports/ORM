package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.lovesports.orm.models.Text;

public class TextDAO {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();
	
	//crud
	//create
	public Text create(Text text){
		em.getTransaction().begin();
		em.persist(text);
		em.getTransaction().commit();
		return text;
	}
	
	//read
	public Text read(int id){
		return em.find(Text.class, id);
	}
	
	//read
	@SuppressWarnings("unchecked")
	public List<Text> readAll(){
		Query query = em.createQuery("select text from Text text");
		return (List<Text>)query.getResultList();
	}
	
	//update
	public Text update(Text text){
		em.getTransaction().begin();
		em.merge(text);
		em.getTransaction().commit();
		return text;
	}
	
	//delete
	public void delete(int id){
		em.getTransaction().begin();
		Text text = em.find(Text.class, id);
		em.remove(text);
		em.getTransaction().commit();
	}
	
}
