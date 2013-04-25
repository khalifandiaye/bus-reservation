/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.TripBean;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

/**
 * @author Yoshimi
 *
 */
public class TariffViewDAOTest extends DAOTest {
    @Test
    public void testGetTicketPrice001() {
        TripDAO tripDAO = (TripDAO) getBean("tripDAO");
        List<TripBean> trips = new ArrayList<TripBean>();
        trips.add(tripDAO.getById(7));
        trips.add(tripDAO.getById(8));
        trips.add(tripDAO.getById(9));
        TariffViewDAO tariffViewDAO = (TariffViewDAO) getBean("tariffViewDAO");
        Double ticketPrice = tariffViewDAO.getTicketPrice(trips, new Date());
//        assertNotNull(ticketPrice);
//        assertNotEquals(0, ticketPrice);
//        System.out.println(ticketPrice);
    }
}
