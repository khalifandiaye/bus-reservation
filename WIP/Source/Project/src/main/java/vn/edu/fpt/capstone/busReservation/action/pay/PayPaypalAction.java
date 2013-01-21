/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.xml.parsers.ParserConfigurationException;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.SessionAware;
import org.xml.sax.SAXException;

import urn.ebay.api.PayPalAPI.PayPalAPIInterfaceServiceService;
import urn.ebay.api.PayPalAPI.SetExpressCheckoutReq;
import urn.ebay.api.PayPalAPI.SetExpressCheckoutRequestType;
import urn.ebay.api.PayPalAPI.SetExpressCheckoutResponseType;
import urn.ebay.apis.CoreComponentTypes.BasicAmountType;
import urn.ebay.apis.eBLBaseComponents.CurrencyCodeType;
import urn.ebay.apis.eBLBaseComponents.ErrorType;
import urn.ebay.apis.eBLBaseComponents.ItemCategoryType;
import urn.ebay.apis.eBLBaseComponents.PaymentActionCodeType;
import urn.ebay.apis.eBLBaseComponents.PaymentDetailsItemType;
import urn.ebay.apis.eBLBaseComponents.PaymentDetailsType;
import urn.ebay.apis.eBLBaseComponents.SetExpressCheckoutRequestDetailsType;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;

import com.opensymphony.xwork2.ActionSupport;
import com.paypal.exception.ClientActionRequiredException;
import com.paypal.exception.HttpErrorException;
import com.paypal.exception.InvalidCredentialException;
import com.paypal.exception.InvalidResponseDataException;
import com.paypal.exception.MissingCredentialException;
import com.paypal.exception.SSLConfigurationException;
import com.paypal.sdk.exceptions.OAuthException;

/**
 * @author Yoshimi
 * 
 */
public class PayPaypalAction extends ActionSupport implements
		ServletRequestAware, SessionAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = 850559893103389051L;

	private HttpServletRequest request;
	private Map<String, Object> session;

	private String redirectUrl;

	/**
	 * @return the redirectUrl
	 */
	public String getRedirectUrl() {
		return redirectUrl;
	}

	public String execute() {
		PayPalAPIInterfaceServiceService service = null;
		SetExpressCheckoutReq setExpressCheckoutReq = null;
		SetExpressCheckoutRequestType checkoutRequest = null;
		SetExpressCheckoutResponseType checkoutResponse = null;
		SetExpressCheckoutRequestDetailsType details = null;
		BasicAmountType orderTotal = null;
		StringBuilder url = null;
		ReservationInfo reservationInfo = null;
		List<PaymentDetailsType> paymentDetailsList = null;
		PaymentDetailsType paymentDetails = null;
		List<PaymentDetailsItemType> items = null;
		PaymentDetailsItemType item = null;
		// must use BigDecimal to calculate precisely
		BigDecimal totalAmount = null;

		reservationInfo = (ReservationInfo) session.get("reservationInfo");
		checkoutRequest = new SetExpressCheckoutRequestType();
		details = new SetExpressCheckoutRequestDetailsType();
		url = new StringBuilder();
		url.append("http://");
		request.getRequestURI();
		url.append("localhost:8080");
		url.append(request.getContextPath());
		// set return pages
		details.setReturnURL(url.toString() + "/pay/paypal-success.html");
		details.setCancelURL(url.toString() + "/pay/paypal-cancel.html");
		// set payment details
		paymentDetailsList = new ArrayList<PaymentDetailsType>();
		paymentDetails = new PaymentDetailsType();
		paymentDetails.setPaymentAction(PaymentActionCodeType.SALE);
		items = new ArrayList<PaymentDetailsItemType>();
		item = new PaymentDetailsItemType();
		item.setName("Ticket");
		item.setQuantity(Integer.parseInt(reservationInfo.getQuantity()));
		item.setAmount(new BasicAmountType(CurrencyCodeType
				.fromValue(reservationInfo.getCurrency()), reservationInfo
				.getAmount()));
		item.setItemCategory(ItemCategoryType.DIGITAL);
		items.add(item);
		paymentDetails.setPaymentDetailsItem(items);
		paymentDetailsList.add(paymentDetails);
		details.setPaymentDetails(paymentDetailsList);
		// set total amount
		totalAmount = new BigDecimal(reservationInfo.getAmount());
		totalAmount = totalAmount.multiply(new BigDecimal(reservationInfo.getQuantity()));
		orderTotal = new BasicAmountType();
		orderTotal.setCurrencyID(CurrencyCodeType.USD);
		orderTotal.setValue(totalAmount.toString());
		details.setOrderTotal(orderTotal);
		details.setPaymentAction(PaymentActionCodeType.SALE);
		// set details to request
		checkoutRequest.setSetExpressCheckoutRequestDetails(details);

		try {
			service = new PayPalAPIInterfaceServiceService(this.getClass()
					.getResourceAsStream("/paypal/sdk_config.properties"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		setExpressCheckoutReq = new SetExpressCheckoutReq();
		setExpressCheckoutReq.setSetExpressCheckoutRequest(checkoutRequest);
		try {
			checkoutResponse = service
					.setExpressCheckout(setExpressCheckoutReq);
		} catch (SSLConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvalidCredentialException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (HttpErrorException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InvalidResponseDataException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClientActionRequiredException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MissingCredentialException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (OAuthException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParserConfigurationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SAXException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		if (checkoutResponse != null) {
			if (checkoutResponse.getAck().toString()
					.equalsIgnoreCase("SUCCESS")) {
				redirectUrl = "https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_express-checkout&token="
						+ checkoutResponse.getToken();
				session.put("paymentToken", checkoutResponse.getToken());
			} else {
				for (ErrorType error : checkoutResponse.getErrors()) {
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

	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

}
