/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.Date;

/**
 * @author Yoshimi
 *
 */
public class TariffViewBean extends AbstractBean<Integer> {
	/**
     * 
     */
    private static final long serialVersionUID = 1L;
    private SegmentBean segment;
	private BusTypeBean busType;
	private Date validFrom;
    private Date validTo;
	private double fare;
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
     * @return the validTo
     */
    public Date getValidTo() {
        return validTo;
    }
    /**
     * @param validTo the validTo to set
     */
    public void setValidTo(Date validTo) {
        this.validTo = validTo;
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
