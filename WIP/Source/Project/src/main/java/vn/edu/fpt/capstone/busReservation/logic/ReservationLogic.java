/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.logic;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Currency;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;
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
import vn.edu.fpt.capstone.busReservation.dao.bean.SystemSettingBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean.TicketStatus;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo.Ticket;
import vn.edu.fpt.capstone.busReservation.displayModel.SimpleReservationInfo;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.CurrencyConverter;
import vn.edu.fpt.capstone.busReservation.util.ReservationUtils;
import vn.edu.fpt.capstone.busReservation.util.xml.PDFUtils;

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

    /**
     * Get simple information of all reservations that belong to a user
     * 
     * @param username
     *            booker of reservations
     * @return list of reservations
     * @throws CommonException
     */
    public List<SimpleReservationInfo> loadReservations(String username)
            throws CommonException {
        List<SimpleReservationInfo> infoList = null;
        updateReservationsStatus(username);
        infoList = ticketDAO.getSimpleInfoByUsername(username);
        Collections.sort(infoList);
        return infoList;
    }

    /**
     * Update status of all reservations booked by a user
     * 
     * @param bookerName
     *            booker's username
     */
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

    /**
     * Update a reservation status
     * 
     * @param reservationId
     *            id of the reservation to be updated
     * @return the reservation's updated status
     */
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

    /**
     * Update status of a reservation
     * 
     * @param bean
     *            a reservation with arranged tickets
     * @param timeOutInterval
     *            interval after with an unpaid reservation will be invalidated
     *            (in minutes)
     * @param lockInterval
     *            interval before departed date that a ticket can be cancelled
     *            (in days)
     */
    private void updateReservationStatus(ArrangedReservationBean bean,
            int timeOutInterval, int lockInterval) {
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
                    bean.getTicket2().getId().setStatus(stsTktPending);
                }
            }
            // if both ticket is PENDING, or one is PENDING, the other is
            // not ACTIVE or PENDING => reservation PENDING
            if ((stsPaid.equals(bean.getId().getStatus()))
                    && ((stsTktPending.equals(bean.getTicket1().getId()
                            .getStatus()) && (bean.getTicket2() == null || !stsActive
                            .equals(bean.getTicket2().getId().getStatus()))) || (!stsActive
                            .equals(bean.getTicket1().getId().getStatus()) && (bean
                            .getTicket2() != null && stsTktPending.equals(bean
                            .getTicket2().getId().getStatus()))))) {
                bean.getId().setStatus(stsRsvPending);
            }
            // if both ticket is DEPARTED, or one is DEPARTED, the other is
            // neither ACTIVE nor PENDING => reservation DEPARTED
            if ((stsTktDeparted.equals(bean.getTicket1().getId().getStatus()) && (bean
                    .getTicket2() == null || (!stsActive.equals(bean
                    .getTicket2().getId().getStatus()) && !stsTktPending
                    .equals(bean.getTicket2().getId().getStatus()))))
                    || ((!stsActive.equals(bean.getTicket1().getId()
                            .getStatus()) && !stsTktPending.equals(bean
                            .getTicket1().getId().getStatus())) && (bean
                            .getTicket2() != null && stsTktDeparted.equals(bean
                            .getTicket2().getId().getStatus())))) {
                bean.getId().setStatus(ReservationStatus.DEPARTED.getValue());
            }
        }
        reservationDAO.update(bean.getId());
    }

    /**
     * Get detailed information of a reservation
     * 
     * @param reservationId
     *            id of reservation
     * @param userId
     *            id of the reservation's booker
     * @return detailed information of the reservation
     * @throws CommonException
     */
    public ReservationInfo loadReservationInfo(final String reservationId,
            int userId) throws CommonException {
        return loadReservationInfo(Integer.parseInt(reservationId), userId);
    }

    /**
     * Get detailed information of a reservation
     * 
     * @param reservationId
     *            id of reservation
     * @param userId
     *            id of the reservation's booker
     * @return detailed information of the reservation
     * @throws CommonException
     */
    public ReservationInfo loadReservationInfo(int reservationId, int userId)
            throws CommonException {
        ReservationInfo info = null;
        List<TicketBean> tickets = null;
        tickets = ticketDAO.getTickets(reservationId);
        if (tickets != null && tickets.size() > 0) {
            if (tickets.get(0).getReservation().getBooker() != null
                    && userId == 0) {
                // unauthenticated access
                throw new CommonException("msgerrrs006");
            } else if (tickets.get(0).getReservation().getBooker() != null
                    && userId != tickets.get(0).getReservation().getBooker()
                            .getId()) {
                // unauthorized access
                throw new CommonException("msgerrrs004");
            }
            info = loadReservationInfo(tickets);
        }
        return info;
    }

    /**
     * Get detailed information of a reservation
     * 
     * @param reservationId
     *            id of reservation
     * @param userId
     *            id of the reservation's booker
     * @param calculateDiscount
     *            specify whether discount info should calculated or not
     * @return detailed information of the reservation
     * @throws CommonException
     */
    public ReservationInfo loadReservationInfo(int reservationId, int userId,
            boolean calculateDiscount) throws CommonException {
        ReservationInfo info = null;
        List<TicketBean> tickets = null;
        tickets = ticketDAO.getTickets(reservationId);
        if (tickets != null && tickets.size() > 0) {
            if (tickets.get(0).getReservation().getBooker() != null
                    && userId == 0) {
                // unauthenticated access
                throw new CommonException("msgerrrs006");
            } else if (tickets.get(0).getReservation().getBooker() != null
                    && userId != tickets.get(0).getReservation().getBooker()
                            .getId()) {
                // unauthorized access
                throw new CommonException("msgerrrs004");
            }
            info = loadReservationInfo(tickets, calculateDiscount);
        }
        return info;
    }

    /**
     * Get detailed information of a reservation<br>
     * This method does not validate the reservation's booker
     * 
     * @param reservationId
     *            id of reservation
     * @return detailed information of the reservation
     * @throws CommonException
     */
    public ReservationInfo loadReservationInfo(int reservationId)
            throws CommonException {
        ReservationInfo info = null;
        List<TicketBean> tickets = null;
        tickets = ticketDAO.getTickets(reservationId);
        if (tickets != null && tickets.size() > 0) {
            info = loadReservationInfo(tickets);
        } else {
            throw new CommonException("msgerrrs009");
        }
        return info;
    }

    /**
     * Get detailed information of a reservation
     * 
     * @param reservationCode
     *            code of the reservation
     * @param email
     *            email of reservation's booker
     * @param convertToUSD
     *            specify whether the related money amounts should be converted
     *            to USD
     * @return detailed information of the reservation
     * @throws CommonException
     */
    public ReservationInfo loadReservationInfoByCode(
            final String reservationCode, String email, boolean convertToUSD)
            throws CommonException {
        ReservationInfo info = null;
        List<TicketBean> tickets = null;
        tickets = ticketDAO.getTicketsByCode(reservationCode, email);
        if (tickets != null && tickets.size() > 0) {
            if (tickets.get(0).getReservation().getBooker() != null
                    && tickets.get(0).getReservation().getBooker().getRole()
                            .getId() != 2) {
                // unauthenticated access
                throw new CommonException("msgerrrs006");
            } else if (!email.equalsIgnoreCase(tickets.get(0).getReservation()
                    .getEmail())) {
                // unauthorized access
                throw new CommonException("msgerrrs004");
            }
            info = loadReservationInfo(tickets);
        } else {
            throw new CommonException("msgerrrs005");
        }
        return info;
    }

    /**
     * Get detailed information of a reservation from its ticket(s)
     * 
     * @param tickets
     *            tickets of the reservation
     * @return detailed information of the reservation
     * @throws CommonException
     */
    private ReservationInfo loadReservationInfo(List<TicketBean> tickets)
            throws CommonException {
        ReservationInfo info = null;
        ReservationBean reservationBean = null;
        CurrencyConverter converter = null;
        double paidAmount = 0;
        double fee = 0;
        double refundedAmount = 0;
        reservationBean = tickets.get(0).getReservation();
        updateReservationStatus(reservationBean.getId());
        info = new ReservationInfo();
        info.setId(reservationBean.getId());
        info.setCode(reservationBean.getCode());
        info.setBookerName(reservationBean.getBookerLastName() + " "
                + reservationBean.getBookerFirstName());
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
        for (TicketBean ticket : tickets) {
            ReservationUtils.addTickets(
                    info,
                    ticket,
                    (tickets.size() > 1 && ticket
                            .getTrips()
                            .get(0)
                            .getDepartureTime()
                            .after(tickets
                                    .get(tickets.size()
                                            - tickets.indexOf(ticket) - 1)
                                    .getTrips().get(0).getDepartureTime())),
                    tariffViewDAO, ticketDAO, converter);
            if (ticket.getPayments() != null && ticket.getPayments().size() > 0) {
                for (PaymentBean payment : ticket.getPayments()) {
                    if (PaymentType.PAY.getValue().equals(payment.getType())) {
                        paidAmount += payment.getPayAmount();
                        fee += payment.getServiceFee();
                    } else {
                        refundedAmount += payment.getPayAmount();
                    }
                }
            }
        }
        if (ReservationStatus.CANCELLED.getValue().equals(
                reservationBean.getStatus())
                || ReservationStatus.REFUNDED2.getValue().equals(
                        reservationBean.getStatus())) {
            for (Ticket ticket : info.getTickets()) {
                if (!CheckUtils.isNullOrBlank(ticket.getCancelReason())) {
                    info.setCancelReason(ticket.getCancelReason());
                    break;
                }
            }
        }
        paidAmount *= 1000;
        fee *= 1000;
        refundedAmount *= 1000;
        info.setTotalAmount(paidAmount);
        info.setTotalAmountInUSD(converter.convert(paidAmount));
        info.setTransactionFee(fee);
        info.setTransactionFeeInUSD(converter.convert(fee));
        if (refundedAmount > 0) {
            info.setRefundedAmount(refundedAmount);
            info.setRefundedAmountInUSD(converter.convert(refundedAmount));
            info.setRefundRate((int) (refundedAmount * 100 / paidAmount));
        }
        Collections.sort(info.getTickets());
        return info;
    }

    /**
     * Get detailed information of a reservation from its ticket(s)
     * 
     * @param tickets
     *            tickets of the reservation
     * @param calculateDiscount
     *            specify whether discount info should calculated or not
     * @return detailed information of the reservation
     * @throws CommonException
     */
    private ReservationInfo loadReservationInfo(List<TicketBean> tickets,
            boolean calculateDiscount) throws CommonException {
        ReservationInfo info = null;
        ReservationBean reservationBean = null;
        CurrencyConverter converter = null;
        double paidAmount = 0;
        double fee = 0;
        double refundedAmount = 0;
        SystemSettingBean setting = null;
        double globalDiscount = 0;
        double forwardDiscount = 0;
        double returnDiscount = 0;
        List<TripBean> trips = null;
        reservationBean = tickets.get(0).getReservation();
        if (calculateDiscount) {
            setting = systemSettingDAO
                    .getById(CommonConstant.SYSTEM_DISCOUNT_WHOLE_TRIP);
            for (TicketBean ticket : tickets) {
                trips = ticket.getTrips();
                if (tickets.size() > 1
                        && trips.get(0)
                                .getDepartureTime()
                                .after(tickets
                                        .get(tickets.size()
                                                - tickets.indexOf(ticket) - 1)
                                        .getTrips().get(0).getDepartureTime())) {
                    if (trips != null
                            && trips.size() > 0
                            && trips.size() == trips.get(0).getRouteDetails()
                                    .getRoute().getRouteDetails().size()) {
                        if (setting != null) {
                            returnDiscount = Double.parseDouble(setting
                                    .getValue());
                        }
                    }
                } else {
                    if (trips != null
                            && trips.size() > 0
                            && trips.size() == trips.get(0).getRouteDetails()
                                    .getRoute().getRouteDetails().size()) {
                        if (setting != null) {
                            forwardDiscount = Double.parseDouble(setting
                                    .getValue());
                        }
                    }
                }
            }
            info = new ReservationInfo(globalDiscount, forwardDiscount,
                    returnDiscount);
        } else {
            info = new ReservationInfo();
        }
        info.setId(reservationBean.getId());
        info.setCode(reservationBean.getCode());
        info.setBookerName(reservationBean.getBookerLastName() + " "
                + reservationBean.getBookerFirstName());
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
        for (TicketBean ticket : tickets) {
            ReservationUtils.addTickets(
                    info,
                    ticket,
                    (tickets.size() > 1 && ticket
                            .getTrips()
                            .get(0)
                            .getDepartureTime()
                            .after(tickets
                                    .get(tickets.size()
                                            - tickets.indexOf(ticket) - 1)
                                    .getTrips().get(0).getDepartureTime())),
                    tariffViewDAO, ticketDAO, converter);
            if (ticket.getPayments() != null && ticket.getPayments().size() > 0) {
                for (PaymentBean payment : ticket.getPayments()) {
                    if (PaymentType.PAY.getValue().equals(payment.getType())) {
                        paidAmount += payment.getPayAmount();
                        fee += payment.getServiceFee();
                    } else {
                        refundedAmount += payment.getPayAmount();
                    }
                }
            }
        }
        if (ReservationStatus.CANCELLED.getValue().equals(
                reservationBean.getStatus())
                || ReservationStatus.REFUNDED2.getValue().equals(
                        reservationBean.getStatus())) {
            for (Ticket ticket : info.getTickets()) {
                if (!CheckUtils.isNullOrBlank(ticket.getCancelReason())) {
                    info.setCancelReason(ticket.getCancelReason());
                    break;
                }
            }
        }
        paidAmount *= 1000;
        fee *= 1000;
        refundedAmount *= 1000;
        info.setTotalAmount(paidAmount);
        info.setTotalAmountInUSD(converter.convert(paidAmount));
        info.setTransactionFee(fee);
        info.setTransactionFeeInUSD(converter.convert(fee));
        if (refundedAmount > 0) {
            info.setRefundedAmount(refundedAmount);
            info.setRefundedAmountInUSD(converter.convert(refundedAmount));
            info.setRefundRate((int) (refundedAmount * 100 / paidAmount));
        }
        Collections.sort(info.getTickets());
        return info;
    }

    /**
     * Create detailed information of a reservation
     * 
     * @param forwardTrips
     *            the reservation's forward trips
     * @param returnTrips
     *            the reservation's return trips. Can be null
     * @param fowardQuantity
     *            the number of seats in forward trips
     * @param returnQuantity
     *            the number of seats in return trips
     * @return detailed information of the reservation
     * @throws CommonException
     */
    public ReservationInfo createReservationInfo(
            final List<TripBean> forwardTrips,
            final List<TripBean> returnTrips, int fowardQuantity,
            int returnQuantity) throws CommonException {
        ReservationInfo info = null;
        CurrencyConverter converter = null;
        SystemSettingBean setting = null;
        double globalDiscount = 0;
        double forwardDiscount = 0;
        double returnDiscount = 0;
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
        setting = systemSettingDAO
                .getById(CommonConstant.SYSTEM_DISCOUNT_WHOLE_TRIP);
        tripDAO.refresh(forwardTrips);
        if (forwardTrips.size() > 0
                && forwardTrips.size() == forwardTrips.get(0).getRouteDetails()
                        .getRoute().getRouteDetails().size()) {
            if (setting != null) {
                forwardDiscount = Double.parseDouble(setting.getValue());
            }
        }
        if (returnTrips != null) {
            tripDAO.refresh(returnTrips);
            if (returnTrips.size() > 0
                    && returnTrips.size() == returnTrips.get(0).getRouteDetails()
                            .getRoute().getRouteDetails().size()) {
                if (setting != null) {
                    returnDiscount = Double.parseDouble(setting.getValue());
                }
            }
        }
        info = new ReservationInfo(globalDiscount, forwardDiscount,
                returnDiscount);
        info.setId(0);
        ReservationUtils.addTickets(info, forwardTrips, fowardQuantity, false,
                tariffViewDAO, converter);
        if (returnTrips != null) {
            ReservationUtils.addTickets(info, returnTrips, returnQuantity,
                    true, tariffViewDAO, converter);
        }
        Collections.sort(info.getTickets());
        return info;
    }

    /**
     * Generate a pdf containing details about a reservation
     * 
     * @param reservationId
     *            id of the reservation
     * @return an input stream to the generated pdf
     * @throws CommonException
     */
    public InputStream printReservation(int reservationId)
            throws CommonException {
        OutputStream out = null;
        InputStream fileInputStream = null;
        File file = null;
        File xslt = null;
        File dir = null;
        ReservationInfo reservationInfo = null;
        try {
            xslt = new File(ReservationLogic.class.getResource(
                    "/xml/xslt/reservationinfo2fo.xsl").getPath());
            dir = new File("TEMP");
            if (!dir.exists()) {
                dir.mkdirs();
            }
            file = new File(dir, "rsv" + reservationId + ".pdf");
            out = new BufferedOutputStream(new FileOutputStream(file));
        } catch (FileNotFoundException e) {
            throw new CommonException(e);
        }
        reservationInfo = loadReservationInfo(reservationId);
        try {
            PDFUtils.convertReservationInfo2PDF(reservationInfo, xslt, file);
        } catch (Exception e) {
            throw new CommonException(e);
        } finally {
            try {
                out.close();
            } catch (IOException e) {
                throw new CommonException(e);
            }
        }
        try {
            fileInputStream = new FileInputStream(file);
        } catch (FileNotFoundException e) {
            throw new CommonException(e);
        }
        return fileInputStream;
    }
}
