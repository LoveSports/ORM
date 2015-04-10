package edu.neu.lovesports.orm.dao;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import edu.neu.lovesports.orm.models.Token;

public class TokenDAO {

	EntityManagerFactory factory = Persistence
			.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();

	// createToken
	public void create(Token token) {
		em.getTransaction().begin();
		em.persist(token);
		em.getTransaction().commit();
	}

	// readToken
	public Token read(String username) {
		return em.find(Token.class, username);
	}

	// updateToken
	public Token update(Token token){
		em.getTransaction().begin();
		em.merge(token);
		em.getTransaction().commit();
		return token;
	}
	
	//deleteToken
	public void delete(String username){
		em.getTransaction().begin();
		Token token = em.find(Token.class, username);
		em.remove(token);
		em.getTransaction().commit();
	}
}
