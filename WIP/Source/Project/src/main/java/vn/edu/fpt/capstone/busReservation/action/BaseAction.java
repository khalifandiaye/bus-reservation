/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.RequestAware;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.hibernate.HibernateException;
import org.hibernate.SessionFactory;

import vn.edu.fpt.capstone.busReservation.exception.CommonException;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.Preparable;

/**
 * @author Yoshimi
 * 
 */
public class BaseAction extends ActionSupport implements SessionAware,
        RequestAware, ServletRequestAware, Preparable {

    /**
     * 
     */
    private static final long serialVersionUID = -3228510192469319564L;
    // ===========================HTTP Object==========================
    private SessionFactory sessionFactory;
    protected Map<String, Object> session;
    protected Map<String, Object> request;
    protected HttpServletRequest servletRequest;

    /**
     * @param sessionFactory
     *            the sessionFactory to set
     */
    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    /*
     * (non-Javadoc)
     * 
     * @see
     * org.apache.struts2.interceptor.SessionAware#setSession(java.util.Map)
     */
    public void setSession(Map<String, Object> session) {
        this.session = session;
    }

    @Override
    public void setRequest(Map<String, Object> request) {
        this.request = request;
    }

    @Override
    public void setServletRequest(HttpServletRequest request) {
        this.servletRequest = request;
    }
    
    @Override
    public String execute() {
        return SUCCESS;
    }

    // ====================GENERIC ERROR PROCESSING====================

    protected void genericDatabaseErrorProcess(HibernateException e) {
        rollback();
        LOG.error("Database error", e);
        addActionError(getText("msgerrdb001"));
    }

    /**
     * 
     * @param e
     */
    protected void errorProcessing(CommonException e) {
        String[] parameters;
        String[] paramKeys;
        int length = 0;
        rollback();
        paramKeys = e.getParameters();
        if (paramKeys != null && paramKeys.length > 0) {
            length = paramKeys.length;
            parameters = new String[length];
            for (int i = 0; i < length; i++) {
                parameters[i] = getText(paramKeys[i]);
            }
        } else {
            parameters = new String[0];
        }
        addActionError(getText(e.getMessageId(), parameters));
    }

    /**
     * 
     * @param e
     */
    protected void errorProcessing(CommonException e, boolean rollback) {
        String[] parameters;
        String[] paramKeys;
        int length = 0;
        if (rollback) {
            rollback();
        }
        paramKeys = e.getParameters();
        if (paramKeys != null && paramKeys.length > 0) {
            length = paramKeys.length;
            parameters = new String[length];
            for (int i = 0; i < length; i++) {
                parameters[i] = getText(paramKeys[i]);
            }
        } else {
            parameters = new String[0];
        }
        addActionError(getText(e.getMessageId(), parameters));
    }

    /**
     * Untested
     * 
     * @param e
     */
    protected void commonSessionTimeoutError() {
        rollback();
        addActionError(getText("msgerrss001"));
    }

    private void rollback() {
        // Rollback only
        try {
            if (sessionFactory.getCurrentSession().getTransaction().isActive()) {
                LOG.debug("Trying to rollback database transaction after exception");
                sessionFactory.getCurrentSession().getTransaction().rollback();
            } else {
                LOG.debug("The database transaction is longer active");
            }
        } catch (Throwable rbEx) {
            LOG.error("Could not rollback transaction after exception!", rbEx);
        }
    }

    @Override
    public void prepare() throws Exception {
    }

}
