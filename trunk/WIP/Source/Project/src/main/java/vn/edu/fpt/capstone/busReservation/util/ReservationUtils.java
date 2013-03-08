/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.util;

import java.math.BigDecimal;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TariffBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.logic.PaymentLogic;

/**
 * @author Yoshimi
 * 
 */
public abstract class ReservationUtils {
    protected static Log LOG = LogFactory.getLog(PaymentLogic.class);
    public final static Comparator<TicketBean> TICKET_COMPARATOR = new Comparator<TicketBean>() {

        @Override
        public int compare(final TicketBean o1, final TicketBean o2) {
            long result = 0;
            if (o1 == null && o2 == null) {
                result = 0;
            } else if (o1 == null) {
                result = -1;
            } else if (o2 == null) {
                result = 1;
            } else {
                result = o1.getTrips().get(0).getBusStatus().getFromDate()
                        .getTime()
                        - o2.getTrips().get(0).getBusStatus().getFromDate()
                                .getTime();
            }
            return result > Integer.MAX_VALUE ? Integer.MAX_VALUE
                    : result < Integer.MIN_VALUE ? Integer.MIN_VALUE
                            : (int) result;
        }
    };

    /**
     * Get the first and last trips from a list of continuous trips.<br>
     * 
     * @param trips
     *            a list of trips
     * @return an array of the first and the last trips, in that order
     */
    public static Map<Integer, TripBean[]> getStartEndTripsMap(
            List<TripBean> trips) {
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

    public static TripBean[] getStartEndTrips(
            Map<Integer, TripBean[]> startEndTripsMap) {
        TripBean[] startEndTrips = null;
        startEndTrips = new TripBean[2];
        for (TripBean[] trips : startEndTripsMap.values()) {
            if (startEndTrips[0] == null
                    || trips[0].getDepartureTime().before(
                            startEndTrips[0].getDepartureTime())) {
                startEndTrips[0] = trips[0];
            }
            if (startEndTrips[1] == null
                    || trips[1].getDepartureTime().after(
                            startEndTrips[1].getDepartureTime())) {
                startEndTrips[1] = trips[1];
            }
        }
        return startEndTrips;
    }

    public static TripBean[] getStartEndTrips(List<TripBean> trips) {
        return getStartEndTrips(getStartEndTripsMap(trips));
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

    // public static BigDecimal roundingVND(BigDecimal number) {
    // return number.divide(BigDecimal.valueOf(500), 0, RoundingMode.CEILING)
    // .multiply(BigDecimal.valueOf(500));
    // }
    //
    // public static BigDecimal calculateTotal(final String basePrice,
    // final String quantity, final BigDecimal fee) throws ParseException {
    // BigDecimal result = null;
    // result = FormatUtils
    // .deformatNumber(basePrice, CommonConstant.LOCALE_VN)
    // .multiply(new BigDecimal(quantity)).add(fee);
    // return result;
    // }
    //
    // public static BigDecimal calculateFee(final String basePrice,
    // final String quantity, final PaymentMethodBean paymentMethod)
    // throws IOException, ParseException {
    // BigDecimal result = null;
    // BigDecimal constantFee = null;
    // BigDecimal feeRatio = null;
    // CurrencyConverter converter = null;
    // try {
    // converter = CurrencyConverter.getInstance(
    // Currency.getInstance("USD"), Currency.getInstance("VND"));
    // } catch (InstantiationException e) {
    // LOG.error("Impossible error", e);
    // }
    // constantFee = converter.convert(BigDecimal.valueOf(paymentMethod
    // .getAddition()));
    // feeRatio = BigDecimal.valueOf(paymentMethod.getRatio());
    // result = BigDecimal.ZERO
    // .add(FormatUtils.deformatNumber(basePrice,
    // CommonConstant.LOCALE_VN).multiply(
    // new BigDecimal(quantity)))
    // .add(constantFee)
    // .divide(BigDecimal.ONE.subtract(feeRatio), 0,
    // RoundingMode.CEILING).multiply(feeRatio)
    // .add(constantFee);
    // return result;
    // }

}
