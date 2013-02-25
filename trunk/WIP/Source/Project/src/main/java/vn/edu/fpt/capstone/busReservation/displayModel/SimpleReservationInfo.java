/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.displayModel;

import java.io.Serializable;

/**
 * @author Yoshimi
 * 
 */
public class SimpleReservationInfo implements Serializable {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private int id;
    private String subRouteName;
    private String departureDate;
    private String bookTime;
    private long bookTimeInMilisec;
    /**
     * status of the reservation
     */
    private String status;
    /**
     * @return the id
     */
    public int getId() {
        return id;
    }
    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }
    /**
     * @return the subRouteName
     */
    public String getSubRouteName() {
        return subRouteName;
    }
    /**
     * @param subRouteName the subRouteName to set
     */
    public void setSubRouteName(String subRouteName) {
        this.subRouteName = subRouteName;
    }
    /**
     * @return the departureDate
     */
    public String getDepartureDate() {
        return departureDate;
    }
    /**
     * @param departureDate the departureDate to set
     */
    public void setDepartureDate(String departureDate) {
        this.departureDate = departureDate;
    }
    /**
     * @return the bookTime
     */
    public String getBookTime() {
        return bookTime;
    }
    /**
     * @param bookTime the bookTime to set
     */
    public void setBookTime(String bookTime) {
        this.bookTime = bookTime;
    }
    /**
     * @return the bookTimeInMilisec
     */
    public long getBookTimeInMilisec() {
        return bookTimeInMilisec;
    }
    /**
     * @param bookTimeInMilisec the bookTimeInMilisec to set
     */
    public void setBookTimeInMilisec(long bookTimeInMilisec) {
        this.bookTimeInMilisec = bookTimeInMilisec;
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
