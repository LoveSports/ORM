package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import edu.neu.lovesports.orm.models.Following;
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
		User user = em.find(User.class, username);
		if (user == null) return null;
		em.refresh(user);
		return user;
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
	
	public static void main(String arg[])
	{
		UserDAO dao = new UserDAO();
		User david = dao.read("david@qq.com");
		User bob = dao.read("bob@gmail.com");
		User alice = dao.read("alice@gmail.com");
		
//		Following flw = new Following(david, bob);
		
		List<Following> followings = alice.getFollowers();
		for (Following f : followings)
		{
			System.out.println(f.getFollower().getUsername());
		}
	}
}
