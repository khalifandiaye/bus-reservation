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
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;

import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;
import vn.edu.fpt.capstone.busReservation.dao.ReservationInfoDAO;
import vn.edu.fpt.capstone.busReservation.dao.SystemSettingDAO;
import vn.edu.fpt.capstone.busReservation.dao.TariffViewDAO;
import vn.edu.fpt.capstone.busReservation.dao.TicketDAO;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.UserDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationInfoBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketInfoBean;
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
//    private static final Comparator<ReservationInfoBean> COMPARE_RESERVATION_BY_DEPARTURE_DATE = new Comparator<ReservationInfoBean>() {
//
//        @Override
//        public int compare(ReservationInfoBean o1, ReservationInfoBean o2) {
//            long date1 = 0;
//            long date2 = 0;
//            long now = 0;
//            if ((o1 == null || o1.getStartTrip() == null || o1.getStartTrip()
//                    .getDepartureTime() == null)
//                    && (o2 == null || o2.getStartTrip() == null || o2
//                            .getStartTrip().getDepartureTime() == null)) {
//                // null = null
//                return 0;
//            } else if (o1 == null || o1.getStartTrip() == null
//                    || o1.getStartTrip().getDepartureTime() == null) {
//                // null < everything
//                return -1;
//            } else if (o2 == null || o2.getStartTrip() == null
//                    || o2.getStartTrip().getDepartureTime() == null) {
//                // everything > null
//                return 1;
//            } else {
//                date1 = o1.getStartTrip().getDepartureTime().getTime();
//                date2 = o2.getStartTrip().getDepartureTime().getTime();
//                now = System.currentTimeMillis();
//                if ((date1 >= now && date2 < now)
//                        || (date1 < now && date2 >= now)) {
//                    // future date < past date
//                    return (int) (date2 - date1);
//                } else {
//                    return (int) (date1 - date2);
//                }
//            }
//        }
//    };
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
        List<TicketInfoBean> infoBeans = null;
        SimpleReservationInfo info = null;
        Integer timeOutInterval = 0;
        Integer lockInterval = 0;
        timeOutInterval = Integer.parseInt(systemSettingDAO.getById(
                "reservation.timeout").getValue());
        lockInterval = systemSettingDAO.getReservationLockTime();
        infoBeans = ticketDAO.getInfoByUsername(username);
        if (infoBeans != null && infoBeans.size() > 0) {
            Collections.sort(infoBeans);
            infoList = new ArrayList<SimpleReservationInfo>();
            for (TicketInfoBean bean : infoBeans) {
                info = loadSimpleReservationInfo(bean, timeOutInterval,
                        lockInterval);
                infoList.add(info);
            }
        }
        return infoList;
    }

    private SimpleReservationInfo loadSimpleReservationInfo(
            TicketInfoBean bean, Integer timeOutInterval, Integer lockInterval)
            throws CommonException {
        SimpleReservationInfo info = null;
        StationBean startStation = null;
        StationBean endStation = null;
        info = new SimpleReservationInfo();
        info.setId(bean.getId().getReservation().getId());
        startStation = bean.getStartTrip().getRouteDetails().getSegment()
                .getStartAt();
        endStation = bean.getEndTrip().getRouteDetails().getSegment()
                .getEndAt();
        info.setSubRouteName(startStation.getCity().getName() + " - "
                + endStation.getCity().getName());
        info.setDepartureDate(FormatUtils.formatDate(bean.getStartTrip()
                .getDepartureTime(), "dd/MM/yyyy hh:mm aa",
                CommonConstant.LOCALE_VN, CommonConstant.DEFAULT_TIME_ZONE));
        info.setBookTime(FormatUtils.formatDate(bean.getId().getReservation()
                .getBookTime(), "dd/MM/yyyy hh:mm aa",
                CommonConstant.LOCALE_VN, CommonConstant.DEFAULT_TIME_ZONE));
        info.setBookTimeInMilisec(bean.getId().getReservation().getBookTime()
                .getTime());
        info.setStatus(updateStatus(bean.getId().getReservation(), bean
                .getStartTrip().getDepartureTime(), timeOutInterval,
                lockInterval));
        return info;
    }

    public ReservationInfo loadReservationInfo(final String reservationId,
            boolean convertToUSD) throws CommonException {
        ReservationInfo info = null;
        ReservationInfoBean bean = null;
        Integer timeOutInterval = 0;
        Integer lockInterval = 0;
        timeOutInterval = Integer.parseInt(systemSettingDAO.getById(
                "reservation.timeout").getValue());
        lockInterval = systemSettingDAO.getReservationLockTime();
        bean = reservationInfoDAO.loadById(Integer.parseInt(reservationId));
        info = loadReservationInfo(bean, convertToUSD, timeOutInterval,
                lockInterval);
        return info;
    }

    public ReservationInfo loadReservationInfoByCode(
            final String reservationCode, boolean convertToUSD)
            throws CommonException {
        ReservationInfo info = null;
        ReservationInfoBean bean = null;
        Integer timeOutInterval = 0;
        Integer lockInterval = 0;
        timeOutInterval = Integer.parseInt(systemSettingDAO.getById(
                "reservation.timeout").getValue());
        lockInterval = systemSettingDAO.getReservationLockTime();
        bean = reservationInfoDAO.getByCode(reservationCode);
        info = loadReservationInfo(bean, convertToUSD, timeOutInterval,
                lockInterval);
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
            boolean convertToUSD, Integer timeOutInterval, Integer lockInterval)
            throws CommonException {
        ReservationInfo info = null;
        CurrencyConverter converter = null;
        int quantity = 0;
        int refundRate = 0;
        info = new ReservationInfo();
        info.setId(bean.getId().getId());
        info.setCode(bean.getId().getCode());
        quantity = loadTickets(info, bean.getId().getTickets());
        info.setQuantity(Integer.toString(quantity));
        // TODO first name last name order
        info.setBookerName(bean.getId().getBookerLastName() + " "
                + bean.getId().getBookerFirstName());
        info.setPhone(bean.getId().getPhone());
        info.setEmail(bean.getId().getEmail());
        info.setBasePrice(FormatUtils.formatNumber(bean.getTicketPrice(), 0,
                CommonConstant.LOCALE_VN));
        if (bean.getPaidAmount() != null) {
            info.setTotalAmount(FormatUtils.formatNumber(bean.getPaidAmount(),
                    0, CommonConstant.LOCALE_VN));
            info.setTransactionFee(FormatUtils.formatNumber(
                    bean.getPaidAmount() - quantity * bean.getTicketPrice(), 0,
                    CommonConstant.LOCALE_VN));
            info.setRefundedAmount(FormatUtils.formatNumber(
                    bean.getRefundAmount(), 0, CommonConstant.LOCALE_VN));
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
            info.setBasePriceInUSD(FormatUtils.formatNumber(
                    converter.convert(bean.getTicketPrice()), 2,
                    CommonConstant.LOCALE_VN));
            if (bean.getPaidAmount() != null) {
                info.setTotalAmountInUSD(FormatUtils.formatNumber(
                        converter.convert(bean.getPaidAmount()), 2,
                        CommonConstant.LOCALE_VN));
                info.setTransactionFeeInUSD(FormatUtils.formatNumber(converter
                        .convert(BigDecimal.valueOf(bean.getPaidAmount())
                                .subtract(
                                        BigDecimal.valueOf(quantity).multiply(
                                                BigDecimal.valueOf(bean
                                                        .getTicketPrice())))),
                        2, CommonConstant.LOCALE_VN));
                if (bean.getRefundAmount() != null
                        && bean.getRefundAmount() > 0) {
                    info.setRefundedAmountInUSD(FormatUtils.formatNumber(
                            converter.convert(bean.getRefundAmount()), 2,
                            CommonConstant.LOCALE_VN));
                    refundRate = (int) (bean.getRefundAmount() * 100 / bean
                            .getPaidAmount());
                    info.setRefundRate(Integer.toString(refundRate));
                }
            }
        }
        info.setStatus(updateStatus(bean.getId(), bean.getStartTrip()
                .getDepartureTime(), timeOutInterval, lockInterval));
        return info;
    }

    public String updateStatus(String reservationId) {
        ReservationInfoBean infoBean = null;
        Integer timeOutInterval = 0;
        Integer lockInterval = 0;
        infoBean = reservationInfoDAO.getById(Integer.parseInt(reservationId));
        timeOutInterval = Integer.parseInt(systemSettingDAO.getById(
                "reservation.timeout").getValue());
        lockInterval = systemSettingDAO.getReservationLockTime();
        return updateStatus(infoBean.getId(), infoBean.getStartTrip()
                .getDepartureTime(), timeOutInterval, lockInterval);
    }

    private String updateStatus(ReservationBean bean, Date departureTime,
            int timeOutInterval, int lockInterval) {
        Calendar timeLimit = null;
        boolean changed = true;
        Calendar pendingTime = null;
        Date today = null;
        timeLimit = Calendar.getInstance();
        timeLimit.add(Calendar.MINUTE, -timeOutInterval);
        pendingTime = Calendar.getInstance(CommonConstant.DEFAULT_TIME_ZONE,
                CommonConstant.LOCALE_VN);
        pendingTime.setTime(departureTime);
        pendingTime.add(Calendar.DATE, -lockInterval);
        today = new Date();
        if (ReservationStatus.UNPAID.getValue().equals(bean.getStatus())
                && timeLimit.getTime().after(bean.getBookTime())) {
            // status UNPAID, bookTime < timeOutLimit : DELETED
            bean.setStatus(ReservationStatus.DELETED.getValue());
        } else if (ReservationStatus.PAID.getValue().equals(bean.getStatus())
                && today.after(pendingTime.getTime())) {
            // status PAID, today > pendingTime: PENDING
            bean.setStatus(ReservationStatus.PENDING.getValue());
        } else if ((ReservationStatus.PAID.getValue().equals(bean.getStatus()) || ReservationStatus.PENDING
                .getValue().equals(bean.getStatus()))
                && today.after(departureTime)) {
            // status PAID/PENDING, today > departureTime: DEPARTED
            bean.setStatus(ReservationStatus.DEPARTED.getValue());
        } else {
            changed = false;
        }
        if (changed) {
            reservationDAO.update(bean);
        }
        return bean.getStatus();
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
            quantity += bean.getSeatPositions().size();
            seats = new String[bean.getSeatPositions().size()];
            ticket.setSeats(seats);
            index = 0;
            for (SeatPositionBean seat : bean.getSeatPositions()) {
                seats[index++] = seat.getName();
            }
        }
        return quantity;
    }

    public ReservationInfo createReservationInfo(
            final List<TripBean> tripBeanList, int quantity)
            throws CommonException {
        ReservationInfo info = null;
        CurrencyConverter converter = null;
        TripBean[] startEndTrip = null;
        Double ticketPrice = null;
        Map<Integer, TripBean[]> startEndTripMap = null;
        List<Ticket> tickets = null;
        Ticket ticket = null;
        info = new ReservationInfo();
        info.setId(0);
        tripDAO.refresh(tripBeanList);
        startEndTripMap = ReservationUtils.getStartEndTripsMap(tripBeanList);
        tickets = new ArrayList<ReservationInfo.Ticket>();
        info.setTickets(tickets);
        for (Map.Entry<Integer, TripBean[]> entry : startEndTripMap.entrySet()) {
            startEndTrip = entry.getValue();
            ticket = info.new Ticket();
            tickets.add(ticket);
            ticket.setId(entry.getKey());
            ticket.setDepartureDateInMilisec(startEndTrip[0].getDepartureTime()
                    .getTime());
            ticket.setDepartureDate(FormatUtils.formatDate(
                    startEndTrip[0].getDepartureTime(),
                    "EEEEE dd/MM/yyyy hh:mm aa", CommonConstant.LOCALE_VN,
                    CommonConstant.DEFAULT_TIME_ZONE));
            ticket.setArrivalDate(FormatUtils.formatDate(
                    startEndTrip[1].getArrivalTime(),
                    "EEEEE dd/MM/yyyy hh:mm aa", CommonConstant.LOCALE_VN,
                    CommonConstant.DEFAULT_TIME_ZONE));
            ticket.setDepartureStation(startEndTrip[0].getRouteDetails()
                    .getSegment().getStartAt().getName());
            ticket.setArrivalStation(startEndTrip[1].getRouteDetails()
                    .getSegment().getEndAt().getName());
            ticket.setBusType(entry.getValue()[0].getBusStatus().getBus()
                    .getBusType().getName());
        }
        Collections.sort(info.getTickets());
        info.setQuantity(Integer.toString(quantity));
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
        ticketPrice = tariffViewDAO.getTicketPrice(tripBeanList, new Date());
        info.setBasePrice(FormatUtils.formatNumber(ticketPrice, 0,
                CommonConstant.LOCALE_VN));
        info.setBasePriceInUSD(FormatUtils.formatNumber(
                converter.convert(BigDecimal.valueOf(ticketPrice)), 2,
                CommonConstant.LOCALE_VN));
        return info;
    }
}
