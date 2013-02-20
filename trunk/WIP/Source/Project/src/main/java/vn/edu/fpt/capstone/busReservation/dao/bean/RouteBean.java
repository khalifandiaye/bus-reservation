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
    private static final long serialVersionUID = 1L;
    private String name;
	private String status;
	private List<RouteDetailsBean> routeDetails;
	private List<BusBean> assignedForwardBuses;
	private List<BusBean> assignedReturnBuses;
	private RouteTerminalBean routeTerminal;
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
	 * @return the assignedForwardBuses
	 */
	public List<BusBean> getAssignedForwardBuses() {
	    return assignedForwardBuses;
	}
	/**
	 * @param assignedForwardBuses the assignedForwardBuses to set
	 */
	public void setAssignedForwardBuses(List<BusBean> assignedForwardBuses) {
	    this.assignedForwardBuses = assignedForwardBuses;
	}
	/**
	 * @return the assignedReturnBuses
	 */
	public List<BusBean> getAssignedReturnBuses() {
	    return assignedReturnBuses;
	}
	/**
	 * @param assignedReturnBuses the assignedReturnBuses to set
	 */
	public void setAssignedReturnBuses(List<BusBean> assignedReturnBuses) {
	    this.assignedReturnBuses = assignedReturnBuses;
	}
    /**
     * @return the routeTerminal
     */
    public RouteTerminalBean getRouteTerminal() {
        return routeTerminal;
    }
    /**
     * @param routeTerminal the routeTerminal to set
     */
    public void setRouteTerminal(RouteTerminalBean routeTerminal) {
        this.routeTerminal = routeTerminal;
    }
}
