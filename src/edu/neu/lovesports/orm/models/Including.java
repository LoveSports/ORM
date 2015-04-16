package edu.neu.lovesports.orm.models;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;

@Entity
@IdClass(IncludingId.class)
public class Including {

	@Id
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "hostId")
	private Category host;
	
	@Id
	@OneToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "subId")
	private Category sub;

	public Category getHost() {
		return host;
	}

	public void setHost(Category host) {
		this.host = host;
	}

	public Category getSub() {
		return sub;
	}

	public void setSub(Category sub) {
		this.sub = sub;
	}

	public Including(Category host, Category sub) {
		super();
		this.host = host;
		this.sub = sub;
	}

	public Including() {
		super();
	}
	
}
