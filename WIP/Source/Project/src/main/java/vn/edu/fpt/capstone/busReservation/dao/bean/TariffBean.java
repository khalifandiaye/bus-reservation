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
	private SegmentInRouteBean segmentInRoute;
	private Date validFrom;
	private double fare;
	/**
	 * @return the segmentInRoute
	 */
	public SegmentInRouteBean getSegmentInRoute() {
		return segmentInRoute;
	}
	/**
	 * @param segmentInRoute the segmentInRoute to set
	 */
	public void setSegmentInRoute(SegmentInRouteBean segmentInRoute) {
		this.segmentInRoute = segmentInRoute;
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
