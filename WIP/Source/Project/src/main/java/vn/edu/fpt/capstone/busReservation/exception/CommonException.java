/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.exception;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import vn.edu.fpt.capstone.busReservation.util.CheckUtils;

/**
 * @author Yoshimi
 * 
 */
public class CommonException extends Exception {
    private static Log log = LogFactory.getLog(CommonException.class);

    /**
     * 
     */
    private static final long serialVersionUID = -1038137415504575358L;
    private String messageId;
    private String[] parameters;

    public CommonException(String messageId, String[] parameters) {
        super();
        if (CheckUtils.isNullOrBlank(messageId)) {
            messageId = "msgerrcm000";
        }
        this.messageId = messageId;
        this.parameters = parameters;
        log.error(messageId, this);
    }

    public CommonException() {
        super();
        this.messageId = "msgerrcm000";
        parameters = new String[0];
        log.error(messageId, this);
    }

    public CommonException(String messageId) {
        super();
        if (CheckUtils.isNullOrBlank(messageId)) {
            messageId = "msgerrcm000";
        }
        this.messageId = messageId;
        parameters = new String[0];
        log.error(messageId, this);
    }

    public CommonException(String messageId, Throwable cause) {
        super(messageId, cause);
        if (CheckUtils.isNullOrBlank(messageId)) {
            messageId = "msgerrcm000";
        }
        this.messageId = messageId;
        parameters = new String[0];
        log.error(messageId, this);
    }

    public CommonException(Throwable cause) {
        super(cause);
        this.messageId = "msgerrcm000";
        parameters = new String[0];
        log.error(messageId, this);
    }

    public CommonException(String messageId, String[] parameters,
            Throwable cause) {
        super(messageId, cause);
        if (CheckUtils.isNullOrBlank(messageId)) {
            messageId = "msgerrcm000";
        }
        this.messageId = messageId;
        this.parameters = parameters;
        log.error(messageId, this);
    }

    /**
     * @return the messageId
     */
    public String getMessageId() {
        return messageId;
    }

    /**
     * @param messageId
     *            the messageId to set
     */
    public void setMessageId(String messageId) {
        this.messageId = messageId;
    }

    /**
     * @return the parameters
     */
    public String[] getParameters() {
        return parameters;
    }

    /**
     * @param parameters
     *            the parameters to set
     */
    public void setParameters(String[] parameters) {
        this.parameters = parameters;
    }

}
