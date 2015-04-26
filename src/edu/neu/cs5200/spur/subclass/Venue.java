package edu.neu.cs5200.spur.subclass;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


@JsonIgnoreProperties(ignoreUnknown=true)
public class Venue {
	private String id;
	private String name;
	private long capacity;
	private String address;
	private String city;
	private String state;
	private String zip;
	private String country;
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
	public long getCapacity() {
		return capacity;
	}
	public void setCapacity(long capacity) {
		this.capacity = capacity;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public Venue(String id, String name, long capacity, String address,
			String city, String state, String zip, String country) {
		super();
		this.id = id;
		this.name = name;
		this.capacity = capacity;
		this.address = address;
		this.city = city;
		this.state = state;
		this.zip = zip;
		this.country = country;
	}
	public Venue() {
		super();
	}
	@Override
	public String toString() {
		return "Venue [id=" + id + ", name=" + name + ", capacity=" + capacity
				+ ", address=" + address + ", city=" + city + ", state="
				+ state + ", zip=" + zip + ", country=" + country + "]";
	}
}
