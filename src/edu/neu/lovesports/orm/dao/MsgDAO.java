package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.lovesports.orm.models.Msg;
import edu.neu.lovesports.orm.models.User;

public class MsgDAO {
	EntityManagerFactory factory = Persistence.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();
	
	//crud
	
	//create
	public Msg create(Msg msg){
		em.getTransaction().begin();
		em.persist(msg);
		em.getTransaction().commit();
		return msg;
	}
	
	//read
	@SuppressWarnings("unchecked")
	public List<Msg> read(User a, User b){
		Query query = em.createQuery("select msg from Msg msg where (msg.sender = :a and msg.receiver = :b)"
				+" or (msg.sender = :b and msg.receiver = :a)");
		query.setParameter("a", a);
		query.setParameter("b", b);
		return (List<Msg>)query.getResultList();
	}
	

}
