/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

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
}
