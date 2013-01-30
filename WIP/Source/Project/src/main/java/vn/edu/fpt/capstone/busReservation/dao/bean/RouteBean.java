/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.List;

/**
 * @author Yoshimi
 *
 */
public class RouteBean extends AbstractBean<Integer> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 248904229492636837L;
	private String name;
	private List<RouteDetailsBean> routeDetails;
	private String status;
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
	 * @return the routeDetails
	 */
	public List<RouteDetailsBean> getRouteDetails() {
		return routeDetails;
	}
	/**
	 * @param routeDetails the routeDetails to set
	 */
	public void setRouteDetails(List<RouteDetailsBean> routeDetails) {
		this.routeDetails = routeDetails;
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
}
