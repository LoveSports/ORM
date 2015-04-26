package edu.neu.cs5200.spur.subclass;

public class Coach {
	private String id;
	private String full_name;
	private String first_name;
	private String last_name;
	private String position;
	private String experience;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFull_name() {
		return full_name;
	}
	public void setFull_name(String full_name) {
		this.full_name = full_name;
	}
	public String getFirst_name() {
		return first_name;
	}
	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}
	public String getLast_name() {
		return last_name;
	}
	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getExperience() {
		return experience;
	}
	public void setExperience(String experience) {
		this.experience = experience;
	}
	public Coach(String id, String full_name, String first_name,
			String last_name, String position, String experience) {
		super();
		this.id = id;
		this.full_name = full_name;
		this.first_name = first_name;
		this.last_name = last_name;
		this.position = position;
		this.experience = experience;
	}
	public Coach() {
		super();
	}
}
