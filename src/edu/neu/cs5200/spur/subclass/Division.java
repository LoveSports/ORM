package edu.neu.cs5200.spur.subclass;

public class Division {
	private String id;
	private String name;
	private String alias;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAlias() {
		return alias;
	}
	public void setAlias(String alias) {
		this.alias = alias;
	}
	public Division(String id, String name, String alias) {
		super();
		this.id = id;
		this.name = name;
		this.alias = alias;
	}
	public Division() {
		super();
	}
	@Override
	public String toString() {
		return "Division [id=" + id + ", name=" + name + ", alias=" + alias
				+ "]";
	}
}
