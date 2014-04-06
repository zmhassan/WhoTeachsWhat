package com.seneca.model;

import java.io.Serializable;
import javax.persistence.*;


/**
 * The persistent class for the Factor database table.
 * 
 */
@Entity
@NamedQuery(name="Factor.findAll", query="SELECT f FROM Factor f")
public class Factor implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="factor_id")
	private int factorId;

	@Column(name="factor_name")
	private String factorName;

	@Column(name="factor_val")
	private float factorVal;

	public Factor() {
	}

	public int getFactorId() {
		return this.factorId;
	}

	public void setFactorId(int factorId) {
		this.factorId = factorId;
	}

	public String getFactorName() {
		return this.factorName;
	}

	public void setFactorName(String factorName) {
		this.factorName = factorName;
	}

	public float getFactorVal() {
		return this.factorVal;
	}

	public void setFactorVal(float factorVal) {
		this.factorVal = factorVal;
	}

}