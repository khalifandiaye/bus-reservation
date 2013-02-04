/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.List;


/**
 * @author Yoshimi
 * 
 */
public class StationBean extends AbstractBean<Integer> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -6213565429368774910L;
	private String name;
	private CityBean city;
	private String address;
	private String status;
	private List<SegmentBean> inSegments;
	private List<SegmentBean> outSegments;
	/**
	 * @return the name
	 */
	public String getName() {
	    return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
	    this.name = name;
	}
	/**
	 * @return the city
	 */
	public CityBean getCity() {
	    return city;
	}
	/**
	 * @param city the city to set
	 */
	public void setCity(CityBean city) {
	    this.city = city;
	}
	/**
	 * @return the address
	 */
	public String getAddress() {
	    return address;
	}
	/**
	 * @param address the address to set
	 */
	public void setAddress(String address) {
	    this.address = address;
	}
	/**
	 * @return the status
	 */
	public String getStatus() {
	    return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(String status) {
	    this.status = status;
	}
	/**
	 * @return the inSegments
	 */
	public List<SegmentBean> getInSegments() {
	    return inSegments;
	}
	/**
	 * @param inSegments the inSegments to set
	 */
	public void setInSegments(List<SegmentBean> inSegments) {
	    this.inSegments = inSegments;
	}
	/**
	 * @return the outSegments
	 */
	public List<SegmentBean> getOutSegments() {
	    return outSegments;
	}
	/**
	 * @param outSegments the outSegments to set
	 */
	public void setOutSegments(List<SegmentBean> outSegments) {
	    this.outSegments = outSegments;
	}
}
