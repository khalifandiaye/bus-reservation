/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.logic;

import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

/**
 * @author Yoshimi
 *
 */
public class PaymentLogicTest extends DAOTest {
    @Test
    public void testSendCancelReservationMail001() throws CommonException {
        String contextPath = "/bus-reservation";
        PaymentLogic paymentLogic = (PaymentLogic) getBean("paymentLogic");
        paymentLogic.sendCancelReservationMail(1115, contextPath);
    }
    
    @Test
    public void testsendReservationCompleteMail001() throws CommonException {
        String contextPath = "/bus-reservation";
        PaymentLogic paymentLogic = (PaymentLogic) getBean("paymentLogic");
        paymentLogic.sendReservationCompleteMail(24, contextPath);
    }

}
