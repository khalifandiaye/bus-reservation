package vn.edu.fpt.capstone.busReservation.action;

import java.util.ArrayList;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import urn.ebay.api.PayPalAPI.DoExpressCheckoutPaymentReq;
import urn.ebay.api.PayPalAPI.DoExpressCheckoutPaymentRequestType;
import urn.ebay.api.PayPalAPI.DoExpressCheckoutPaymentResponseType;
import urn.ebay.api.PayPalAPI.GetExpressCheckoutDetailsReq;
import urn.ebay.api.PayPalAPI.GetExpressCheckoutDetailsRequestType;
import urn.ebay.api.PayPalAPI.GetExpressCheckoutDetailsResponseType;
import urn.ebay.api.PayPalAPI.PayPalAPIInterfaceServiceService;
import urn.ebay.apis.eBLBaseComponents.DoExpressCheckoutPaymentRequestDetailsType;
import urn.ebay.apis.eBLBaseComponents.ErrorType;
import urn.ebay.apis.eBLBaseComponents.PaymentActionCodeType;
import urn.ebay.apis.eBLBaseComponents.PaymentDetailsType;

import com.opensymphony.xwork2.ActionSupport;

public class TestPayReturnAction extends ActionSupport implements SessionAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5962554617409673584L;
	private Map<String, Object> session;
	private String payerID;

	/**
	 * @return the payerId
	 */
	public String getPayerID() {
		return payerID;
	}

	public String execute() throws Exception {
		PayPalAPIInterfaceServiceService service = null;
		GetExpressCheckoutDetailsReq checkoutDetailsReq = null;
		GetExpressCheckoutDetailsRequestType checkoutDetailsRequest = null;
		GetExpressCheckoutDetailsResponseType checkoutDetailsResponse = null;
		DoExpressCheckoutPaymentReq doExpressCheckoutPaymentReq = null;
		DoExpressCheckoutPaymentRequestType doRequest = null;
		DoExpressCheckoutPaymentRequestDetailsType details = null;
		DoExpressCheckoutPaymentResponseType doResponse = null;
		String token = null;
		token = session.get("paymentToken").toString();
		checkoutDetailsRequest = new GetExpressCheckoutDetailsRequestType(token);
		checkoutDetailsReq = new GetExpressCheckoutDetailsReq();
		checkoutDetailsReq
				.setGetExpressCheckoutDetailsRequest(checkoutDetailsRequest);
		service = new PayPalAPIInterfaceServiceService(this.getClass()
				.getResourceAsStream("/paypal/sdk_config.properties"));
		checkoutDetailsResponse = service
				.getExpressCheckoutDetails(checkoutDetailsReq);

		if (checkoutDetailsResponse != null) {
			if ("SUCCESS".equalsIgnoreCase(checkoutDetailsResponse.getAck()
					.toString())) {
				payerID = checkoutDetailsResponse
						.getGetExpressCheckoutDetailsResponseDetails()
						.getPayerInfo().getPayerID();
				details = new DoExpressCheckoutPaymentRequestDetailsType();
				details.setToken(token);
				details.setPayerID(payerID);
				details.setPaymentDetails(new ArrayList<PaymentDetailsType>());
				details.getPaymentDetails().addAll(
						checkoutDetailsResponse
								.getGetExpressCheckoutDetailsResponseDetails()
								.getPaymentDetails());
				details.setPaymentAction(PaymentActionCodeType.SALE);

				doRequest = new DoExpressCheckoutPaymentRequestType();
				doRequest.setDoExpressCheckoutPaymentRequestDetails(details);
				doExpressCheckoutPaymentReq = new DoExpressCheckoutPaymentReq();
				doExpressCheckoutPaymentReq
						.setDoExpressCheckoutPaymentRequest(doRequest);
				doResponse = service
						.doExpressCheckoutPayment(doExpressCheckoutPaymentReq);
				if (doResponse != null) {
					if (doResponse.getAck().toString()
							.equalsIgnoreCase("SUCCESS")) {

					} else {
						for (ErrorType error : doResponse.getErrors()) {
							System.out.println(error.getErrorCode() + ":"
									+ error.getLongMessage());
						}
						return ERROR;
					}
				} else {
					addActionError("Null response");
					return ERROR;
				}

			} else {
				for (ErrorType error : checkoutDetailsResponse.getErrors()) {
					System.out.println(error.getErrorCode() + ":"
							+ error.getLongMessage());
				}
				return ERROR;
			}
		} else {
			addActionError("Null response");
			return ERROR;
		}
		return SUCCESS;
	}

	@Override
	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}
