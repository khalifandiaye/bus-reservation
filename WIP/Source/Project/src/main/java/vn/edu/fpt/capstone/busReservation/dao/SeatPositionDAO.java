package vn.edu.fpt.capstone.busReservation.dao;

import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionKey;

public class SeatPositionDAO extends
        GenericDAO<SeatPositionKey, SeatPositionBean> {

    public SeatPositionDAO(Class<SeatPositionBean> clazz) {
        super(clazz);
        // TODO Auto-generated constructor stub
    }

}
