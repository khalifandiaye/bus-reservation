/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.logic;

import java.math.RoundingMode;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentBean.PaymentType;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;
import vn.edu.fpt.capstone.busReservation.util.ReservationUtils;

/**
 * @author Yoshimi
 * 
 */
public class ScheduleLogic extends BaseLogic {

    private ReservationDAO reservationDAO;

    /**
     * @param reservationDAO
     *            the reservationDAO to set
     */
    @Autowired
    public void setReservationDAO(ReservationDAO reservationDAO) {
        this.reservationDAO = reservationDAO;
    }

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    public void deleteBusStatus(int i, String id, int userId)
            throws CommonException {
    }

    public String[] getDeleteInfo(int id, int userId) throws CommonException {
        // TODO Auto-generated method stub
        String[] params = null;
        double paidAmount = 0;
        int count = 0;
        List<ReservationBean> reservations = null;
        paidAmount *= 1000;
        paidAmount = ReservationUtils.roundingVND(paidAmount, RoundingMode.CEILING);
        params = new String[2];
        params[0] = Integer.toString(count);
        params[1] = FormatUtils.formatNumber(paidAmount, 0, CommonConstant.LOCALE_VN);
        return params;
    }

}
