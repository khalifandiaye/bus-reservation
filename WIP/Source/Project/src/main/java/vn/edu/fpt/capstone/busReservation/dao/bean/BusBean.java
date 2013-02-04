/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.List;

/**
 * @author Yoshimi
 *
 */
public class BusBean extends AbstractBean<Integer> {
	/**
	 * 
	 */
	private static final long serialVersionUID = 992801076149506686L;
	private BusTypeBean busType;
	private String plateNumber;
	private String status;
	private RouteBean forwardRoute;
	private RouteBean returnRoute;
	private List<BusStatusBean> statusList;
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
	 * @return the plateNumber
	 */
	public String getPlateNumber() {
		return plateNumber;
	}
	/**
	 * @param plateNumber the plateNumber to set
	 */
	public void setPlateNumber(String plateNumber) {
		this.plateNumber = plateNumber;
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
	 * @return the forwardRoute
	 */
	public RouteBean getForwardRoute() {
	    return forwardRoute;
	}
	/**
	 * @param forwardRoute the forwardRoute to set
	 */
	public void setForwardRoute(RouteBean forwardRoute) {
	    this.forwardRoute = forwardRoute;
	}
	/**
	 * @return the returnRoute
	 */
	public RouteBean getReturnRoute() {
	    return returnRoute;
	}
	/**
	 * @param returnRoute the returnRoute to set
	 */
	public void setReturnRoute(RouteBean returnRoute) {
	    this.returnRoute = returnRoute;
	}
	/**
	 * @return the statusList
	 */
	public List<BusStatusBean> getStatusList() {
	    return statusList;
	}
	/**
	 * @param statusList the statusList to set
	 */
	public void setStatusList(List<BusStatusBean> statusList) {
	    this.statusList = statusList;
	}
}
