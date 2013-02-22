/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.logic;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Currency;
import java.util.Date;
import java.util.List;

import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;
import vn.edu.fpt.capstone.busReservation.dao.ReservationInfoDAO;
import vn.edu.fpt.capstone.busReservation.dao.TariffViewDAO;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.UserDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationInfoBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.StationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
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
    private static final Comparator<ReservationInfoBean> COMPARE_RESERVATION_BY_DEPARTURE_DATE = new Comparator<ReservationInfoBean>() {

        @Override
        public int compare(ReservationInfoBean o1, ReservationInfoBean o2) {
            return o1 == null || o1.getStartTrip() == null
                    || o1.getStartTrip().getDepartureTime() == null ? -1
                    : o2 == null || o2.getStartTrip() == null
                            || o2.getStartTrip().getDepartureTime() == null ? 1
                            : o1.getStartTrip()
                                    .getDepartureTime()
                                    .compareTo(
                                            o2.getStartTrip()
                                                    .getDepartureTime());
        }
    };
    // =====================Database Access Object=====================
    private UserDAO userDAO;
    private ReservationInfoDAO reservationInfoDAO;
    private TariffViewDAO tariffViewDAO;
    private TripDAO tripDAO;
    private ReservationDAO reservationDAO;

    /**
     * @param userDAO
     *            the userDAO to set
     */
    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    /**
     * @param reservationInfoDAO
     *            the reservationInfoDAO to set
     */
    public void setReservationInfoDAO(ReservationInfoDAO reservationInfoDAO) {
        this.reservationInfoDAO = reservationInfoDAO;
    }

    /**
     * @param tariffViewDAO
     *            the tariffViewDAO to set
     */
    public void setTariffViewDAO(TariffViewDAO tariffViewDAO) {
        this.tariffViewDAO = tariffViewDAO;
    }

    /**
     * @param tripDAO
     *            the tripDAO to set
     */
    public void setTripDAO(TripDAO tripDAO) {
        this.tripDAO = tripDAO;
    }

    /**
     * @param reservationDAO
     *            the reservationDAO to set
     */
    public void setReservationDAO(ReservationDAO reservationDAO) {
        this.reservationDAO = reservationDAO;
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

    public List<ReservationInfo> loadReservations(String username)
            throws CommonException {
        List<ReservationInfo> infoList = null;
        List<ReservationInfoBean> infoBeans = null;
        ReservationInfo info = null;
        infoBeans = reservationInfoDAO.getByUsername(username);
        if (infoBeans != null && infoBeans.size() > 0) {
            Collections.sort(infoBeans, COMPARE_RESERVATION_BY_DEPARTURE_DATE);
            infoList = new ArrayList<ReservationInfo>();
            for (ReservationInfoBean bean : infoBeans) {
                info = loadReservationInfo(bean);
                infoList.add(info);
            }
        }
        return infoList;
    }

    public ReservationInfo loadReservationInfo(final String reservationId)
            throws CommonException {
        ReservationInfo info = null;
        ReservationInfoBean bean = null;
        bean = reservationInfoDAO.loadById(Integer.parseInt(reservationId));
        info = loadReservationInfo(bean);
        return info;
    }

    public ReservationInfo loadReservationInfoByCode(
            final String reservationCode) throws CommonException {
        ReservationInfo info = null;
        ReservationInfoBean bean = null;
        bean = reservationInfoDAO.getByCode(reservationCode);
        info = loadReservationInfo(bean);
        return info;
    }

    private ReservationInfo loadReservationInfo(ReservationInfoBean bean)
            throws CommonException {
        ReservationInfo info = null;
        StationBean startStation = null;
        StationBean endStation = null;
        CurrencyConverter converter = null;
        int quantity = 0;
        info = new ReservationInfo();
        info.setId(bean.getId().getId());
        startStation = bean.getStartTrip().getRouteDetails().getSegment()
                .getStartAt();
        endStation = bean.getStartTrip().getRouteDetails().getSegment()
                .getEndAt();
        info.setSubRouteName(startStation.getCity().getName() + " - "
                + endStation.getCity().getName());
        info.setDepartureDate(FormatUtils.formatDate(bean.getStartTrip()
                .getDepartureTime(), "EEEEE dd/MM/yyyy hh:mm aa",
                CommonConstant.LOCALE_VN, CommonConstant.DEFAULT_TIME_ZONE));
        info.setArrivalDate(FormatUtils.formatDate(bean.getEndTrip()
                .getArrivalTime(), "EEEEE dd/MM/yyyy hh:mm aa",
                CommonConstant.LOCALE_VN, CommonConstant.DEFAULT_TIME_ZONE));
        info.setDepartureStationAddress(startStation.getAddress());
        info.setArrivalStationAddress(endStation.getAddress());
        info.setSeatNumbers(getSeatNumbers(bean.getId().getSeatPositions()));
        quantity = bean.getId().getSeatPositions().size();
        info.setQuantity(Integer.toString(quantity));
        // TODO first name last name order
        info.setBookerName(bean.getId().getBookerLastName() + " "
                + bean.getId().getBookerFirstName());
        info.setPhone(bean.getId().getPhone());
        info.setEmail(bean.getId().getEmail());
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
        info.setBasePrice(FormatUtils.formatNumber(bean.getTicketPrice(), 0,
                CommonConstant.LOCALE_VN));
        info.setBasePriceInUSD(FormatUtils.formatNumber(
                converter.convert(BigDecimal.valueOf(bean.getTicketPrice())),
                2, CommonConstant.LOCALE_VN));
        if (bean.getPaidAmount() != null) {
            info.setTotalAmount(FormatUtils.formatNumber(bean.getPaidAmount(),
                    0, CommonConstant.LOCALE_VN));
            info.setTotalAmountInUSD(FormatUtils.formatNumber(
                    converter.convert(BigDecimal.valueOf(bean.getPaidAmount())),
                    2, CommonConstant.LOCALE_VN));
            info.setTransactionFee(FormatUtils.formatNumber(
                    bean.getPaidAmount() - quantity * bean.getTicketPrice(), 0,
                    CommonConstant.LOCALE_VN));
            info.setTransactionFeeInUSD(FormatUtils.formatNumber(
                    converter.convert(BigDecimal.valueOf(bean.getPaidAmount())
                            .subtract(
                                    BigDecimal.valueOf(quantity).multiply(
                                            BigDecimal.valueOf(bean
                                                    .getTicketPrice())))), 2,
                    CommonConstant.LOCALE_VN));
        }
        info.setStatus(updateStatus(bean.getId(), bean.getStartTrip()
                .getDepartureTime()));
        return info;
    }

    public String updateStatus(String reservationId) {
        ReservationInfoBean infoBean = reservationInfoDAO.getById(Integer
                .parseInt(reservationId));
        return updateStatus(infoBean.getId(), infoBean.getStartTrip()
                .getDepartureTime());
    }

    private String updateStatus(ReservationBean bean, Date departureTime) {
        Calendar timeLimit = null;
        timeLimit = Calendar.getInstance();
        timeLimit.add(Calendar.MINUTE, -CommonConstant.RESERVATION_TIMEOUT);
        if (ReservationStatus.UNPAID.getValue().equals(bean.getStatus())
                && timeLimit.getTime().after(bean.getBookTime())) {
            bean.setStatus(ReservationStatus.DELETED.getValue());
            reservationDAO.update(bean);
        } else if ((ReservationStatus.PAID.getValue().equals(bean.getStatus()) || ReservationStatus.UNPAID
                .getValue().equals(bean.getStatus()))
                && new Date().after(departureTime)) {
            bean.setStatus(ReservationStatus.DEPARTED.getValue());
            reservationDAO.update(bean);
        }
        return bean.getStatus();
    }

    private String getSeatNumbers(final List<SeatPositionBean> seatPositions) {
        StringBuilder result = null;
        result = new StringBuilder();
        for (SeatPositionBean seatPosition : seatPositions) {
            result.append(" " + seatPosition.getId().getName());
        }
        // remove first space
        result.delete(0, 1);
        return result.toString();
    }

    public ReservationInfo createReservationInfo(
            final List<TripBean> tripBeanList, int quantity)
            throws CommonException {
        ReservationInfo info = null;
        StationBean startStation = null;
        StationBean endStation = null;
        CurrencyConverter converter = null;
        TripBean[] startEndTrip = null;
        Double ticketPrice = null;
        info = new ReservationInfo();
        info.setId(0);
        tripDAO.refresh(tripBeanList);
        startEndTrip = ReservationUtils.getStartEndTrips(tripBeanList);
        startStation = startEndTrip[0].getRouteDetails().getSegment()
                .getStartAt();
        endStation = startEndTrip[1].getRouteDetails().getSegment().getEndAt();
        info.setSubRouteName(startStation.getCity().getName() + " - "
                + endStation.getCity().getName());
        info.setDepartureDate(FormatUtils.formatDate(
                startEndTrip[0].getDepartureTime(),
                "EEEEE dd/MM/yyyy hh:mm aa", CommonConstant.LOCALE_VN,
                CommonConstant.DEFAULT_TIME_ZONE));
        info.setArrivalDate(FormatUtils.formatDate(
                startEndTrip[1].getArrivalTime(), "EEEEE dd/MM/yyyy hh:mm aa",
                CommonConstant.LOCALE_VN, CommonConstant.DEFAULT_TIME_ZONE));
        info.setDepartureStationAddress(startStation.getAddress());
        info.setArrivalStationAddress(endStation.getAddress());
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
