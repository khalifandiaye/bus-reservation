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

import vn.edu.fpt.capstone.busReservation.exception.CommonException;

import com.opensymphony.xwork2.ActionSupport;

/**
 * @author Yoshimi
 * 
 */
public class BaseAction extends ActionSupport implements SessionAware,
        RequestAware, ServletRequestAware {

    /**
     * 
     */
    private static final long serialVersionUID = -3228510192469319564L;
    // ===========================HTTP Object==========================
    protected Map<String, Object> session;
    protected Map<String, Object> request;
    protected HttpServletRequest servletRequest;

    public void setSession(Map<String, Object> session) {
        this.session = session;
    }

    /**
     * @return the session
     */
    protected Map<String, Object> getSession() {
        return session;
    }

    @Override
    public void setRequest(Map<String, Object> request) {
        this.request = request;
    }

    /**
     * @return the request
     */
    protected Map<String, Object> getRequest() {
        return request;
    }

    @Override
    public void setServletRequest(HttpServletRequest request) {
        this.servletRequest = request;
    }

    /**
     * @return the servletRequest
     */
    protected HttpServletRequest getServletRequest() {
        return servletRequest;
    }

    // ====================GENERIC ERROR PROCESSING====================

    protected void genericDatabaseErrorProcess(HibernateException e) {
        LOG.error("Database error", e);
        addActionError(getText("msgerrdb001"));
    }

    /**
     * Untested
     * @param e
     */
    protected void errorProcessing(CommonException e) {
        String[] parameters;
        String[] paramKeys;
        int length = 0;
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
        
        addActionError(getText(e.getMessageId(),parameters));
    }

    /**
     * Untested
     * @param e
     */
    protected void commonSessionTimeoutError() {
        addActionError(getText("msgerrss001"));
    }

}
