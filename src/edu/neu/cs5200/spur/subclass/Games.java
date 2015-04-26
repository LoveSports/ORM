package edu.neu.cs5200.spur.subclass;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;


@JsonIgnoreProperties(ignoreUnknown=true)
public class Games {
	private String id;
	private String status;
	private String coverage;
	private String scheduled;
	private Venue venue;
	private Broadcast broadcast;
	private Home home;
	private Away away;
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getCoverage() {
		return coverage;
	}
	public void setCoverage(String coverage) {
		this.coverage = coverage;
	}
	public String getScheduled() {
		return scheduled;
	}
	public void setScheduled(String scheduled) {
		this.scheduled = scheduled;
	}
	public Venue getVenue() {
		return venue;
	}
	public void setVenue(Venue venue) {
		this.venue = venue;
	}
	public Broadcast getBroadcast() {
		return broadcast;
	}
	public void setBroadcast(Broadcast broadcast) {
		this.broadcast = broadcast;
	}
	public Home getHome() {
		return home;
	}
	public void setHome(Home home) {
		this.home = home;
	}
	public Away getAway() {
		return away;
	}
	public void setAway(Away away) {
		this.away = away;
	}
	public Games(String id, String status, String coverage, String scheduled,
			Venue venue, Broadcast broadcast, Home home, Away away) {
		super();
		this.id = id;
		this.status = status;
		this.coverage = coverage;
		this.scheduled = scheduled;
		this.venue = venue;
		this.broadcast = broadcast;
		this.home = home;
		this.away = away;
	}
	public Games() {
		super();
	}
	
}
