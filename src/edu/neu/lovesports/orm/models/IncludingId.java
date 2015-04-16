package edu.neu.lovesports.orm.models;

import java.io.Serializable;

import javax.persistence.Embeddable;

@Embeddable
public class IncludingId implements Serializable{

	private static final long serialVersionUID = 5704050292637321908L;
	int host;
	int sub;
	public int getHost() {
		return host;
	}
	public void setHost(int host) {
		this.host = host;
	}
	public int getSub() {
		return sub;
	}
	public void setSub(int sub) {
		this.sub = sub;
	}
	public IncludingId(int host, int sub) {
		super();
		this.host = host;
		this.sub = sub;
	}
	public IncludingId() {
		super();
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + host;
		result = prime * result + sub;
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		IncludingId other = (IncludingId) obj;
		if (host != other.host)
			return false;
		if (sub != other.sub)
			return false;
		return true;
	}
	
}
