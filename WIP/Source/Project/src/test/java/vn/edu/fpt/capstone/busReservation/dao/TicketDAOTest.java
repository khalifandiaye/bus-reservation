/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.ArrangedReservationBean;
import vn.edu.fpt.capstone.busReservation.displayModel.SimpleReservationInfo;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

/**
 * @author Yoshimi
 *
 */
public class TicketDAOTest extends DAOTest {
    @Test
    public void testGetInfoByUsername001() {
        TicketDAO ticketDAO = (TicketDAO) getBean("ticketDAO");
        List<SimpleReservationInfo> list = ticketDAO.getSimpleInfoByUsername("customer1");
        assertNotNull(list);
        assertEquals(111, list.size());
    }
}