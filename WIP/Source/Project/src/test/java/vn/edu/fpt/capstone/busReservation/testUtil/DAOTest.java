/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.testUtil;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.SessionFactory;
import org.junit.AfterClass;
import org.junit.BeforeClass;

/**
 * @author Yoshimi
 * 
 */
public class DAOTest extends SpringTest {
    private static Log log = LogFactory.getLog(DAOTest.class);

    @BeforeClass
    public static void start() {
        SessionFactory sessionFactory = (SessionFactory) getBean("sessionFactory");
        log.debug("Starting a database transaction");
        sessionFactory.getCurrentSession().beginTransaction();
    }

    @AfterClass
    public static void end() {
        SessionFactory sessionFactory = (SessionFactory) getBean("sessionFactory");
        log.debug("Committing the database transaction");
        if (sessionFactory.getCurrentSession().getTransaction().isActive()
                && !sessionFactory.getCurrentSession().getTransaction()
                        .wasCommitted()) {
            sessionFactory.getCurrentSession().getTransaction().commit();
        } else {
            log.debug("The database transaction has been comnitted somewhere else");
        }
    }
}
