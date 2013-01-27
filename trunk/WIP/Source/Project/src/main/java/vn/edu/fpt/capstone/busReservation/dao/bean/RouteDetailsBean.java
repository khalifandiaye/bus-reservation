/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.List;

/**
 * @author Yoshimi
 *
 */
public class RouteDetailsBean extends AbstractBean<Integer> {
	/**
	 * 
	 */
	private static final long serialVersionUID = -370430165090983593L;
	private SegmentBean segment;
	private RouteBean route;
	private List<TariffBean> tariffs;
	/**
	 * @return the segment
	 */
	public SegmentBean getSegment() {
		return segment;
	}
	/**
	 * @param segment the segment to set
	 */
	public void setSegment(SegmentBean segment) {
		this.segment = segment;
	}
	/**
	 * @return the route
	 */
	public RouteBean getRoute() {
		return route;
	}
	/**
	 * @param route the route to set
	 */
	public void setRoute(RouteBean route) {
		this.route = route;
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
}
