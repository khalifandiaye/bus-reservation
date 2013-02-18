/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.util;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TariffBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.logic.PaymentLogic;

/**
 * @author Yoshimi
 * 
 */
public abstract class ReservationUtils {
    protected static Log LOG = LogFactory.getLog(PaymentLogic.class);

    /**
     * Get the first and last trips from a list of continuous trips.<br>
     * 
     * @param trips
     *            a list of trips
     * @return an array of the first and the last trips, in that order
     */
    public static Map<Integer, TripBean[]> getStartEndTrips(List<TripBean> trips) {
        Map<Integer, TripBean[]> result = null;
        int busStatusId = 0;
        result = new HashMap<Integer, TripBean[]>();
        for (TripBean trip : trips) {
            busStatusId = trip.getBusStatus().getId();
            if (!result.containsKey(busStatusId)) {
                result.put(busStatusId, new TripBean[2]);
            }
            if (result.get(busStatusId)[0] == null
                    || result.get(busStatusId)[0].getArrivalTime().after(
                            trip.getArrivalTime())) {
                result.get(busStatusId)[0] = trip;
            }
            if (result.get(busStatusId)[1] == null
                    || result.get(busStatusId)[1].getArrivalTime().before(
                            trip.getArrivalTime())) {
                result.get(busStatusId)[1] = trip;
            }
        }
        return result;
    }

    public static String getSeatNumbers(
            final List<SeatPositionBean> seatPositions) {
        StringBuilder result = null;
        result = new StringBuilder();
        for (SeatPositionBean seatPosition : seatPositions) {
            result.append(" " + seatPosition.getId().getName());
        }
        // remove first space
        result.delete(0, 1);
        return result.toString();
    }

    public static BigDecimal calculateTicketPrice(final List<TariffBean> fares) {
        BigDecimal result = null;
        result = BigDecimal.ZERO;
        for (TariffBean fare : fares) {
            result = result.add(BigDecimal.valueOf(fare.getFare()));
        }
        return result;
    }

//    public static BigDecimal roundingVND(BigDecimal number) {
//        return number.divide(BigDecimal.valueOf(500), 0, RoundingMode.CEILING)
//                .multiply(BigDecimal.valueOf(500));
//    }
//
//    public static BigDecimal calculateTotal(final String basePrice,
//            final String quantity, final BigDecimal fee) throws ParseException {
//        BigDecimal result = null;
//        result = FormatUtils
//                .deformatNumber(basePrice, CommonConstant.LOCALE_VN)
//                .multiply(new BigDecimal(quantity)).add(fee);
//        return result;
//    }
//
//    public static BigDecimal calculateFee(final String basePrice,
//            final String quantity, final PaymentMethodBean paymentMethod)
//            throws IOException, ParseException {
//        BigDecimal result = null;
//        BigDecimal constantFee = null;
//        BigDecimal feeRatio = null;
//        CurrencyConverter converter = null;
//        try {
//            converter = CurrencyConverter.getInstance(
//                    Currency.getInstance("USD"), Currency.getInstance("VND"));
//        } catch (InstantiationException e) {
//            LOG.error("Impossible error", e);
//        }
//        constantFee = converter.convert(BigDecimal.valueOf(paymentMethod
//                .getAddition()));
//        feeRatio = BigDecimal.valueOf(paymentMethod.getRatio());
//        result = BigDecimal.ZERO
//                .add(FormatUtils.deformatNumber(basePrice,
//                        CommonConstant.LOCALE_VN).multiply(
//                        new BigDecimal(quantity)))
//                .add(constantFee)
//                .divide(BigDecimal.ONE.subtract(feeRatio), 0,
//                        RoundingMode.CEILING).multiply(feeRatio)
//                .add(constantFee);
//        return result;
//    }

}
