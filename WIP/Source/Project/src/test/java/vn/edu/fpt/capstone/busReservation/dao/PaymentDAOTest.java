/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.dao;

import static org.junit.Assert.*;

import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentBean.PaymentType;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentMethodBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketBean;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

/**
 * @author Yoshimi
 * 
 */
public class PaymentDAOTest extends DAOTest {
    @Test
    public void insertTest001() {
        PaymentDAO paymentDAO = (PaymentDAO) getBean("paymentDAO");
        PaymentBean paymentBean = new PaymentBean();
        PaymentMethodBean paymentMethod = ((PaymentMethodDAO) getBean("paymentMethodDAO"))
                .getById(2);
        TicketBean ticket = ((TicketDAO) getBean("ticketDAO")).getById(7);
        int id = 0;
        paymentBean.setPayAmount(300);
        paymentBean.setPaymentMethod(paymentMethod);
        paymentBean.setTransactionId("testTransaction");
        paymentBean.setServiceFee(30);
        paymentBean.setTicket(ticket);
        paymentBean.setType(PaymentType.PAY.getValue());
        id = (Integer) paymentDAO.insert(paymentBean);
        assertNotEquals(0, id);
        paymentBean = paymentDAO.getById(id);
        assertNotNull(paymentBean);
    }
}
