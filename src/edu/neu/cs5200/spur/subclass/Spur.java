package edu.neu.cs5200.spur.subclass;



//import edu.neu.cs5200.spur.subclass.Coach;
import edu.neu.cs5200.spur.subclass.Conference;
import edu.neu.cs5200.spur.subclass.Division;
import edu.neu.cs5200.spur.subclass.League;
//import edu.neu.cs5200.spur.subclass.Player;
import edu.neu.cs5200.spur.subclass.Venue;




public class Spur {
	private String id;
	private String name;
	private String alias;
	private String market;
	private String founded;
	private Venue venue;
	private League league;
	private Conference conference;
	private Division division;
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
	public String getMarket() {
		return market;
	}
	public void setMarket(String market) {
		this.market = market;
	}
	public String getFounded() {
		return founded;
	}
	public void setFounded(String founded) {
		this.founded = founded;
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
	public Conference getConference() {
		return conference;
	}
	public void setConference(Conference conference) {
		this.conference = conference;
	}
	public Division getDivision() {
		return division;
	}
	public void setDivision(Division division) {
		this.division = division;
	}
	public Spur(String id, String name, String alias, String market,
			String founded, Venue venue, League league, Conference conference,
			Division division) {
		super();
		this.id = id;
		this.name = name;
		this.alias = alias;
		this.market = market;
		this.founded = founded;
		this.venue = venue;
		this.league = league;
		this.conference = conference;
		this.division = division;
	}
	public Spur() {
		super();
	}
	@Override
	public String toString() {
		return "Spur [id=" + id + ", name=" + name + ", alias=" + alias
				+ ", market=" + market + ", founded=" + founded + ", venue="
				+ venue + ", league=" + league + ", conference=" + conference
				+ ", division=" + division + "]";
	}
	
	

}
