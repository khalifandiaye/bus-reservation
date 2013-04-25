/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import static org.junit.Assert.assertEquals;

import java.util.Date;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.BusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.BusStatusBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.displayModel.BusStatus;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

/**
 * @author Yoshimi
 * 
 */
public class BusStatusDAOTest extends DAOTest {
    @Test
    public void testGetAll001() {
        BusStatusDAO busStatusDAO = (BusStatusDAO) getBean("busStatusDAO");
        List<BusStatusBean> beans = busStatusDAO.getAll();
        Assert.assertNotNull(beans);
        Assert.assertNotEquals(0, beans.size());
        Assert.assertNotNull(beans.get(0));
        Assert.assertNotEquals(0, beans.get(0).getTrips().size());
    }

    @Test
    public void testUpdate001() {
        BusStatusDAO busStatusDAO = (BusStatusDAO) getBean("busStatusDAO");
        List<BusStatusBean> beans = busStatusDAO.getAll();
        List<TripBean> trips = null;
        for (BusStatusBean bs : beans) {
            trips = bs.getTrips();
            bs.setFromDate(trips.get(0).getDepartureTime());
            bs.setToDate(trips.get(trips.size() - 1).getArrivalTime());
        }
        busStatusDAO.update(beans);
    }

    @Test
    public void getAllBusStatusTest001() {
        BusStatusDAO busStatusDAO = (BusStatusDAO) getBean("busStatusDAO");
        List<BusStatus> list = busStatusDAO.getAllBusStatus(true, null);
        List<BusBean> buses = ((BusDAO) getBean("busDAO")).getAll();
        assertEquals(buses.size(), list.size());
    }

    @Test
    public void getAllBusStatusTest002() {
        BusStatusDAO busStatusDAO = (BusStatusDAO) getBean("busStatusDAO");
        List<BusStatus> list = busStatusDAO.getAllBusStatus(false, new Date());
        List<BusBean> buses = ((BusDAO) getBean("busDAO")).getAll();
        assertEquals(buses.size(), list.size());
    }
}
