/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.util;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import vn.edu.fpt.capstone.busReservation.dao.TariffViewDAO;
import vn.edu.fpt.capstone.busReservation.dao.TicketDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TariffBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean.TicketStatus;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo.Ticket;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
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
    public final static Comparator<TripBean> TRIP_COMPARATOR = new Comparator<TripBean>() {

        @Override
        public int compare(final TripBean o1, final TripBean o2) {
            long result = 0;
            if (o1 == null && o2 == null) {
                result = 0;
            } else if (o1 == null) {
                result = -1;
            } else if (o2 == null) {
                result = 1;
            } else {
                result = o1.getDepartureTime().getTime()
                        - o2.getDepartureTime().getTime();
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

    public static Map<Integer, List<TripBean>> splitTrips(
            final List<TripBean> trips) {
        Map<Integer, List<TripBean>> result = null;
        int busStatusId = 0;
        List<TripBean> tripList = null;
        Collections.sort(trips, TRIP_COMPARATOR);
        result = new HashMap<Integer, List<TripBean>>();
        for (TripBean trip : trips) {
            busStatusId = trip.getBusStatus().getId();
            tripList = result.get(busStatusId);
            if (tripList == null) {
                tripList = new ArrayList<TripBean>();
                result.put(busStatusId, tripList);
            }
            tripList.add(trip);
        }
        return result;
    }

    public static double addTickets(ReservationInfo info, List<TripBean> trips,
            int quantity, boolean returnTrip, TariffViewDAO tariffViewDAO,
            CurrencyConverter converter) throws CommonException {
        Map<Integer, List<TripBean>> tripMap = null;
        Ticket ticket = null;
        double basePrice = 0;
        if (trips != null && trips.size() > 0) {
            tripMap = ReservationUtils.splitTrips(trips);
            for (Map.Entry<Integer, List<TripBean>> entry : tripMap.entrySet()) {
                ticket = createTicket(info, entry, quantity, returnTrip,
                        tariffViewDAO, converter);
                ticket.setSeats(new String[quantity]);
                basePrice += quantity * ticket.getTicketPriceValue();
            }
        }
        return basePrice;
    }

    private static Ticket createTicket(ReservationInfo info,
            Map.Entry<Integer, List<TripBean>> entry, int quantity,
            boolean returnTrip, TariffViewDAO tariffViewDAO,
            CurrencyConverter converter) {
        List<TripBean> subTripList = null;
        Ticket ticket = null;
        double ticketPrice = 0;
        subTripList = entry.getValue();
        ticket = info.new Ticket();
        info.getTickets().add(ticket);
        ticket.setDepartureDateInMilisec(subTripList.get(0).getDepartureTime()
                .getTime());
        ticket.setDepartureDate(FormatUtils.formatDate(subTripList.get(0)
                .getDepartureTime(), CommonConstant.PATTERN_DATE_TIME_FULL,
                CommonConstant.LOCALE_VN, CommonConstant.DEFAULT_TIME_ZONE));
        ticket.setArrivalDate(FormatUtils.formatDate(
                subTripList.get(subTripList.size() - 1).getArrivalTime(),
                CommonConstant.PATTERN_DATE_TIME_FULL, CommonConstant.LOCALE_VN,
                CommonConstant.DEFAULT_TIME_ZONE));
        ticket.setDepartureStation(subTripList.get(0).getRouteDetails()
                .getSegment().getStartAt().getName());
        ticket.setDepartureLocation(subTripList.get(0).getRouteDetails()
                .getSegment().getStartAt().getCity().getName());
        ticket.setArrivalStation(subTripList.get(subTripList.size() - 1)
                .getRouteDetails().getSegment().getEndAt().getName());
        ticket.setArrivalLocation(subTripList.get(subTripList.size() - 1)
                .getRouteDetails().getSegment().getEndAt().getCity().getName());
        ticket.setBusType(subTripList.get(0).getBusStatus().getBus()
                .getBusType().getName());
        ticketPrice = tariffViewDAO.getTicketPrice(subTripList);
        ticketPrice *= 1000;
        ticket.setTicketPrice(ticketPrice);
        ticket.setTicketPriceInUSD(converter.convert(ticketPrice));
        ticket.setReturnTrip(returnTrip);
        return ticket;
    }

    public static double addTickets(ReservationInfo info,
            TicketBean ticketBean, boolean returnTrip,
            TariffViewDAO tariffViewDAO, TicketDAO ticketDao,
            CurrencyConverter converter) throws CommonException {
        Map<Integer, List<TripBean>> tripMap = null;
        List<TripBean> trips = null;
        Ticket ticket = null;
        double basePrice = 0;
        int quantity = 0;
        int count = 0;
        trips = ticketBean.getTrips();
        if (trips != null && trips.size() > 0) {
            tripMap = ReservationUtils.splitTrips(trips);
            for (Map.Entry<Integer, List<TripBean>> entry : tripMap.entrySet()) {
                quantity = ticketBean.getSeatPositions().size();
                ticket = createTicket(info, entry, quantity, returnTrip,
                        tariffViewDAO, converter);
                ticket.setId(ticketBean.getId());
                ticket.setSeats(new String[quantity]);
                count = 0;
                for (SeatPositionBean seat : ticketBean.getSeatPositions()) {
                    ticket.getSeats()[count++] = seat.getName();
                }
                ticket.setStatus(ticketBean.getStatus());
                if (TicketStatus.CANCELLED.getValue().equals(
                        ticketBean.getStatus())
                        || TicketStatus.REFUNDED2.getValue().equals(
                                ticketBean.getStatus())) {
                    ticket.setCancelReason(ticketDao.getChangeReason(
                            ticketBean.getId(), 1));
                }
                basePrice += quantity * ticket.getTicketPriceValue();
            }
        }
        return basePrice;
    }

    public static BigDecimal roundingVND(final BigDecimal number,
            RoundingMode roundingMode) {
        return number.divide(BigDecimal.valueOf(500), 0, roundingMode)
                .multiply(BigDecimal.valueOf(500));
    }

    public static Double roundingVND(final Double number, RoundingMode roundingMode) {
        if (number == null) {
            return null;
        } else if (roundingMode == null
                || RoundingMode.CEILING.equals(roundingMode)) {
            return Math.ceil(number / 500) * 500;
        } else if (RoundingMode.FLOOR.equals(roundingMode)) {
            return Math.floor(number / 500) * 500;
        } else if (RoundingMode.DOWN.equals(roundingMode)) {
            if (number > 0) {
                return Math.floor(number / 500) * 500;
            } else {
                return Math.ceil(number / 500) * 500;
            }
        } else if (RoundingMode.UP.equals(roundingMode)) {
            if (number > 0) {
                return Math.ceil(number / 500) * 500;
            } else {
                return Math.floor(number / 500) * 500;
            }
        } else if (RoundingMode.UNNECESSARY.equals(roundingMode)) {
            return number;
        } else if (RoundingMode.HALF_UP.equals(roundingMode)) {
            return (double) Math.round(number / 500) * 500;
        } else if (RoundingMode.HALF_DOWN.equals(roundingMode)) {
            return (double) Math.ceil(number / 500 - 0.5) * 500;
        } else {
            throw new UnsupportedOperationException();
        }
    }

}
