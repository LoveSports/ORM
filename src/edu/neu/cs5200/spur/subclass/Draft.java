package edu.neu.cs5200.spur.subclass;

public class Draft {
	private String team_id;
	private long year;
	private String round;
	private String pick;
	public String getTeam_id() {
		return team_id;
	}
	public void setTeam_id(String team_id) {
		this.team_id = team_id;
	}
	public long getYear() {
		return year;
	}
	public void setYear(long year) {
		this.year = year;
	}
	public String getRound() {
		return round;
	}
	public void setRound(String round) {
		this.round = round;
	}
	public String getPick() {
		return pick;
	}
	public void setPick(String pick) {
		this.pick = pick;
	}
	public Draft(String team_id, long year, String round, String pick) {
		super();
		this.team_id = team_id;
		this.year = year;
		this.round = round;
		this.pick = pick;
	}
	public Draft() {
		super();
	}
	@Override
	public String toString() {
		return "Draft [team_id=" + team_id + ", year=" + year + ", round="
				+ round + ", pick=" + pick + "]";
	}
}
