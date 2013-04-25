/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.booking;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.apache.struts2.interceptor.SessionAware;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.dao.SeatPositionDAO;
import vn.edu.fpt.capstone.busReservation.dao.TripDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SeatInfo;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

/**
 * @author NoName
 * 
 */

public class BookingAction extends BaseAction implements SessionAware {

    /**
	 * 
	 */
    private static final long serialVersionUID = 5962554617409673584L;
    // ==================== Database Access Object ====================
    private TripDAO tripDAO;
    private SeatPositionDAO seatPositionDAO;

    public void setSeatPositionDAO(SeatPositionDAO seatPositionDAO) {
        this.seatPositionDAO = seatPositionDAO;
    }

    public void setTripDAO(TripDAO tripDAO) {
        this.tripDAO = tripDAO;
    }

    // =============================input parameter====================
    private String outBusStatus;
    private String outDepartTime;
    private String outArriveTime;
    private String rtnDepartTime;
    private String rtnArriveTime;
    private String rtnBusStatus;
    private String out_journey;
    private String rtn_journey;

    /**
     * @param rtnBusStatus
     *            the rtnBusStatus to set
     */
    public void setRtnBusStatus(String rtnBusStatus) {
        this.rtnBusStatus = rtnBusStatus;
    }

    /**
     * @param rtnDepartTime
     *            the rtnDepartTime to set
     */
    public void setRtnDepartTime(String rtnDepartTime) {
        this.rtnDepartTime = rtnDepartTime;
    }

    /**
     * @param rtnArriveTime
     *            the rtnArriveTime to set
     */
    public void setRtnArriveTime(String rtnArriveTime) {
        this.rtnArriveTime = rtnArriveTime;
    }

    /**
     * @param outDepartTime
     *            the outDepartTime to set
     */
    public void setOutDepartTime(String outDepartTime) {
        this.outDepartTime = outDepartTime;
    }

    /**
     * @param outArriveTime
     *            the outArriveTime to set
     */
    public void setOutArriveTime(String outArriveTime) {
        this.outArriveTime = outArriveTime;
    }

    /**
     * @param busStatus
     *            the busStatus to set
     */
    public void setOutBusStatus(String outBusStatus) {
        this.outBusStatus = outBusStatus;
    }

    /**
     * @param out_journey
     *            the out_journey to set
     */
    public void setOut_journey(String out_journey) {
        this.out_journey = out_journey;
    }

    /**
     * @param rtn_journey
     *            the rtn_journey to set
     */
    public void setRtn_journey(String rtn_journey) {
        this.rtn_journey = rtn_journey;
    }

    // =============================output parameter===================
    private String passengerNoOut;
    private String passengerNoReturn;
    private List<SeatInfo[][]> seatMapOut;
    private List<SeatInfo[][]> seatMapReturn;
    private String message;
    private String selectedOutSeat;
    private String selectedReturnSeat;

    /**
     * @return the passengerNoOut
     */
    public String getPassengerNoOut() {
        return passengerNoOut;
    }

    /**
     * @return the passengerNoReturn
     */
    public String getPassengerNoReturn() {
        return passengerNoReturn;
    }

    /**
     * @return the selectedOutSeat
     */
    public String getSelectedOutSeat() {
        return selectedOutSeat;
    }

    /**
     * @return the selectedReturnSeat
     */
    public String getSelectedReturnSeat() {
        return selectedReturnSeat;
    }

    /**
     * @return the seatMapOut
     */
    public List<SeatInfo[][]> getSeatMapOut() {
        return seatMapOut;
    }

    /**
     * @return the seatMapReturn
     */
    public List<SeatInfo[][]> getSeatMapReturn() {
        return seatMapReturn;
    }

    /**
     * @return the message
     */
    public String getMessage() {
        return message;
    }

    private List<SeatInfo> getSeatsList(List<TripBean> listTripBean) {
        List<SeatInfo> seats = new ArrayList<SeatInfo>();
        List<String> listSoldSeat = seatPositionDAO.getSoldSeats(listTripBean);

        for (String string : listSoldSeat) {
            SeatInfo tmp = new SeatInfo(string, "1");
            seats.add(tmp);
        }

        return seats;
    }

    private List<SeatInfo[][]> buildSeatMap(List<TripBean> listTripBean) {
        if (listTripBean == null) {
            return null;
        }
        List<SeatInfo> seats = getSeatsList(listTripBean);
        int tmpBustType = listTripBean.get(0).getBusStatus().getBus()
                .getBusType().getId();
        String[] bigText = { "A", "B", "C", "D", "E" };

        List<SeatInfo[][]> listSeatMap = new ArrayList<SeatInfo[][]>();

        if (tmpBustType == 1) {
            SeatInfo[][] tmpSeatMap = new SeatInfo[5][11];

            for (int i = 0; i < 5; i++) {
                if (i != 2) {
                    for (int j = 0; j < 11; j++) {
                        String seatNum = bigText[i] + Integer.toString(11 - j);
                        String status = "0";
                        for (int k = 0; k < seats.size(); k++) {
                            if (seats.get(k).getName().equals(seatNum)) {
                                status = "1";
                            }
                        }
                        tmpSeatMap[i][j] = new SeatInfo(seatNum, status);
                    }
                } else {
                    // Bonus seat
                    String seatNum = bigText[i] + Integer.toString(1);
                    String status = "0";
                    for (int k = 0; k < seats.size(); k++) {
                        if (seats.get(k).getName().equals(seatNum)) {
                            status = "1";
                        }
                    }
                    tmpSeatMap[i][0] = new SeatInfo(seatNum, status);
                }
            }
            listSeatMap.add(tmpSeatMap);
        } else {
            SeatInfo[][] tmpSeatMapUp = new SeatInfo[5][6];
            SeatInfo[][] tmpSeatMapDown = new SeatInfo[5][6];
            for (int i = 0; i < 5; i++) {
                if (i != 1 && i != 3) {
                    for (int j = 0; j < 12; j++) {
                        String seatNum = bigText[i] + Integer.toString(12 - j);
                        String status = "0";
                        for (int k = 0; k < seats.size(); k++) {
                            if (seats.get(k).getName().equals(seatNum)) {
                                status = "1";
                            }
                        }
                        if (j < 6) {
                            tmpSeatMapDown[i][j] = new SeatInfo(seatNum, status);
                        } else {
                            tmpSeatMapUp[i][j - 6] = new SeatInfo(seatNum,
                                    status);
                        }
                    }
                } else {
                    for (int j = 0; j < 2; j++) {
                        String seatNum = bigText[i] + Integer.toString(j + 1);
                        String status = "0";
                        for (int k = 0; k < seats.size(); k++) {
                            if (seats.get(k).getName().equals(seatNum)) {
                                status = "1";
                            }
                        }
                        if (j == 0) {
                            tmpSeatMapUp[i][j] = new SeatInfo(seatNum, status);
                        } else {
                            tmpSeatMapDown[i][j] = new SeatInfo(seatNum, status);
                        }
                    }
                }
            }
            listSeatMap.add(tmpSeatMapDown);
            listSeatMap.add(tmpSeatMapUp);
        }
        return listSeatMap;
    }

    @SuppressWarnings("unchecked")
    public String execute() {

        List<TripBean> listOutTripBean = null;
        List<TripBean> listReturnTripBean = null;

        if (!CheckUtils.isNullOrBlank(outBusStatus)
                || !CheckUtils.isNullOrBlank(rtnBusStatus)) {
            if (session.containsKey("listOutTripBean")) {
                session.remove("listOutTripBean");
            }
            if (session.containsKey("listReturnTripBean")) {
                session.remove("listReturnTripBean");
            }
            if (!CheckUtils.isNullOrBlank(out_journey)
                    && out_journey.equalsIgnoreCase("on")
                    && CheckUtils.isNullOrBlank(rtn_journey)) {
                int busStatus = Integer.parseInt(outBusStatus);
                listOutTripBean = tripDAO.getBookingTrips(busStatus,
                        outDepartTime, outArriveTime);
                // check bus is departed or not
                if (!checkBusDepartTime(listOutTripBean)) {
                    return ERROR;
                }
                session.put("listOutTripBean", listOutTripBean);

                List<String> listSoldSeat = seatPositionDAO
                        .getSoldSeats(listOutTripBean);
                this.passengerNoOut = (listOutTripBean.get(0).getBusStatus()
                        .getBus().getBusType().getNumberOfSeats() - listSoldSeat
                        .size()) + "";
                session.put("passengerNoOut", passengerNoOut);
            } else if (!CheckUtils.isNullOrBlank(rtn_journey)
                    && rtn_journey.equalsIgnoreCase("on")
                    && CheckUtils.isNullOrBlank(out_journey)) {
                int busStatus = Integer.parseInt(rtnBusStatus);
                listOutTripBean = tripDAO.getBookingTrips(busStatus,
                        rtnDepartTime, rtnArriveTime);
                // check bus is departed or not
                if (!checkBusDepartTime(listOutTripBean)) {
                    return ERROR;
                }
                session.put("listOutTripBean", listOutTripBean);

                List<String> listSoldSeat = seatPositionDAO
                        .getSoldSeats(listOutTripBean);
                this.passengerNoOut = (listOutTripBean.get(0).getBusStatus()
                        .getBus().getBusType().getNumberOfSeats() - listSoldSeat
                        .size()) + "";
                session.put("passengerNoOut", passengerNoOut);
            } else if (!CheckUtils.isNullOrBlank(rtn_journey)
                    && rtn_journey.equalsIgnoreCase("on")
                    && !CheckUtils.isNullOrBlank(out_journey)
                    && out_journey.equalsIgnoreCase("on")) {
                int busStatusOut = Integer.parseInt(outBusStatus);
                int busStatusRtn = Integer.parseInt(rtnBusStatus);
                listOutTripBean = tripDAO.getBookingTrips(busStatusOut,
                        outDepartTime, outArriveTime);
                // check bus is departed or not
                if (!checkBusDepartTime(listOutTripBean)) {
                    return ERROR;
                }
                session.put("listOutTripBean", listOutTripBean);
                listReturnTripBean = tripDAO.getBookingTrips(busStatusRtn,
                        rtnDepartTime, rtnArriveTime);
                session.put("listReturnTripBean", listReturnTripBean);
                // check bus is departed or not
                if (!checkBusDepartTime(listReturnTripBean)) {
                    return ERROR;
                }
                List<String> listSoldSeatOut = seatPositionDAO
                        .getSoldSeats(listOutTripBean);
                List<String> listSoldSeatReturn = seatPositionDAO
                        .getSoldSeats(listReturnTripBean);
                // Set remain seat for 2 trips
                this.passengerNoOut = (listOutTripBean.get(0).getBusStatus()
                        .getBus().getBusType().getNumberOfSeats() - listSoldSeatOut
                        .size()) + "";
                this.passengerNoReturn = (listReturnTripBean.get(0)
                        .getBusStatus().getBus().getBusType()
                        .getNumberOfSeats() - listSoldSeatReturn.size())
                        + "";
                session.put("passengerNoOut", passengerNoOut);
                session.put("passengerNoReturn", passengerNoReturn);
            }
        } else if (session.containsKey("listOutTripBean")
                || session.containsKey("listReturnTripBean")) {
            // redirect from some where
            if (session.containsKey("redirectFrom")) {
                if ("bookingPay".equals((String) session.get("redirectFrom"))) {
                    if (session.containsKey("listOutTripBean")) {
                        listOutTripBean = (List<TripBean>) session
                                .get("listOutTripBean");
                        List<String> listSoldSeatOut = seatPositionDAO
                                .getSoldSeats(listOutTripBean);
                        this.passengerNoOut = (listOutTripBean.get(0)
                                .getBusStatus().getBus().getBusType()
                                .getNumberOfSeats() - listSoldSeatOut.size())
                                + "";
                    }
                    if (session.containsKey("listReturnTripBean")) {
                        listReturnTripBean = (List<TripBean>) session
                                .get("listReturnTripBean");
                        List<String> listSoldSeatReturn = seatPositionDAO
                                .getSoldSeats(listReturnTripBean);
                        this.passengerNoReturn = (listReturnTripBean.get(0)
                                .getBusStatus().getBus().getBusType()
                                .getNumberOfSeats() - listSoldSeatReturn.size())
                                + "";
                    }
                    session.remove("redirectFrom");
                }
            } else {
                session.remove("listOutTripBean");
                session.remove("listReturnTripBean");

                session.remove("message");
                session.remove("seatsOutDouble");
                session.remove("seatsReturnDouble");
                return ERROR;
            }
        }

        if (session != null
                && (session.containsKey("seatsOutDouble") || session
                        .containsKey("seatsReturnDouble"))) {

            String selOutSeat = (String) session.get("selectedOutSeat");
            String selReturnSeat = (String) session.get("selectedReturnSeat");
            String[] listOutSeats = selOutSeat.split(";");
            String[] listReturnSeats = selReturnSeat.split(";");

            List<String> listOutDouble = (List<String>) session
                    .get("seatsOutDouble");
            List<String> listReturnDouble = (List<String>) session
                    .get("seatsReturnDouble");

            String nwOutSeat = "";
            String nwReturnSeat = "";
            if (listOutDouble != null) {
                for (String string : listOutSeats) {
                    if (!listOutDouble.contains(string)) {
                        nwOutSeat += string + ";";
                    }
                }
            }
            if (listReturnDouble != null) {
                for (String string : listReturnSeats) {
                    if (!listReturnDouble.contains(string)) {
                        nwReturnSeat += string + ";";
                    }
                }
            }
            this.selectedOutSeat = nwOutSeat;
            this.selectedReturnSeat = nwReturnSeat;

            this.message = (String) session.get("message");

            session.remove("message");
            session.remove("seatsOutDouble");
            session.remove("seatsReturnDouble");
        }
        if (listOutTripBean != null) {
            seatMapOut = buildSeatMap(listOutTripBean);
        }
        if (listReturnTripBean != null) {
            seatMapReturn = buildSeatMap(listReturnTripBean);
        }
        return SUCCESS;
    }

    public boolean checkBusDepartTime(List<TripBean> listTripBean) {
        Calendar timeLimit = Calendar.getInstance();
        timeLimit.add(Calendar.MINUTE, +CommonConstant.MIN_TIME_BEFORE_DEPART);
        if (listTripBean.get(0).getDepartureTime().getTime() < timeLimit
                .getTime().getTime()) {
            // session.put("message", getText("msg_booking006"));
            return false;
        }
        return true;
    }
}
