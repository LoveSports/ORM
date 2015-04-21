package edu.neu.lovesports.orm.api;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import edu.neu.lovesports.orm.dao.UserDAO;
import edu.neu.lovesports.orm.models.User;

@Path("/user")
public class Api {

	@Path("/")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public List<User> getAllUser(){
		UserDAO dao = new UserDAO();
			return dao.readAll();
	}
}
