/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.BusFreeTimeBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.RouteTerminalBean;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

/**
 * @author Yoshimi
 *
 */
public class RouteTerminalDAOTest extends DAOTest {
    
    @Test
    public void testGetAll001() {
        try {
        RouteTerminalDAO routeTerminalDAO = (RouteTerminalDAO) getBean("routeTerminalDAO");
        List<RouteTerminalBean> beans = routeTerminalDAO.getAll();
        assertNotNull(beans);
        assertNotEquals(0, beans.size());
        } catch (RuntimeException e) {
            e.printStackTrace();
            throw e;
        }
    }

}