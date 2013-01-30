/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.interceptor.SessionAware;

import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;
import vn.edu.fpt.capstone.busReservation.dao.TariffDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TariffBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;
import vn.edu.fpt.capstone.busReservation.util.TripUtils;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author Yoshimi
 * 
 */
@Action(results = {@Result(name="input", location="pay02000-success.jsp" )})
public class Pay02010Action extends ActionSupport implements SessionAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5713118155580163291L;

	private Map<String, Object> session;

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	// =====================Database Access Object=====================
	private ReservationDAO reservationDAO;
	private TariffDAO tariffDAO;

	/**
	 * @param reservationDAO
	 *            the reservationDAO to set
	 */
	public void setReservationDAO(ReservationDAO reservationDAO) {
		this.reservationDAO = reservationDAO;
	}

	/**
	 * @param tariffDAO
	 *            the tariffDAO to set
	 */
	public void setTariffDAO(TariffDAO tariffDAO) {
		this.tariffDAO = tariffDAO;
	}

	// ==========================Action Input==========================
	private String reservationCode;

	/**
	 * @param reservationCode the reservationCode to set
	 */
	public void setReservationCode(String reservationCode) {
	    this.reservationCode = reservationCode;
	}

	// ==========================Action Output=========================
	private ReservationInfo reservationInfo;

	/**
	 * @return the reservationInfo
	 */
	public ReservationInfo getReservationInfo() {
		return reservationInfo;
	}

	@Override
	public void validate() {
		if (CheckUtils.isNullOrBlank(reservationCode)) {
			addFieldError("reservationCode", "Please enter a reservation code");
		}
	}

	public String execute() {
		BigDecimal basePrice = null;
		BigDecimal quantity = null;
		BigDecimal fee = null;
		BigDecimal totalAmount = null;
		BigDecimal conversionRate = null;
		ReservationBean reservationBean = null;
		TripBean[] startEndTrips = null;

		reservationBean = reservationDAO.getByCode(reservationCode);
		if (reservationBean == null) {
		    addFieldError("reservationCode", "Can not retrieve reservation");
		    return INPUT;
		}
		reservationInfo = new ReservationInfo();
		startEndTrips = TripUtils.getStartEndTrips(
				reservationBean.getTrips()).values().iterator().next();
		reservationInfo.setRouteName(reservationBean.getTrips().get(0)
				.getRouteDetails().getRoute().getName());
		reservationInfo.setSubRouteName(startEndTrips[0].getRouteDetails()
				.getSegment().getStartAt().getCity()
				+ " - "
				+ startEndTrips[1].getRouteDetails().getSegment().getEndAt()
						.getCity());
		reservationInfo.setDepartureDate(FormatUtils.formatDate(
				startEndTrips[0].getDepartureTime(),
				"EEEEE dd/MM/yyyy hh:mm aa", new Locale("vi", "VN")));
		reservationInfo.setArrivalDate(FormatUtils.formatDate(
				startEndTrips[1].getArrivalTime(), "EEEEE dd/MM/yyyy hh:mm aa",
				new Locale("vi", "VN")));
		reservationInfo.setSeatNumbers(getSeatNumbers(reservationBean
				.getSeatPositions()));
		quantity = BigDecimal
				.valueOf(reservationBean.getSeatPositions().size());
		reservationInfo.setQuantity(quantity.toString());
		conversionRate = BigDecimal.valueOf(20000);
		reservationInfo.setConversionRate(FormatUtils.formatNumber(
				conversionRate, 0, Locale.US));
		basePrice = calculateTicketPrice(tariffDAO.getFares(reservationBean))
				.divide(BigDecimal.valueOf(500), 0, RoundingMode.CEILING)
				.multiply(BigDecimal.valueOf(500));
		fee = calculateFee(basePrice, quantity, conversionRate).divide(
				BigDecimal.valueOf(500), 0, RoundingMode.CEILING).multiply(
				BigDecimal.valueOf(500));
		totalAmount = calculateTotal(basePrice, quantity, fee).divide(
				BigDecimal.valueOf(500), 0, RoundingMode.CEILING).multiply(
				BigDecimal.valueOf(500));
		reservationInfo.setBasePrice(FormatUtils.formatNumber(basePrice, 0,
				Locale.US));
		reservationInfo.setBasePriceInUSD(FormatUtils.formatNumber(
				convert(basePrice, conversionRate), 2, Locale.US));
		reservationInfo.setTransactionFee(FormatUtils.formatNumber(fee, 0,
				Locale.US));
		reservationInfo.setTransactionFeeInUSD(FormatUtils.formatNumber(
				convert(fee, conversionRate), 2, Locale.US));
		reservationInfo.setTotalAmount(FormatUtils.formatNumber(totalAmount, 0,
				Locale.US));
		reservationInfo.setTotalAmountInUSD(FormatUtils.formatNumber(
				convert(totalAmount, conversionRate), 2, Locale.US));
		session.put("reservationInfo", reservationInfo);
		return SUCCESS;
	}

	private BigDecimal convert(BigDecimal totalAmount, BigDecimal conversionRate) {
		BigDecimal result = null;
		result = BigDecimal.ZERO.setScale(2).add(totalAmount)
				.divide(conversionRate, RoundingMode.CEILING);
		return result;
	}

	private BigDecimal calculateTotal(BigDecimal basePrice,
			BigDecimal quantity, BigDecimal fee) {
		BigDecimal result = null;
		result = basePrice.multiply(quantity).add(fee);
		return result;
	}

	private BigDecimal calculateFee(BigDecimal basePrice, BigDecimal quantity,
			BigDecimal conversionRate) {
		BigDecimal result = null;
		BigDecimal constantFee = null;
		BigDecimal feeRatio = null;
		constantFee = BigDecimal.valueOf(0.3).multiply(conversionRate);
		feeRatio = BigDecimal.valueOf(0.039);
		result = BigDecimal.ZERO
				.add(basePrice.multiply(quantity))
				.add(constantFee)
				.divide(BigDecimal.ONE.subtract(feeRatio), 0,
						RoundingMode.CEILING).multiply(feeRatio)
				.add(constantFee);
		return result;
	}

	private BigDecimal calculateTicketPrice(List<TariffBean> fares) {
		BigDecimal result = null;
		result = BigDecimal.ZERO;
		for (TariffBean fare : fares) {
			result = result.add(BigDecimal.valueOf(fare.getFare()));
		}
		return result;
	}

	private String getSeatNumbers(List<SeatPositionBean> seatPositions) {
		StringBuilder result = null;
		result = new StringBuilder();
		for (SeatPositionBean seatPosition : seatPositions) {
			result.append(" " + seatPosition.getId().getName());
		}
		// remove first space
		result.delete(0, 1);
		return result.toString();
	}

}
