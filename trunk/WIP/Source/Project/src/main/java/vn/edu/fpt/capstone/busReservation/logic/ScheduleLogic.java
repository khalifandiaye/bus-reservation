/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.logic;

import java.math.RoundingMode;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.UserDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentBean.PaymentType;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;
import vn.edu.fpt.capstone.busReservation.util.ReservationUtils;

/**
 * @author Yoshimi
 * 
 */
public class ScheduleLogic extends BaseLogic {

	/**
     * 
     */
	private static final long serialVersionUID = 1L;
	private BusStatusDAO busStatusDAO;

	/**
	 * @param busStatusDAO
	 *            the busStatusDAO to set
	 */
	@Autowired
	public void setBusStatusDAO(BusStatusDAO busStatusDAO) {
		this.busStatusDAO = busStatusDAO;
	}

	public void cancelBusStatus(int i, String reason, int userId)
			throws CommonException {
		busStatusDAO.cancel(i, reason, userId);
	}

	public String[] getDeleteInfo(int busStatusId)
			throws CommonException {
		// TODO Auto-generated method stub
		String[] params = null;
		double paidAmount = 0;
		int count = 0;
		List<TicketBean> tickets = null;
		tickets = busStatusDAO.getTickets(busStatusId);
		if (tickets != null && tickets.size() > 0) {
			count = tickets.size();
			for (TicketBean ticket : tickets) {
				for (PaymentBean payment : ticket.getPayments()) {
					if (PaymentType.PAY.equals(payment.getType())) {
						paidAmount += payment.getPayAmount()
								- payment.getServiceFee();
					} else {
						paidAmount -= payment.getPayAmount()
								- payment.getServiceFee();
					}
				}
			}
		}
		paidAmount *= 1000;
		paidAmount = ReservationUtils.roundingVND(paidAmount,
				RoundingMode.CEILING);
		params = new String[2];
		params[0] = Integer.toString(count);
		params[1] = FormatUtils.formatNumber(paidAmount, 0,
				CommonConstant.LOCALE_VN);
		return params;
	}

}
