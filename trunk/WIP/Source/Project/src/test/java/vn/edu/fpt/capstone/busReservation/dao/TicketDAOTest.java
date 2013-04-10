/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotEquals;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketInfoBean;
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
    
    @Test
    public void testGetTicketInfo001() {
        TicketDAO ticketDAO = (TicketDAO) getBean("ticketDAO");
        List<TicketInfoBean> list = ticketDAO.getTicketInfoByReservationId(1115);
        assertNotNull(list);
        assertEquals(111, list.size());
    }
    
    @Test
    public void testGetTicketByBusStatusId001() {
        TicketDAO ticketDAO = (TicketDAO) getBean("ticketDAO");
//        List<TicketBean> list = ticketDAO.getTicketByBusStatusId(6);
//        assertNotNull(list);
//        assertEquals(20, list.size());
//        for (TicketBean ticket : list) {
//            assertNotNull(ticket.getPayments());
//            assertNotEquals(ticket.getPayments().size(), 0);
//        }
    }
    
    @Test
    public void testGetCancelledTicketInfos001() {
        TicketDAO ticketDAO = (TicketDAO) getBean("ticketDAO");
      List<TicketInfoBean> list = ticketDAO.getCancelledTicketInfos(6);
      assertNotNull(list);
      assertEquals(20, list.size());
    }
}
