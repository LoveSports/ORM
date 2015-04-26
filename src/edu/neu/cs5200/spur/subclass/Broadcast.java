package edu.neu.cs5200.spur.subclass;

public class Broadcast {
	private String network;
	private String satellite;
	public String getNetwork() {
		return network;
	}
	public void setNetwork(String network) {
		this.network = network;
	}
	public String getSatellite() {
		return satellite;
	}
	public void setSatellite(String satellite) {
		this.satellite = satellite;
	}
	public Broadcast(String network, String satellite) {
		super();
		this.network = network;
		this.satellite = satellite;
	}
	public Broadcast() {
		super();
	}
	
}
