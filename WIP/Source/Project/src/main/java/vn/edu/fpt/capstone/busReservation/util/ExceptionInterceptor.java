package vn.edu.fpt.capstone.busReservation.util;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import vn.edu.fpt.capstone.busReservation.exception.CommonException;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.Interceptor;

public class ExceptionInterceptor implements Interceptor {
    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    protected static Log LOG = LogFactory
            .getLog(ExceptionInterceptor.class);

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
        ActionSupport action = null;
        CommonException e = null;
        // Call the next interceptor (continue request processing)
        try {
            result = invocation.invoke();
        } catch (Exception ex) {
            if (ActionSupport.class.isAssignableFrom(invocation.getAction().getClass())) {
                action = (ActionSupport) invocation.getAction();
            }
            if (CommonException.class.isAssignableFrom(ex.getClass())) {
                e = (CommonException) ex;
            } else {
                e = new CommonException(ex);
            }
            String[] parameters;
            String[] paramKeys;
            int length = 0;
            paramKeys = e.getParameters();
            if (paramKeys != null && paramKeys.length > 0) {
                length = paramKeys.length;
                parameters = new String[length];
                for (int i = 0; i < length; i++) {
                    if (action != null) {
                        parameters[i] = action.getText(paramKeys[i]);
                    } else {
                        parameters[i] = paramKeys[i];
                    }
                }
            } else {
                parameters = new String[0];
            }
            if (action != null) {
                action.addActionError(action.getText(e.getMessageId(), action.getText("msgerrcm000"), parameters));
            } else {
                throw ex;
            }
            return ActionSupport.ERROR;
        }
        return result;
    }
}
