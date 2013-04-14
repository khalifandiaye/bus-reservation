package vn.edu.fpt.capstone.busReservation.action.schedule.secured;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;

import vn.edu.fpt.capstone.busReservation.action.BaseAction;
import vn.edu.fpt.capstone.busReservation.displayModel.User;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.PaymentLogic;
import vn.edu.fpt.capstone.busReservation.logic.ScheduleLogic;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

@ParentPackage("jsonPackage")
public class DeleteScheduleAction extends BaseAction {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    // ==========================Logic Object==========================
    private ScheduleLogic scheduleLogic;
    private PaymentLogic paymentLogic;

    /**
     * @param scheduleLogic
     *            the scheduleLogic to set
     */
    public void setScheduleLogic(ScheduleLogic scheduleLogic) {
        this.scheduleLogic = scheduleLogic;
    }

    /**
     * @param paymentLogic the paymentLogic to set
     */
    public void setPaymentLogic(PaymentLogic paymentLogic) {
        this.paymentLogic = paymentLogic;
    }

    // ==========================Action Input==========================
    private String id;
    private String reason;

    /**
     * @param id
     *            the id to set
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * @param reason
     *            the reason to set
     */
    public void setReason(String reason) {
        this.reason = reason;
    }

    // ==========================Action Output=========================
    private boolean success;
    private String[] messages;

    /**
     * @return the success
     */
    public boolean isSuccess() {
        return success;
    }

    /**
     * @return the messages
     */
    public String[] getMessages() {
        return messages;
    }

    @Action(value = "/confirmCancel", results = { @Result(type = "json", name = SUCCESS, params = {
            "callbackParameter", "callback" }) })
    public String confirmCancel() {
        try {
            messages = new String[1];
            messages[0] = getText("message.schedule.cancel.confirm",
                    scheduleLogic.getDeleteInfo(Integer.parseInt(id)));
            success = true;
        } catch (Exception e) {
            errorProcessing(e);
            messages = new String[getActionErrors().size()];
            getActionErrors().toArray(messages);
        }
        return SUCCESS;
    }

    @Action(value = "/executeDelete", results = { @Result(type = "json", name = SUCCESS, params = {
            "callbackParameter", "callback" }) })
    public String executeDelete() {
        Object user = null;
        int userId = 0;
        String[] params = null;
        String message = null;
        if (CheckUtils.isNullOrBlank(reason)) {
        	params = new String[1];
        	params[0] = getText("field.cancelReason");
        	message = getText("msgerrcm001", params);
            messages = new String[1];
            messages[0] = message;
        }
        if (messages != null || messages.length > 0) {
            return SUCCESS;
        }
        if (session != null
                && session.containsKey(CommonConstant.SESSION_KEY_USER)) {
            user = session.get(CommonConstant.SESSION_KEY_USER);
            if (User.class.isAssignableFrom(user.getClass())) {
                userId = ((User) user).getUserId();
            } else {
                // wrong object on session
                session.remove(CommonConstant.SESSION_KEY_USER);
            }
        } else {
            // wrong object on session
            session.remove(CommonConstant.SESSION_KEY_USER);
        }
        try {
            scheduleLogic.cancelBusStatus(Integer.parseInt(id), reason, userId);
            success = true;
        } catch (Exception e) {
            errorProcessing(e);
            messages = new String[getActionErrors().size()];
            getActionErrors().toArray(messages);
        }
        return SUCCESS;
    }

    @Action(value = "/executeRefund", results = { @Result(type = "json", name = SUCCESS, params = {
            "callbackParameter", "callback" }) })
    public String executeRefund() {
        try {
            paymentLogic.refundBusStatus(Integer.parseInt(id));
            success = true;
        } catch (Exception e) {
            errorProcessing(e);
            messages = new String[getActionErrors().size()];
            getActionErrors().toArray(messages);
        }
        return SUCCESS;
    }

}
