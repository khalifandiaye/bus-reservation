/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.Date;

/**
 * @author Yoshimi
 *
 */
public class TariffBean extends AbstractBean<Integer> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 9170351175544644640L;
	private RouteDetailsBean routeDetails;
	private BusTypeBean busType;
	private Date validFrom;
	private double fare;
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
	 * @return the busType
	 */
	public BusTypeBean getBusType() {
		return busType;
	}
	/**
	 * @param busType the busType to set
	 */
	public void setBusType(BusTypeBean busType) {
		this.busType = busType;
	}
	/**
	 * @return the validFrom
	 */
	public Date getValidFrom() {
		return validFrom;
	}
	/**
	 * @param validFrom the validFrom to set
	 */
	public void setValidFrom(Date validFrom) {
		this.validFrom = validFrom;
	}
	/**
	 * @return the fare
	 */
	public double getFare() {
		return fare;
	}
	/**
	 * @param fare the fare to set
	 */
	public void setFare(double fare) {
		this.fare = fare;
	}
}
