/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.testUtil;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.StaleObjectStateException;
import org.junit.After;
import org.junit.Before;

import vn.edu.fpt.capstone.busReservation.dao.bean.AbstractBean;

/**
 * Abstract class that open transaction during testing NOTE: all database
 * changes will be reversed after a test has finished
 * 
 * @author Yoshimi
 * 
 */
public abstract class DAOTest extends SpringTest {
    protected static Log LOG = LogFactory.getLog(DAOTest.class);

    @Before
    public void start() {
        SessionFactory sessionFactory = (SessionFactory) getBean("sessionFactory");
        LOG.debug("Starting a database transaction");
        sessionFactory.getCurrentSession().beginTransaction();
    }

    @After
    public void end() {
        SessionFactory sessionFactory = (SessionFactory) getBean("sessionFactory");
        Session session = sessionFactory.getCurrentSession();
        try {
            if (session.getTransaction().isActive()) {
                LOG.debug("Trying to rollback database transaction after testing");
                session.getTransaction().rollback();
            } else {
                LOG.error("The database transaction has been comnitted somewhere else");
            }
        } catch (Throwable rbEx) {
            LOG.error("Could not rollback transaction after testing!", rbEx);
        } finally {
            // session.close();
            // LOG.debug("The database session has been closed");
        }

//        try {
//            // Commit and cleanup
//            if (sessionFactory.getCurrentSession().getTransaction().isActive()
//                    && !sessionFactory.getCurrentSession().getTransaction()
//                            .wasCommitted()) {
//                LOG.debug("Committing the database transaction");
//                sessionFactory.getCurrentSession().getTransaction().commit();
//            } else {
//                LOG.debug("The database transaction has been comnitted somewhere else");
//            }
//
//        } catch (StaleObjectStateException staleEx) {
//            LOG.error("This interceptor does not implement optimistic concurrency control!");
//            LOG.error("Your application will not work until you add compensation actions!");
//            // Rollback, close everything, possibly compensate for any permanent
//            // changes
//            // during the conversation, and finally restart business
//            // conversation. Maybe
//            // give the user of the application a chance to merge some of his
//            // work with
//            // fresh data... what you do here depends on your applications
//            // design.
//            throw staleEx;
//        } catch (Throwable ex) {
//            // Rollback only
//            ex.printStackTrace();
//            try {
//                if (sessionFactory.getCurrentSession().getTransaction()
//                        .isActive()) {
//                    LOG.debug("Trying to rollback database transaction after exception");
//                    sessionFactory.getCurrentSession().getTransaction()
//                            .rollback();
//                } else {
//                    LOG.debug("The database transaction is longer active");
//                }
//            } catch (Throwable rbEx) {
//                LOG.error("Could not rollback transaction after exception!",
//                        rbEx);
//            }
//        } finally {
//            sessionFactory.getCurrentSession().close();
//            LOG.debug("The database session has been closed");
//        }
    }

    /**
     * Delete a list of existing entities in the database.<br>
     * WARNING: only use this method for the purpose of testing
     * 
     * @param tList
     *            list of entities to be updated
     * @throws HibernateException
     *             Indicates a problem either translating the criteria to SQL,
     *             executing the SQL or processing the SQL results.
     */
    protected void delete(List<? extends AbstractBean<?>> tList) {
        SessionFactory sessionFactory = (SessionFactory) getBean("sessionFactory");
        Session session = sessionFactory.getCurrentSession();
        try {
            // perform database access (query, insert, update, etc) here
            for (AbstractBean<?> t : tList) {
                session.delete(t);
            }
        } catch (HibernateException e) {
            exceptionHandling(e, session);
        }
    }

    /**
     * Common database exception handling
     * 
     * @param e
     *            the occurred exception
     * @param session
     *            the active session
     * @throws HibernateException
     *             the occurred exception
     */
    private void exceptionHandling(HibernateException e, Session session) {
        try {
            if (session.getTransaction().isActive()) {
                log.debug("Trying to rollback database transaction after exception");
                session.getTransaction().rollback();
            }
        } catch (Throwable rbEx) {
            log.error("Could not rollback transaction after exception!", rbEx);
        }
        throw e;
    }
}
