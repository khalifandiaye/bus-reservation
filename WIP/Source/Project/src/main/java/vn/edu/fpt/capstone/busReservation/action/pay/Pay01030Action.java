/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.action.pay;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.Map;

import javax.xml.parsers.ParserConfigurationException;

import org.apache.struts2.interceptor.SessionAware;
import org.xml.sax.SAXException;

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
import urn.ebay.apis.eBLBaseComponents.PaymentDetailsItemType;
import urn.ebay.apis.eBLBaseComponents.PaymentDetailsType;
import vn.edu.fpt.capstone.busReservation.dao.PaymentDAO;
import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.util.CryptUtils;

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
public class Pay01030Action extends ActionSupport implements SessionAware {

	/**
	 * 
	 */
	private static final long serialVersionUID = -855508237619631030L;
	// =======================HTTP Object=============================

	private Map<String, Object> session;

	public void setSession(Map<String, Object> session) {
		this.session = session;
	}

	// =====================Database Access Object=====================
	private ReservationDAO reservationDAO;
	private PaymentDAO paymentDAO;

	/**
	 * @param reservationDAO
	 *            the reservationDAO to set
	 */
	public void setReservationDAO(ReservationDAO reservationDAO) {
		this.reservationDAO = reservationDAO;
	}

	/**
	 * @param paymentDAO the paymentDAO to set
	 */
	public void setPaymentDAO(PaymentDAO paymentDAO) {
		this.paymentDAO = paymentDAO;
	}
	
	// =========================Action Output============================
	private String reservationCode;

	/**
	 * @return the reservationCode
	 */
	public String getReservationCode() {
		return reservationCode;
	}

	public String execute() {
		PayPalAPIInterfaceServiceService service = null;
		GetExpressCheckoutDetailsReq checkoutDetailsReq = null;
		GetExpressCheckoutDetailsRequestType checkoutDetailsRequest = null;
		GetExpressCheckoutDetailsResponseType checkoutDetailsResponse = null;
		DoExpressCheckoutPaymentReq doExpressCheckoutPaymentReq = null;
		DoExpressCheckoutPaymentRequestType doRequest = null;
		DoExpressCheckoutPaymentRequestDetailsType details = null;
		DoExpressCheckoutPaymentResponseType doResponse = null;
		String token = null;
		String payerID = null;
		int reservationId = 0;
		ReservationBean reservation = null;
		PaymentBean payment = null;
		int maxTry = 0;
		// Execute payment
		token = session.get("paymentToken").toString();
		checkoutDetailsRequest = new GetExpressCheckoutDetailsRequestType(token);
		checkoutDetailsReq = new GetExpressCheckoutDetailsReq();
		checkoutDetailsReq
				.setGetExpressCheckoutDetailsRequest(checkoutDetailsRequest);
		try {
			service = new PayPalAPIInterfaceServiceService(this.getClass()
					.getResourceAsStream("/paypal/sdk_config.properties"));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			checkoutDetailsResponse = service
					.getExpressCheckoutDetails(checkoutDetailsReq);
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
				try {
					doResponse = service
							.doExpressCheckoutPayment(doExpressCheckoutPaymentReq);
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
		// Update database
		reservationId = (Integer) session.get("reservationId");
		reservation = reservationDAO.getById(reservationId);
		payment = new PaymentBean();
		payment.setReservation(reservation);
//		payment.setPaymentMethod("PAYPAL");
		// get amount from paypal's response
		for (PaymentDetailsItemType item : checkoutDetailsResponse.getGetExpressCheckoutDetailsResponseDetails().getPaymentDetails().get(0).getPaymentDetailsItem()) {
			if (item.getName().contains("Ticket")) {
				payment.setPayAmount(Double.parseDouble(item.getAmount().getValue()) + payment.getPayAmount());
			} else if (item.getName().contains("Fee")) {
				payment.setServiceFee(Double.parseDouble(item.getAmount().getValue()) + payment.getServiceFee());
			}
		}
		paymentDAO.insert(payment);
		// Generate reservation code
		try {
			reservationCode = CryptUtils.generateCode(reservation.getId(), 6);
			// Anti duplicate code
			if (reservationDAO.getByCode(reservationCode) != null) {
				maxTry = 3;
				for (int i = 0; i < maxTry; i++) {
					reservationCode = CryptUtils.generateCode(reservation.getId(), 6, reservationCode);
					if (reservationDAO.getByCode(reservationCode) != null) {
						// When generated code is duplicated
						if (i + 1 >= maxTry) {
							// Error
							return ERROR;
						} else {
							// continue
						}
					} else {
						// stop generate when a unique code has been generated
						break;
					}
				}
			}
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		reservation.setCode(reservationCode);
		reservationDAO.update(reservation);
		return SUCCESS;
	}
}
