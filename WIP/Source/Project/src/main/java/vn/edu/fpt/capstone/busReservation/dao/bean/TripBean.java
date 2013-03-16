/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.Date;
import java.util.List;

/**
 * @author Yoshimi
 *
 */
public class TripBean extends AbstractBean<Integer> {
	/**
     * 
     */
    private static final long serialVersionUID = 1L;
    private BusStatusBean busStatus;
	private RouteDetailsBean routeDetails;
	private Date departureTime;
	private Date arrivalTime;
	private List<TicketBean> tickets;
	/**
	 * @return the busStatus
	 */
	public BusStatusBean getBusStatus() {
		return busStatus;
	}
	/**
	 * @param busStatus the busStatus to set
	 */
	public void setBusStatus(BusStatusBean busStatus) {
		this.busStatus = busStatus;
	}
	/**
	 * @return the routeDetails
	 */
	public RouteDetailsBean getRouteDetails() {
		return routeDetails;
	}
	/**
	 * @param routeDetails the routeDetails to set
	 */
	public void setRouteDetails(RouteDetailsBean routeDetails) {
		this.routeDetails = routeDetails;
	}
	/**
	 * @return the departureTime
	 */
	public Date getDepartureTime() {
		return departureTime;
	}
	/**
	 * @param departureTime the departureTime to set
	 */
	public void setDepartureTime(Date departureTime) {
		this.departureTime = departureTime;
	}
	/**
	 * @return the arrivalTime
	 */
	public Date getArrivalTime() {
		return arrivalTime;
	}
	/**
	 * @param arrivalTime the arrivalTime to set
	 */
	public void setArrivalTime(Date arrivalTime) {
		this.arrivalTime = arrivalTime;
	}
    /**
     * @return the tickets
     */
    public List<TicketBean> getTickets() {
        return tickets;
    }
    /**
     * @param tickets the tickets to set
     */
    public void setTickets(List<TicketBean> tickets) {
        this.tickets = tickets;
    }
}
