package edu.neu.lovesports.orm.dao;

import java.util.List;

import javax.persistence.*;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import edu.neu.lovesports.orm.models.FollowingId;
import edu.neu.lovesports.orm.models.User;
import edu.neu.lovesports.orm.models.Following;

public class FollowingDAO {
	EntityManagerFactory factory = Persistence
			.createEntityManagerFactory("LoveSportsORM");
	EntityManager em = factory.createEntityManager();

	// crud
	// create
	public Following create(User follower, User followee) {
		Following following = new Following(follower, followee);
		em.getTransaction().begin();
		em.persist(following);
		em.getTransaction().commit();
		return following;
	}

	// delete
	public void delete(User follower, User followee) {
		String flwerName = follower.getUsername();
		String flweeName = followee.getUsername();
		FollowingId id = new FollowingId(flwerName, flweeName);
		Following following = em.find(Following.class, id);
		em.getTransaction().begin();
		em.remove(following);
		em.getTransaction().commit();
	}
	
	// read
	public Following read(FollowingId fId)
	{
		Following following = em.find(Following.class, fId);
		return following;
	}
	
	public static void main(String arg[])
	{
		FollowingDAO dao = new FollowingDAO();
     	UserDAO udao = new UserDAO();
		User u1 = udao.read("david@qq.com");
//		User u2 = udao.read("bob@gmail.com");
////		FollowingId fId = new FollowingId("bob@gmail.com", "Ali@gmail.com");
////		Following f = dao.read(fId);
////		System.out.println(f);
//		Following follow1 = new Following(u1, u2);
//		Following follow2 = new Following(u1, u2);
//		
//		
//		List<Following> fList = u2.getFollowers();
//		System.out.println(follow1.equals(follow2));
//		
//		for(Following following : fList)
//		{
//			System.out.println(following.getFollower().getUsername());
//		}
//		fList.remove(follow1);
//		System.out.println(fList.size());
		
		Query query = dao.em.createQuery("select follow from Follow follow where follow.follower=" + u1.getUsername());
		List<Following> fs = (List<Following>) query.getResultList();
		for (Following f : fs)
		{
			System.out.println(f.getFollower().getUsername());
		}
	}
}
