/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.List;


/**
 * @author Yoshimi
 *
 */
public class SegmentBean extends AbstractBean<Integer> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8476937436323359378L;
	private StationBean startAt;
	private StationBean endAt;
	private List<SegmentTravelTimeBean> segmentTravelTimes;
	private List<TariffBean> tariffs;
	private List<RouteDetailsBean> routeDetails;
	/**
	 * @return the startAt
	 */
	public StationBean getStartAt() {
		return startAt;
	}
	/**
	 * @param startAt the startAt to set
	 */
	public void setStartAt(StationBean startAt) {
		this.startAt = startAt;
	}
	/**
	 * @return the endAt
	 */
	public StationBean getEndAt() {
		return endAt;
	}
	/**
	 * @param endAt the endAt to set
	 */
	public void setEndAt(StationBean endAt) {
		this.endAt = endAt;
	}
	/**
     * @return the segmentTravelTimes
     */
    public List<SegmentTravelTimeBean> getSegmentTravelTimes() {
        return segmentTravelTimes;
    }
    /**
     * @param segmentTravelTimes the segmentTravelTimes to set
     */
    public void setSegmentTravelTimes(List<SegmentTravelTimeBean> segmentTravelTimes) {
        this.segmentTravelTimes = segmentTravelTimes;
    }
    /**
	 * @return the tariffs
	 */
	public List<TariffBean> getTariffs() {
	    return tariffs;
	}
	/**
	 * @param tariffs the tariffs to set
	 */
	public void setTariffs(List<TariffBean> tariffs) {
	    this.tariffs = tariffs;
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
}
