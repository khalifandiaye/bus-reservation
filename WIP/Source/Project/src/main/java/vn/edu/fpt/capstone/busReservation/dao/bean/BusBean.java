/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

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
}
