/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.io.Serializable;

/**
 * @author Yoshimi
 *
 */
public abstract class AbstractBean<K extends Serializable> implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private K id;
	/**
	 * @return the id
	 */
	public K getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(K id) {
		this.id = id;
	}
	
}
