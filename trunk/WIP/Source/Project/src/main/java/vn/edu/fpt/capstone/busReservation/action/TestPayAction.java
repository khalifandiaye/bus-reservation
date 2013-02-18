package vn.edu.fpt.capstone.busReservation.action;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.SessionAware;

import urn.ebay.api.PayPalAPI.PayPalAPIInterfaceServiceService;
import urn.ebay.api.PayPalAPI.SetExpressCheckoutReq;
import urn.ebay.api.PayPalAPI.SetExpressCheckoutRequestType;
import urn.ebay.api.PayPalAPI.SetExpressCheckoutResponseType;
import urn.ebay.apis.CoreComponentTypes.BasicAmountType;
import urn.ebay.apis.eBLBaseComponents.CurrencyCodeType;
import urn.ebay.apis.eBLBaseComponents.ErrorType;
import urn.ebay.apis.eBLBaseComponents.PaymentActionCodeType;
import urn.ebay.apis.eBLBaseComponents.SetExpressCheckoutRequestDetailsType;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;

import com.opensymphony.xwork2.ActionSupport;

public class TestPayAction extends ActionSupport implements ServletRequestAware, SessionAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5962554617409673584L;
	
	private HttpServletRequest request;
	private Map<String, Object> session;
	private String amount;
	private String redirectUrl;

	/**
	 * @param amount the amount to set
	 */
	public void setAmount(String amount) {
		this.amount = amount;
	}

	/**
	 * @return the redirectUrl
	 */
	public String getRedirectUrl() {
		return redirectUrl;
	}

	public String execute() throws Exception {
		PayPalAPIInterfaceServiceService service = null;
		SetExpressCheckoutReq setExpressCheckoutReq = null;
		SetExpressCheckoutRequestType checkoutRequest = null;
		SetExpressCheckoutResponseType checkoutResponse = null;
		SetExpressCheckoutRequestDetailsType details = null;
		BasicAmountType orderTotal = null;
		StringBuilder url = null;
		
		checkoutRequest = new SetExpressCheckoutRequestType();
		details = new SetExpressCheckoutRequestDetailsType();
		url = new StringBuilder();
		url.append("http://");
		request.getRequestURI();
		url.append("localhost:8080");
		url.append(request.getContextPath());
		details.setReturnURL(url.toString() + "/testPaypalSuccess.action");
		details.setCancelURL(url.toString() + "/testPaypalCancel.action");
		orderTotal = new BasicAmountType();
		orderTotal.setCurrencyID(CurrencyCodeType.USD);
		orderTotal.setValue(amount);
		details.setOrderTotal(orderTotal);
		details.setPaymentAction(PaymentActionCodeType.SALE);
		checkoutRequest.setSetExpressCheckoutRequestDetails(details);
		
		service = new PayPalAPIInterfaceServiceService(this
				.getClass().getResourceAsStream("/paypal/sdk_config.properties"));
		setExpressCheckoutReq = new SetExpressCheckoutReq();
		setExpressCheckoutReq.setSetExpressCheckoutRequest(checkoutRequest);
		checkoutResponse = service.setExpressCheckout(setExpressCheckoutReq);
		
		if (checkoutResponse != null) {
			if (checkoutResponse.getAck().toString().equalsIgnoreCase("SUCCESS")) {
				redirectUrl = "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token="
						+ checkoutResponse.getToken();
				session.put(CommonConstant.SESSION_KEY_PAYMENT_TOKEN, checkoutResponse.getToken());
			} else {
				for (ErrorType error : checkoutResponse.getErrors()) {
					System.out.println(error.getErrorCode() + ":" + error.getLongMessage());
				}
				return ERROR;
			}
		} else {
			addActionError("Null response");
			return ERROR;
		}
		
        return SUCCESS;
    }

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}
