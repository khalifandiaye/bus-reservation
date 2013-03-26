/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao.bean;

import java.util.Date;

/**
 * @author Yoshimi
 * 
 */
public class SegmentTravelTimeBean extends AbstractBean<Integer> {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private SegmentBean segment;
    private long travelTime;
    private Date validFrom;

    /**
     * @return the segment
     */
    public SegmentBean getSegment() {
        return segment;
    }

    /**
     * @param segment
     *            the segment to set
     */
    public void setSegment(SegmentBean segment) {
        this.segment = segment;
    }

    /**
     * @return the travelTime
     */
    public long getTravelTime() {
        return travelTime;
    }

    /**
     * @param travelTime
     *            the travelTime to set
     */
    public void setTravelTime(long travelTime) {
        this.travelTime = travelTime;
    }

    /**
     * @return the validFrom
     */
    public Date getValidFrom() {
        return validFrom;
    }

    /**
     * @param validFrom
     *            the validFrom to set
     */
    public void setValidFrom(Date validFrom) {
        this.validFrom = validFrom;
    }

}
