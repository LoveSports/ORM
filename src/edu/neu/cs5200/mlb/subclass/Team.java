package edu.neu.cs5200.mlb.subclass;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

import edu.neu.cs5200.spur.subclass.League;
import edu.neu.cs5200.spur.subclass.Venue;

@JsonIgnoreProperties(ignoreUnknown=true)
public class Team {
	private String name;
	private String abbr;
	private String market;
	private String id;
	private Venue venue;
	private League league;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getAbbr() {
		return abbr;
	}
	public void setAbbr(String abbr) {
		this.abbr = abbr;
	}
	public String getMarket() {
		return market;
	}
	public void setMarket(String market) {
		this.market = market;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Venue getVenue() {
		return venue;
	}
	public void setVenue(Venue venue) {
		this.venue = venue;
	}
	public League getLeague() {
		return league;
	}
	public void setLeague(League league) {
		this.league = league;
	}
	public Team(String name, String abbr, String market, String id,
			Venue venue, League league) {
		super();
		this.name = name;
		this.abbr = abbr;
		this.market = market;
		this.id = id;
		this.venue = venue;
		this.league = league;
	}
	public Team() {
		super();
	}
	
}
