/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.ServletActionContext;

import vn.edu.fpt.capstone.busReservation.displayModel.User;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

/**
 * @author Yoshimi
 * 
 */
public class AuthorizationInterceptor implements Interceptor {

    /**
     * 
     */
    private static final long serialVersionUID = 8855154057096678551L;
    protected static Log LOG = LogFactory
            .getLog(AuthorizationInterceptor.class);

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
        String namespace = null;
        User user = null;
        boolean allowAdmin = true;
        boolean allowOp = true;
        boolean allowCus = true;
        HttpServletRequest request = (HttpServletRequest) invocation
                .getInvocationContext().get(ServletActionContext.HTTP_REQUEST);
        HttpSession session = request.getSession(true);
        user = (User) session.getAttribute(CommonConstant.SESSION_KEY_USER);
        // developer can do anything.... in debug mode only
        if (user == null || user.getRoleId() != 4 || !CommonConstant.DEBUG_MODE) {
            namespace = ServletActionContext.getActionMapping().getNamespace();

            if ("/admin".equals(namespace)) {
                allowOp = false;
                allowCus = false;
            } else if ("/route".equals(namespace) || "/bus".equals(namespace)
                    || "/schedule".equals(namespace)) {
                allowCus = false;
                allowAdmin = false;
            } else if (!"/".equals(namespace) && !"/user".equals(namespace)) {
                allowAdmin = false;
            } else if ("/debug".equals(namespace)) {
                allowCus = false;
                allowOp = false;
                allowAdmin = false;
            }
            if ((!allowCus && (user == null || user.getRoleId() == 1))
                    || (!allowOp && user != null && user.getRoleId() == 2)
                    || (!allowAdmin && user != null && user.getRoleId() == 3)) {
                return "unauthorized";
            }
        }
        // Call the next interceptor (continue request processing)
        result = invocation.invoke();
        return result;
    }

}