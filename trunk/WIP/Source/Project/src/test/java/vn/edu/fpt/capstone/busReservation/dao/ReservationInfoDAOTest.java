package vn.edu.fpt.capstone.busReservation.dao;

import java.util.List;

import org.junit.Assert;
import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationInfoBean;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

public class ReservationInfoDAOTest extends DAOTest {
    
    @Test
    public void testGetById001() {
        ReservationInfoDAO reservationInfoDAO = (ReservationInfoDAO) getBean("reservationInfoDAO");
        ReservationInfoBean bean = reservationInfoDAO.getById(1);
        Assert.assertNotNull(bean);
    }
    
    @Test
    public void testGetById002() {
        ReservationDAO reservationDAO = (ReservationDAO) getBean("reservationDAO");
        ReservationInfoDAO reservationInfoDAO = (ReservationInfoDAO) getBean("reservationInfoDAO");
        ReservationInfoBean bean = reservationInfoDAO.getById(reservationDAO.getById(1));
        Assert.assertNotNull(bean);
    }
    
    @Test
    public void testGetByUsername001() {
        ReservationInfoDAO reservationInfoDAO = (ReservationInfoDAO) getBean("reservationInfoDAO");
        List<ReservationInfoBean> beans = reservationInfoDAO.getByUsername("customer1");
        Assert.assertNotNull(beans);
        Assert.assertNotEquals(0, beans.size());
        Assert.assertNotNull(beans.get(0));
    }
}
