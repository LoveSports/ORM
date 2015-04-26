package edu.neu.cs5200.spur.subclass;

public class Home {
	private String name;
	private String alias;
	private String id;
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
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Home(String name, String alias, String id) {
		super();
		this.name = name;
		this.alias = alias;
		this.id = id;
	}
	public Home() {
		super();
	}
	
}
