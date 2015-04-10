package edu.neu.lovesports.orm.method;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.neu.lovesports.orm.dao.TokenDAO;
import edu.neu.lovesports.orm.models.Token;

public class HandleCookie extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7550238071027113820L;

	public void setCookie(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException,
			NoSuchAlgorithmException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		Random rand = new Random();
		String n = Integer.toString(rand.nextInt(500));
		String pretoken = n + password;
		byte[] pretokenByte = pretoken.getBytes("UTF-8");
		MessageDigest md = MessageDigest.getInstance("MD5");
		String token = md.digest(pretokenByte).toString();
		TokenDAO dao = new TokenDAO();
		Token t = new Token(username, token);
		if(dao.read(username)==null)
			dao.create(t);
		else
			dao.update(t);
		Cookie usernameCookie = new Cookie("username", username);
		Cookie tokenCookie = new Cookie("token", token);
		usernameCookie.setMaxAge(60 * 60 * 24);
		usernameCookie.setHttpOnly(true);
		tokenCookie.setMaxAge(60 * 60 * 24);
		tokenCookie.setHttpOnly(true);
		response.addCookie(usernameCookie);
		response.addCookie(tokenCookie);
	}

	public boolean checkCookie(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		Cookie[] cookies = request.getCookies();
		String username = null;
		String token = null;
		response.setContentType("text/html");
		PrintWriter pw = response.getWriter();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("username"))
					username = cookie.getValue();
				if (cookie.getName().equals("token"))
					token = cookie.getValue();
			}
			TokenDAO dao = new TokenDAO();
			if ((username != null) && (token != null)) {
				if (token.equals(dao.read(username).getContent()))
					return true;
				else
					pw.println("Not matched user");
			} else
				pw.println("No uername or token");
		} else
			pw.println("Null cookies");

		pw.close();
		return false;
	}
	
	
	public String getUsername(HttpServletRequest request,
			HttpServletResponse response) {
		Cookie[] cookies = request.getCookies();
		String username = null;
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if (cookie.getName().equals("username"))
					return username = cookie.getValue();
			}
		}
		return username;
	}
}
