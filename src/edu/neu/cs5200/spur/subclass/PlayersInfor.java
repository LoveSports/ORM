package edu.neu.cs5200.spur.subclass;

public class PlayersInfor {
	private String id;
	private String status;
	private String full_name;
	private String first_name;
	private String abbr_name;
	private float height;
	private float weight;
	private String position;
	private String primary_position;
	private String jersey_number;
	private String experience;
	private String college;
	private String birth_place;
	private String birthdate;
	private String updated;
	private Draft draft;
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
	public String getAbbr_name() {
		return abbr_name;
	}
	public void setAbbr_name(String abbr_name) {
		this.abbr_name = abbr_name;
	}
	public float getHeight() {
		return height;
	}
	public void setHeight(float height) {
		this.height = height;
	}
	public float getWeight() {
		return weight;
	}
	public void setWeight(float weight) {
		this.weight = weight;
	}
	public String getPosition() {
		return position;
	}
	public void setPosition(String position) {
		this.position = position;
	}
	public String getPrimary_position() {
		return primary_position;
	}
	public void setPrimary_position(String primary_position) {
		this.primary_position = primary_position;
	}
	public String getJersey_number() {
		return jersey_number;
	}
	public void setJersey_number(String jersey_number) {
		this.jersey_number = jersey_number;
	}
	public String getExperience() {
		return experience;
	}
	public void setExperience(String experience) {
		this.experience = experience;
	}
	public String getCollege() {
		return college;
	}
	public void setCollege(String college) {
		this.college = college;
	}
	public String getBirth_place() {
		return birth_place;
	}
	public void setBirth_place(String birth_place) {
		this.birth_place = birth_place;
	}
	public String getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(String birthdate) {
		this.birthdate = birthdate;
	}
	public String getUpdated() {
		return updated;
	}
	public void setUpdated(String updated) {
		this.updated = updated;
	}
	public Draft getDraft() {
		return draft;
	}
	public void setDraft(Draft draft) {
		this.draft = draft;
	}
	public PlayersInfor(String id, String status, String full_name,
			String first_name, String abbr_name, float height, float weight,
			String position, String primary_position, String jersey_number,
			String experience, String college, String birth_place,
			String birthdate, String updated, Draft draft) {
		super();
		this.id = id;
		this.status = status;
		this.full_name = full_name;
		this.first_name = first_name;
		this.abbr_name = abbr_name;
		this.height = height;
		this.weight = weight;
		this.position = position;
		this.primary_position = primary_position;
		this.jersey_number = jersey_number;
		this.experience = experience;
		this.college = college;
		this.birth_place = birth_place;
		this.birthdate = birthdate;
		this.updated = updated;
		this.draft = draft;
	}
	public PlayersInfor() {
		super();
	}
	@Override
	public String toString() {
		return "PlayersInfor [id=" + id + ", status=" + status + ", full_name="
				+ full_name + ", first_name=" + first_name + ", abbr_name="
				+ abbr_name + ", height=" + height + ", weight=" + weight
				+ ", position=" + position + ", primary_position="
				+ primary_position + ", jersey_number=" + jersey_number
				+ ", experience=" + experience + ", college=" + college
				+ ", birth_place=" + birth_place + ", birthdate=" + birthdate
				+ ", updated=" + updated + "]";
	}
}
