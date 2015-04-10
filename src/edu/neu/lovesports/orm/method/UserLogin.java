package edu.neu.lovesports.orm.method;

import edu.neu.lovesports.orm.dao.UserDAO;
import edu.neu.lovesports.orm.models.User;


public class UserLogin {
	
	User user = null;
	
	public boolean LoginCheck(String username, String password){
		UserDAO dao = new UserDAO();
		user = dao.read(username);
		if(user!=null)
			if(password.equals(user.getPassword())){
				return true;
			}
		return false;
	}
	
}