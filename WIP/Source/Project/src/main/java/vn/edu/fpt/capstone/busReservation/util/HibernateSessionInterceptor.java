/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.SessionFactory;
import org.hibernate.StaleObjectStateException;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

/**
 * @author Yoshimi
 * 
 */
public class HibernateSessionInterceptor implements Interceptor {

    /**
     * 
     */
    private static final long serialVersionUID = 8855154057096678551L;
    protected static Log LOG = LogFactory
            .getLog(HibernateSessionRequestFilter.class);
    private SessionFactory sessionFactory;

    /*
     * (non-Javadoc)
     * 
     * @see com.opensymphony.xwork2.interceptor.Interceptor#destroy()
     */
    @Override
    public void destroy() {
        // do nothing
    }

    /*
     * (non-Javadoc)
     * 
     * @see com.opensymphony.xwork2.interceptor.Interceptor#init()
     */
    @Override
    public void init() {
        // TODO Auto-generated method stub

    }

    /*
     * (non-Javadoc)
     * 
     * @see
     * com.opensymphony.xwork2.interceptor.Interceptor#intercept(com.opensymphony
     * .xwork2.ActionInvocation)
     */
    @Override
    public String intercept(ActionInvocation invocation) throws Exception {
        String result = null;
        long time = 0;

        try {
            // Commit and cleanup
            if (sessionFactory.getCurrentSession().getTransaction().isActive()
                    && !sessionFactory.getCurrentSession().getTransaction()
                            .wasCommitted()) {
                LOG.debug("Committing the database transaction");
                sessionFactory.getCurrentSession().getTransaction().commit();
            } else {
                LOG.debug("The database transaction has been comnitted somewhere else");
            }
            LOG.debug("Starting a database transaction");
            sessionFactory.getCurrentSession().beginTransaction();
            time = System.nanoTime();

            // Call the next interceptor (continue request processing)
            result = invocation.invoke();

            // Commit and cleanup
            if (sessionFactory.getCurrentSession().getTransaction().isActive()
                    && !sessionFactory.getCurrentSession().getTransaction()
                            .wasCommitted()) {
                LOG.debug("Committing the database transaction");
                sessionFactory.getCurrentSession().getTransaction().commit();
                time = System.nanoTime() - time;
                LOG.debug("Transaction was opened in " + time);
            } else {
                LOG.debug("The database transaction has been comnitted somewhere else");
            }

        } catch (StaleObjectStateException staleEx) {
            LOG.error("This interceptor does not implement optimistic concurrency control!");
            LOG.error("Your application will not work until you add compensation actions!");
            // Rollback, close everything, possibly compensate for any permanent
            // changes
            // during the conversation, and finally restart business
            // conversation. Maybe
            // give the user of the application a chance to merge some of his
            // work with
            // fresh data... what you do here depends on your applications
            // design.
            throw staleEx;
        } catch (Throwable ex) {
            // Rollback only
            ex.printStackTrace();
            try {
                if (sessionFactory.getCurrentSession().getTransaction()
                        .isActive()) {
                    LOG.debug("Trying to rollback database transaction after exception");
                    sessionFactory.getCurrentSession().getTransaction()
                            .rollback();
                } else {
                    LOG.debug("The database transaction is longer active");
                }
            } catch (Throwable rbEx) {
                LOG.error("Could not rollback transaction after exception!",
                        rbEx);
            }

            // Let others handle it... maybe another interceptor for exceptions?
            throw Exception.class.isAssignableFrom(ex.getClass()) ? (Exception) ex
                    : new Exception(ex);
        } finally {
            sessionFactory.getCurrentSession().close();
            LOG.debug("The database session has been closed");
        }
        return result;
    }

    /**
     * @param sessionFactory
     *            the sessionFactory to set
     */
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

}
