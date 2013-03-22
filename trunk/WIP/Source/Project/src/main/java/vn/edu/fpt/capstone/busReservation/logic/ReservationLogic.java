/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.logic;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Currency;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;
import vn.edu.fpt.capstone.busReservation.dao.ReservationInfoDAO;
import vn.edu.fpt.capstone.busReservation.dao.SystemSettingDAO;
import vn.edu.fpt.capstone.busReservation.dao.TariffViewDAO;
import vn.edu.fpt.capstone.busReservation.dao.TicketDAO;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.UserDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.ArrangedReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentBean.PaymentType;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationInfoBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean.TicketStatus;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo.Ticket;
import vn.edu.fpt.capstone.busReservation.displayModel.SimpleReservationInfo;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.CurrencyConverter;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;
import vn.edu.fpt.capstone.busReservation.util.ReservationUtils;

/**
 * @author Yoshimi
 * 
 */
public class ReservationLogic extends BaseLogic {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    // =====================Database Access Object=====================
    private UserDAO userDAO;
    private ReservationInfoDAO reservationInfoDAO;
    private TariffViewDAO tariffViewDAO;
    private TripDAO tripDAO;
    private ReservationDAO reservationDAO;
    private SystemSettingDAO systemSettingDAO;
    private TicketDAO ticketDAO;

    /**
     * @param userDAO
     *            the userDAO to set
     */
    @Autowired
    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    /**
     * @param reservationInfoDAO
     *            the reservationInfoDAO to set
     */
    @Autowired
    public void setReservationInfoDAO(ReservationInfoDAO reservationInfoDAO) {
        this.reservationInfoDAO = reservationInfoDAO;
    }

    /**
     * @param tariffViewDAO
     *            the tariffViewDAO to set
     */
    @Autowired
    public void setTariffViewDAO(TariffViewDAO tariffViewDAO) {
        this.tariffViewDAO = tariffViewDAO;
    }

    /**
     * @param tripDAO
     *            the tripDAO to set
     */
    @Autowired
    public void setTripDAO(TripDAO tripDAO) {
        this.tripDAO = tripDAO;
    }

    /**
     * @param reservationDAO
     *            the reservationDAO to set
     */
    @Autowired
    public void setReservationDAO(ReservationDAO reservationDAO) {
        this.reservationDAO = reservationDAO;
    }

    /**
     * @param systemSettingDAO
     *            the systemSettingDAO to set
     */
    @Autowired
    public void setSystemSettingDAO(SystemSettingDAO systemSettingDAO) {
        this.systemSettingDAO = systemSettingDAO;
    }

    /**
     * @param ticketDAO
     *            the ticketDAO to set
     */
    @Autowired
    public void setTicketDAO(TicketDAO ticketDAO) {
        this.ticketDAO = ticketDAO;
    }

    /**
     * For testing purpose only
     * 
     * @return a list of all customers
     */
    public List<String> getUserList() {
        List<String> userList = null;
        List<UserBean> users = null;
        users = userDAO.getAll();
        userList = new ArrayList<String>();
        for (UserBean user : users) {
            userList.add(user.getUsername());
        }
        return userList;
    }

    public List<SimpleReservationInfo> loadReservations(String username)
            throws CommonException {
        List<SimpleReservationInfo> infoList = null;
        updateReservationsStatus(username);
        infoList = ticketDAO.getSimpleInfoByUsername(username);
        Collections.sort(infoList);
        return infoList;
    }

    public void updateReservationsStatus(String bookerName) {
        int lockInterval = 0;
        int timeOutInterval = 0;
        List<ArrangedReservationBean> arrRsvBeans = null;
        timeOutInterval = Integer.parseInt(systemSettingDAO.getById(
                "reservation.timeout").getValue());
        lockInterval = systemSettingDAO.getReservationLockTime();
        arrRsvBeans = reservationDAO.getArrangedReservations(bookerName);
        for (ArrangedReservationBean arrRsvBean : arrRsvBeans) {
            updateReservationStatus(arrRsvBean, timeOutInterval, lockInterval);
        }
    }

    public String updateReservationStatus(int reservationId) {
        int lockInterval = 0;
        int timeOutInterval = 0;
        ArrangedReservationBean arrRsvBean = null;
        timeOutInterval = Integer.parseInt(systemSettingDAO.getById(
                "reservation.timeout").getValue());
        lockInterval = systemSettingDAO.getReservationLockTime();
        arrRsvBean = reservationDAO.getArrangedReservation(reservationId);
        updateReservationStatus(arrRsvBean, timeOutInterval, lockInterval);
        return arrRsvBean.getId().getStatus();
    }

    private void updateReservationStatus(ArrangedReservationBean bean,
            Integer timeOutInterval, Integer lockInterval) {
        long now = 0;
        Calendar timeOutPoint = null;
        Calendar lockPoint = null;
        String stsUnpaid = null;
        String stsPaid = null;
        String stsActive = null;
        String stsRsvPending = null;
        String stsTktPending = null;
        String stsTktDeparted = null;
        now = System.currentTimeMillis();
        timeOutPoint = Calendar.getInstance();
        timeOutPoint.add(Calendar.MINUTE, -timeOutInterval);
        lockPoint = Calendar.getInstance();
        stsUnpaid = ReservationStatus.UNPAID.getValue();
        stsPaid = ReservationStatus.PAID.getValue();
        stsActive = TicketStatus.ACTIVE.getValue();
        stsRsvPending = ReservationStatus.PENDING.getValue();
        stsTktPending = TicketStatus.PENDING.getValue();
        stsTktDeparted = TicketStatus.DEPARTED.getValue();
        if (stsUnpaid.equals(bean.getId().getStatus())
                && bean.getId().getBookTime().getTime() < timeOutPoint
                        .getTimeInMillis()) {
            bean.getId().setStatus(ReservationStatus.DELETED.getValue());
        } else if (stsPaid.equals(bean.getId().getStatus())
                || stsRsvPending.equals(bean.getId().getStatus())) {
            lockPoint.clear();
            lockPoint.setTime(bean.getTicket1().getDepartureDate());
            // if ticket 1 is active, and past departed time => DEPARTED
            if ((stsActive.equals(bean.getTicket1().getId().getStatus()) || stsTktPending
                    .equals(bean.getTicket1().getId().getStatus()))
                    && now > lockPoint.getTimeInMillis()) {
                bean.getTicket1().getId().setStatus(stsTktDeparted);
            }
            // if ticket 1 is active, and past lock time => PENDING
            lockPoint.add(Calendar.DATE, -lockInterval);
            if ((stsPaid.equals(bean.getId().getStatus()) && (stsActive
                    .equals(bean.getTicket1().getId().getStatus())))
                    && now > lockPoint.getTimeInMillis()) {
                bean.getTicket1().getId().setStatus(stsTktPending);
            }
            if (bean.getTicket2() != null) {
                // if ticket 2 is active, and past departed time => DEPARTED
                lockPoint.clear();
                lockPoint.setTime(bean.getTicket2().getDepartureDate());
                if ((stsActive.equals(bean.getTicket2().getId().getStatus()) || stsTktPending
                        .equals(bean.getTicket2().getId().getStatus()))
                        && now > lockPoint.getTimeInMillis()) {
                    bean.getTicket2().getId().setStatus(stsTktDeparted);
                }
                // if ticket 2 is active, and past lock time => PENDING
                lockPoint.add(Calendar.DATE, -lockInterval);
                if ((stsPaid.equals(bean.getId().getStatus()) && (stsActive
                        .equals(bean.getTicket2().getId().getStatus())))
                        && now > lockPoint.getTimeInMillis()) {
                    bean.getTicket1().getId().setStatus(stsTktPending);
                    bean.getTicket2().getId().setStatus(stsTktPending);
                } else if (stsTktPending.equals(bean.getTicket1().getId()
                        .getStatus())) {
                    bean.getTicket2().getId().setStatus(stsTktPending);
                }
            }
            // if both ticket is PENDING, or one is PENDING, the other is
            // not ACTIVE => reservation PENDING
            if ((stsPaid.equals(bean.getId().getStatus()))
                    && ((stsTktPending.equals(bean.getTicket1().getId()
                            .getStatus()) && (bean.getTicket2() == null || stsTktPending
                            .equals(bean.getTicket2().getId().getStatus()))) || ((stsTktPending
                            .equals(bean.getTicket1().getId().getStatus()) || (bean
                            .getTicket2() != null && stsTktPending.equals(bean
                            .getTicket2().getId().getStatus()))) && (!stsActive
                            .equals(bean.getTicket1().getId().getStatus()) || (bean
                            .getTicket2() != null && !stsActive.equals(bean
                            .getTicket2().getId().getStatus())))))) {
                bean.getId().setStatus(stsRsvPending);
            }
            // if both ticket is DEPARTED, or one is DEPARTED, the other is
            // neither ACTIVE nor PENDING => reservation DEPARTED
            if ((stsTktDeparted.equals(bean.getTicket1().getId().getStatus()) && (bean
                    .getTicket2() == null || stsTktDeparted.equals(bean
                    .getTicket2().getId().getStatus())))
                    || ((stsTktDeparted.equals(bean.getTicket1().getId()
                            .getStatus()) || (bean.getTicket2() != null && stsTktDeparted
                            .equals(bean.getTicket2().getId().getStatus()))) && (!(stsActive
                            .equals(bean.getTicket1().getId().getStatus()) && stsTktPending
                            .equals(bean.getTicket1().getId().getStatus())) || (bean
                            .getTicket2() != null && !(stsActive.equals(bean
                            .getTicket2().getId().getStatus()) && stsTktPending
                            .equals(bean.getTicket2().getId().getStatus())))))) {
                bean.getId().setStatus(ReservationStatus.DEPARTED.getValue());
            }
        }
        reservationDAO.update(bean.getId());
    }

    public ReservationInfo loadReservationInfo(final String reservationId,
            int userId) throws CommonException {
        ReservationInfo info = null;
        List<TicketBean> tickets = null;
        tickets = ticketDAO.getTickets(Integer.parseInt(reservationId));
        if (tickets != null && tickets.size() > 0) {
            if (tickets.get(0).getReservation().getBooker() != null
                    && userId != tickets.get(0).getReservation().getBooker()
                            .getId()) {
                // access violation
                throw new CommonException("msgerrrs006");
            }
            info = loadReservationInfo(tickets, userId);
        }
        if (info == null) {
            throw new CommonException("msgerrrs004");
        }
        return info;
    }

    public ReservationInfo loadReservationInfoByCode(
            final String reservationCode, String email, boolean convertToUSD)
            throws CommonException {
        ReservationInfo info = null;
        ReservationInfoBean bean = null;
        bean = reservationInfoDAO.getByCode(reservationCode, email);
        if (bean != null && bean.getId().getBooker() == null) {
            info = loadReservationInfo(bean, convertToUSD);
        } else if (bean == null) {
            throw new CommonException("msgerrrs005");
        } else {
            throw new CommonException("msgerrrs006");
        }
        return info;
    }

    /**
     * @param bean
     * @param convertToUSD
     * @param lockInterval
     * @param timeOutInterval
     * @return
     * @throws CommonException
     */
    private ReservationInfo loadReservationInfo(final ReservationInfoBean bean,
            boolean convertToUSD) throws CommonException {
        ReservationInfo info = null;
        CurrencyConverter converter = null;
        int quantity = 0;
        int refundRate = 0;
        updateReservationStatus(bean.getId().getId());
        info = new ReservationInfo();
        info.setId(bean.getId().getId());
        info.setCode(bean.getId().getCode());
        quantity = loadTickets(info, bean.getId().getTickets());
        // TODO first name last name order
        info.setBookerName(bean.getId().getBookerLastName() + " "
                + bean.getId().getBookerFirstName());
        info.setPhone(bean.getId().getPhone());
        info.setEmail(bean.getId().getEmail());
        info.setBasePrice(bean.getTicketPrice());
        if (bean.getPaidAmount() != null) {
            info.setTotalAmount(bean.getPaidAmount());
            info.setTransactionFee(bean.getPaidAmount() - quantity
                    * bean.getTicketPrice());
            info.setRefundedAmount(bean.getRefundAmount());
        }
        if (convertToUSD) {
            try {
                converter = CurrencyConverter.getInstance(
                        Currency.getInstance("VND"),
                        Currency.getInstance("USD"));
            } catch (InstantiationException e) {
                LOG.error("Impossible error", e);
                throw new CommonException(e);
            } catch (IOException e) {
                // TODO handle error
                throw new CommonException(e);
            }
            info.setBasePriceInUSD(converter.convert(bean.getTicketPrice()));
            if (bean.getPaidAmount() != null) {
                info.setTotalAmountInUSD(converter.convert(bean.getPaidAmount()));
                info.setTransactionFeeInUSD(converter.convert(
                        BigDecimal.valueOf(bean.getPaidAmount()).subtract(
                                BigDecimal.valueOf(quantity).multiply(
                                        BigDecimal.valueOf(bean
                                                .getTicketPrice()))))
                        .doubleValue());
                if (bean.getRefundAmount() != null
                        && bean.getRefundAmount() > 0) {
                    info.setRefundedAmountInUSD(converter.convert(bean
                            .getRefundAmount()));
                    refundRate = (int) (bean.getRefundAmount() * 100 / bean
                            .getPaidAmount());
                    info.setRefundRate(refundRate);
                }
            }
        }
        info.setStatus(bean.getId().getStatus());
        // info.setStatus(updateStatus(bean.getId(), bean.getStartTrip()
        // .getDepartureTime(), timeOutInterval, lockInterval));
        return info;
    }

    private ReservationInfo loadReservationInfo(List<TicketBean> tickets,
            int userId) throws CommonException {
        ReservationInfo info = null;
        ReservationBean reservationBean = null;
        CurrencyConverter converter = null;
        double basePrice = 0;
        double paidAmount = 0;
        double fee = 0;
        double refundedAmount = 0;
        reservationBean = tickets.get(0).getReservation();
        updateReservationStatus(reservationBean.getId());
        info = new ReservationInfo();
        info.setId(reservationBean.getId());
        info.setCode(reservationBean.getCode());
        info.setBookerName(reservationBean.getBookerLastName() + " "
                + reservationBean.getBookerLastName());
        info.setPhone(reservationBean.getPhone());
        info.setEmail(reservationBean.getEmail());
        info.setStatus(reservationBean.getStatus());
        try {
            converter = CurrencyConverter.getInstance(
                    Currency.getInstance("VND"), Currency.getInstance("USD"));
        } catch (InstantiationException e) {
            LOG.error("Impossible error", e);
            throw new CommonException(e);
        } catch (IOException e) {
            // TODO handle error
            throw new CommonException(e);
        }
        info.setTickets(new ArrayList<ReservationInfo.Ticket>());
        for (TicketBean ticket : tickets) {
            basePrice += ReservationUtils.addTickets(
                    info,
                    ticket,
                    (tickets.size() <= 1 || ticket
                            .getTrips()
                            .get(0)
                            .getDepartureTime()
                            .after(tickets
                                    .get(tickets.size()
                                            - tickets.indexOf(ticket) - 1)
                                    .getTrips().get(0).getDepartureTime())),
                    tariffViewDAO, converter);
        }
        Collections.sort(info.getTickets());
        info.setBasePrice(basePrice);
        info.setBasePriceInUSD(converter.convert(basePrice));
        if (reservationBean.getPayments() != null
                && reservationBean.getPayments().size() > 0) {
            for (PaymentBean payment : reservationBean.getPayments()) {
                if (PaymentType.PAY.getValue().equals(payment.getType())) {
                    paidAmount += payment.getPayAmount();
                    fee += payment.getServiceFee();
                } else {
                    refundedAmount += payment.getPayAmount();
                }
            }
            paidAmount *= 1000;
            fee *= 1000;
            refundedAmount *= 1000;
            info.setBasePrice(paidAmount - fee);
            info.setBasePriceInUSD(converter.convert(paidAmount - fee)
                    .doubleValue());
            info.setTotalAmount(paidAmount);
            info.setTotalAmountInUSD(converter.convert(paidAmount));
            info.setTransactionFee(paidAmount - basePrice);
            info.setTransactionFeeInUSD(converter.convert(fee));
            if (refundedAmount > 0) {
                info.setRefundedAmount(refundedAmount);
                info.setRefundedAmountInUSD(converter.convert(paidAmount));
                info.setRefundRate((int) (refundedAmount * 100 / paidAmount));
            }
        } else {
            info.setBasePrice(basePrice);
            info.setBasePriceInUSD(converter.convert(
                    BigDecimal.valueOf(basePrice)).doubleValue());
        }
        return info;
    }

    private int loadTickets(ReservationInfo info,
            final List<TicketBean> ticketBeans) {
        List<Ticket> tickets = null;
        Ticket ticket = null;
        TripBean trip = null;
        int quantity = 0;
        int index = 0;
        String[] seats = null;
        tickets = new ArrayList<ReservationInfo.Ticket>();
        info.setTickets(tickets);
        quantity += ticketBeans.get(0).getSeatPositions().size();
        for (TicketBean bean : ticketBeans) {
            ticket = info.new Ticket();
            tickets.add(ticket);
            trip = bean.getTrips().get(0);
            ticket.setId(trip.getBusStatus().getId());
            ticket.setDepartureDateInMilisec(trip.getDepartureTime().getTime());
            ticket.setDepartureDate(FormatUtils.formatDate(
                    trip.getDepartureTime(), "dd/MM/yyyy kk:mm",
                    CommonConstant.LOCALE_VN, CommonConstant.DEFAULT_TIME_ZONE));
            ticket.setDepartureStation(trip.getRouteDetails().getSegment()
                    .getStartAt().getName());
            trip = bean.getTrips().get(bean.getTrips().size() - 1);
            ticket.setArrivalDate(FormatUtils.formatDate(trip.getArrivalTime(),
                    "dd/MM/yyyy kk:mm", CommonConstant.LOCALE_VN,
                    CommonConstant.DEFAULT_TIME_ZONE));
            ticket.setArrivalStation(trip.getRouteDetails().getSegment()
                    .getEndAt().getName());
            ticket.setBusType(trip.getBusStatus().getBus().getBusType()
                    .getName());
            seats = new String[bean.getSeatPositions().size()];
            ticket.setSeats(seats);
            index = 0;
            for (SeatPositionBean seat : bean.getSeatPositions()) {
                seats[index++] = seat.getName();
            }
            ticket.setStatus(bean.getStatus());
        }
        return quantity;
    }

    public ReservationInfo createReservationInfo(
            final List<TripBean> forwardTrips,
            final List<TripBean> returnTrips, int quantity)
            throws CommonException {
        ReservationInfo info = null;
        CurrencyConverter converter = null;
        List<Ticket> tickets = null;
        double basePrice = 0;
        info = new ReservationInfo();
        info.setId(0);
        try {
            converter = CurrencyConverter.getInstance(
                    Currency.getInstance("VND"), Currency.getInstance("USD"));
        } catch (InstantiationException e) {
            LOG.error("Impossible error", e);
            throw new CommonException(e);
        } catch (IOException e) {
            // TODO handle error
            throw new CommonException(e);
        }
        tickets = new ArrayList<ReservationInfo.Ticket>();
        info.setTickets(tickets);
        tripDAO.refresh(forwardTrips);
        basePrice += ReservationUtils.addTickets(info, forwardTrips, quantity,
                false, tariffViewDAO, converter);
        if (returnTrips != null) {
            tripDAO.refresh(returnTrips);
            basePrice += ReservationUtils.addTickets(info, returnTrips,
                    quantity, true, tariffViewDAO, converter);
        }
        Collections.sort(info.getTickets());
        info.setBasePrice(basePrice);
        info.setBasePriceInUSD(converter.convert(basePrice));
        return info;
    }
}
