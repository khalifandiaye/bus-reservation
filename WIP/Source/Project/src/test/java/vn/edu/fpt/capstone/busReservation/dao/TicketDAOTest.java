/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.TicketInfoBean;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

/**
 * @author Yoshimi
 *
 */
public class TicketDAOTest extends DAOTest {
    @Test
    public void testGetInfoByUsername001() {
        TicketDAO ticketDAO = (TicketDAO) getBean("ticketDAO");
        List<TicketInfoBean> ticketInfoBeans = ticketDAO.getInfoByUsername("customer1");
        assertNotNull(ticketInfoBeans);
    }
}
