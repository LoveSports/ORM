package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.lovesports.orm.models.Comment;

public class CommentDAO {
	
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();
	
	//crud
	//create
	public Comment create(Comment comment){
		em.getTransaction().begin();
		em.persist(comment);
		em.getTransaction().commit();
		return comment;
	}
	
	//read
	public Comment read(int id){
		return em.find(Comment.class, id);
	}
	
	//readByNews
	@SuppressWarnings("unchecked")
	public List<Comment> readByNews(String url){
		Query query = em.createQuery("select comment from Comment comment where comment.news = :url");
		query.setParameter("url", url);
		return (List<Comment>)query.getResultList();
	}
	
	//readAll
	@SuppressWarnings("unchecked")
	public List<Comment> readAll(){
		Query query = em.createQuery("select comment from Comment comment");
		return (List<Comment>)query.getResultList();
	}
	
	//update
	public Comment update(Comment comment){
		em.getTransaction().begin();
		em.merge(comment);
		em.getTransaction().commit();
		return comment;
	}
	
	//delete
	public void delete(int id){
		em.getTransaction().begin();
		Comment comment = em.find(Comment.class, id);
		em.remove(comment);
		em.getTransaction().commit();
	}
}
