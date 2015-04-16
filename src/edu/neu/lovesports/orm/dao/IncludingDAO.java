package edu.neu.lovesports.orm.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import edu.neu.lovesports.orm.models.Category;
import edu.neu.lovesports.orm.models.Including;
import edu.neu.lovesports.orm.models.IncludingId;

public class IncludingDAO {

	EntityManagerFactory factory = Persistence.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();
	
	//create
	public Including create(Category host, Category sub){
		Including including = new Including(host, sub);
		em.getTransaction().begin();
		em.persist(including);
		em.getTransaction().commit();
		return including;
	}
	
	//delete
	public void delete(Category host, Category sub){
		int hostId = host.getId();
		int subId =  sub.getId();
		IncludingId id = new IncludingId(hostId, subId);
		Including including = em.find(Including.class, id);
		em.getTransaction().begin();
		em.remove(including);
		em.getTransaction().commit();
	}
}
