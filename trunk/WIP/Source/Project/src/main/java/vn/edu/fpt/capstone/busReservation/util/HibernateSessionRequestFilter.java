package vn.edu.fpt.capstone.busReservation.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.StaleObjectStateException;

//unused, for now
public class HibernateSessionRequestFilter implements Filter {
	
	private static Log log = LogFactory.getLog(HibernateSessionRequestFilter.class);

    private SessionFactory sessionFactory;
    
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
 
        try {
        	long time = System.nanoTime();
            log.debug("Starting a database transaction");
            sessionFactory.getCurrentSession().beginTransaction();
 
            // Call the next filter (continue request processing)
            chain.doFilter(request, response);
 
            // Commit and cleanup
        	log.debug("Committing the database transaction");
            if (sessionFactory.getCurrentSession().getTransaction().isActive() && !sessionFactory.getCurrentSession().getTransaction().wasCommitted()) {
            	sessionFactory.getCurrentSession().getTransaction().commit();
            	time = System.nanoTime() - time;
            	log.debug("Transaction was opened in " + time);
            } else {
            	log.debug("The database transaction has been comnitted somewhere else");
            }
 
        } catch (StaleObjectStateException staleEx) {
            log.error("This interceptor does not implement optimistic concurrency control!");
            log.error("Your application will not work until you add compensation actions!");
            // Rollback, close everything, possibly compensate for any permanent changes
            // during the conversation, and finally restart business conversation. Maybe
            // give the user of the application a chance to merge some of his work with
            // fresh data... what you do here depends on your applications design.
            throw staleEx;
        } catch (Throwable ex) {
            // Rollback only
            ex.printStackTrace();
            try {
                if (sessionFactory.getCurrentSession().getTransaction().isActive()) {
                    log.debug("Trying to rollback database transaction after exception");
                    sessionFactory.getCurrentSession().getTransaction().rollback();
                }
            } catch (Throwable rbEx) {
                log.error("Could not rollback transaction after exception!", rbEx);
            }
 
            // Let others handle it... maybe another interceptor for exceptions?
            throw new ServletException(ex);
        } finally {
        	sessionFactory.getCurrentSession().close();
        }
	}

	/**
	 * @param sessionFactory the sessionFactory to set
	 */
	public void setSessionFactory(SessionFactory sessionFactory) {
		this.sessionFactory = sessionFactory;
	}

	public void destroy() {
	}

}
