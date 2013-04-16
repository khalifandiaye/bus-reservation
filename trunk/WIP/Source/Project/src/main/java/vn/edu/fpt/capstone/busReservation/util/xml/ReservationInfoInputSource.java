/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.util.xml;

import org.xml.sax.InputSource;

import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;

/**
 * @author Yoshimi
 * 
 */
public final class ReservationInfoInputSource extends InputSource {
    private ReservationInfo reservationInfo;

    /**
     * @param reservationInfo
     */
    public ReservationInfoInputSource(ReservationInfo reservationInfo) {
        this.reservationInfo = reservationInfo;
    }

    /**
     * @return the reservationInfo
     */
    public ReservationInfo getReservationInfo() {
        return reservationInfo;
    }
}
