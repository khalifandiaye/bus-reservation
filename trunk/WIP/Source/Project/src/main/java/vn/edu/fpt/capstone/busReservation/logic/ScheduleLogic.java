/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.logic;

import java.math.RoundingMode;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import vn.edu.fpt.capstone.busReservation.dao.BusStatusDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentBean.PaymentType;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteDetailsBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.displayModel.RouteTicketList;
import vn.edu.fpt.capstone.busReservation.displayModel.SegmentTicket;
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

    public String[] getDeleteInfo(int busStatusId) throws CommonException {
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

    public RouteTicketList getTicketList(int busStatusId) {
        RouteTicketList routeTicketList = null;
        List<TicketBean> tickets = null;
        Map<Integer, SegmentTicket> tripMap = null;
        SegmentTicket segmentTicket = null;
        StringBuilder seats = null;
        List<RouteDetailsBean> allSegments = null;
        tickets = busStatusDAO.getAllTickets(busStatusId);
        if (tickets != null && tickets.size() > 0) {
            allSegments = tickets.get(0).getTrips().get(0).getRouteDetails()
                    .getRoute().getRouteDetails();
            routeTicketList = new RouteTicketList(allSegments.get(0)
                    .getSegment().getStartAt().getCity().getName(), allSegments
                    .get(allSegments.size() - 1).getSegment().getEndAt()
                    .getCity().getName());
            tripMap = new HashMap<Integer, SegmentTicket>();
            seats = new StringBuilder();
            for (TicketBean ticket : tickets) {
                // clean the string builder
                seats.setLength(0);
                for (TripBean trip : ticket.getTrips()) {
                    if (tripMap.containsKey(trip.getId())) {
                        segmentTicket = tripMap.get(trip.getId());
                    } else {
                        segmentTicket = new SegmentTicket(trip
                                .getRouteDetails().getSegment().getStartAt()
                                .getCity().getName(), trip.getRouteDetails()
                                .getSegment().getEndAt().getCity().getName());
                        tripMap.put(trip.getId(), segmentTicket);
                        routeTicketList.getSegmentTicketList().add(
                                segmentTicket);
                    }
                    for (SeatPositionBean seat : ticket.getSeatPositions()) {
                        seats.append(seat.getName());
                        seats.append(", ");
                    }
                    // clean the last ,
                    seats.setLength(seats.length() - 2);
                    // insert new ticket code
                    segmentTicket.new Ticket(ticket.getReservation().getCode(),
                            seats.toString());
                }
            }
        }
        return routeTicketList;
    }

}
