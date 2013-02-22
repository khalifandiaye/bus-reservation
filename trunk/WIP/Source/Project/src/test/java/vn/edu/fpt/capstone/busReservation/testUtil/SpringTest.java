package vn.edu.fpt.capstone.busReservation.testUtil;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Assert;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;


public class SpringTest {
    protected static Log log = LogFactory.getLog(SpringTest.class);
    private final static ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext.xml");
    protected static Object getBean(String name) {
	return context.getBean(name);
    }
    
//    @Test
    public void testGetBean() {
	Object result = null;
	result = getBean("reservationDAO");
	Assert.assertEquals(ReservationDAO.class, result.getClass());
    }
}
