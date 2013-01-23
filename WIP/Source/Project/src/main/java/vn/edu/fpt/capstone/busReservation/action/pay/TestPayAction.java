/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;
import vn.edu.fpt.capstone.busReservation.dao.TariffDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TariffBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author Yoshimi
 * 
 */
public class TestPayAction extends ActionSupport implements SessionAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5713118155580163291L;

	private Map<String, Object> session;

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

	private ReservationInfo reservationInfo;

	/**
	 * @return the reservationInfo
	 */
	public ReservationInfo getReservationInfo() {
		return reservationInfo;
	}

	public String execute() {
		BigDecimal basePrice = null;
		BigDecimal quantity = null;
		BigDecimal fee = null;
		BigDecimal totalAmount = null;
		BigDecimal conversionRate = null;
		ReservationBean reservationBean = null;
		TripBean[] startEndTrips = null;
		reservationBean = reservationDAO.getById(1);
		reservationInfo = new ReservationInfo();
		startEndTrips = getStartEndTrips(reservationBean.getTrips());
		reservationInfo.setRouteName(reservationBean.getTrips().get(0)
				.getSegmentInRoute().getRoute().getName());
		reservationInfo.setSubRouteName(startEndTrips[0].getSegmentInRoute()
				.getSegment().getStartAt().getCity()
				+ " - "
				+ startEndTrips[1].getSegmentInRoute().getSegment().getEndAt()
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
		result = BigDecimal.ZERO.add(basePrice.multiply(quantity))
				.multiply(BigDecimal.valueOf(0.039))
				.add(BigDecimal.valueOf(0.3).multiply(conversionRate));
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

	/**
	 * Get the first and last trips from a list of continuous trips.<br>
	 * Note that each trip in the list must be connected with exactly two other<br>
	 * trips, except for the first and last trips, which are connected with<br>
	 * exactly one other trip
	 * 
	 * @param trips
	 *            a list of continuous trips
	 * @return an array of the first and the last trips, in that order
	 */
	private TripBean[] getStartEndTrips(List<TripBean> trips) {
		TripBean[] result = null;
		TripBean startTrip = null;
		TripBean endTrip = null;
		Map<StationBean, TripBean> startMap = null;
		Map<StationBean, TripBean> endMap = null;
		startMap = new HashMap<StationBean, TripBean>();
		endMap = new HashMap<StationBean, TripBean>();
		for (TripBean trip : trips) {
			startMap.put(trip.getSegmentInRoute().getSegment().getStartAt(),
					trip);
			endMap.put(trip.getSegmentInRoute().getSegment().getEndAt(), trip);
		}
		for (TripBean trip : trips) {
			startMap.remove(trip.getSegmentInRoute().getSegment().getEndAt());
			endMap.remove(trip.getSegmentInRoute().getSegment().getStartAt());
		}
		startTrip = startMap.values().iterator().next();
		endTrip = endMap.values().iterator().next();
		result = new TripBean[2];
		result[0] = startTrip;
		result[1] = endTrip;
		return result;
	}

	private String getSeatNumbers(List<SeatPositionBean> seatPositions) {
		StringBuilder result = null;
		result = new StringBuilder();
		for (SeatPositionBean seatPosition : seatPositions) {
			result.append(" " + seatPosition.getName());
		}
		// remove first space
		result.delete(0, 1);
		return result.toString();
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}
