/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.logic;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Currency;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;
import javax.xml.parsers.ParserConfigurationException;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;
import org.xml.sax.SAXException;

import urn.ebay.api.PayPalAPI.DoExpressCheckoutPaymentReq;
import urn.ebay.api.PayPalAPI.DoExpressCheckoutPaymentRequestType;
import urn.ebay.api.PayPalAPI.DoExpressCheckoutPaymentResponseType;
import urn.ebay.api.PayPalAPI.GetExpressCheckoutDetailsReq;
import urn.ebay.api.PayPalAPI.GetExpressCheckoutDetailsRequestType;
import urn.ebay.api.PayPalAPI.GetExpressCheckoutDetailsResponseType;
import urn.ebay.api.PayPalAPI.PayPalAPIInterfaceServiceService;
import urn.ebay.api.PayPalAPI.RefundTransactionReq;
import urn.ebay.api.PayPalAPI.RefundTransactionRequestType;
import urn.ebay.api.PayPalAPI.RefundTransactionResponseType;
import urn.ebay.api.PayPalAPI.SetExpressCheckoutReq;
import urn.ebay.api.PayPalAPI.SetExpressCheckoutRequestType;
import urn.ebay.api.PayPalAPI.SetExpressCheckoutResponseType;
import urn.ebay.apis.CoreComponentTypes.BasicAmountType;
import urn.ebay.apis.eBLBaseComponents.CurrencyCodeType;
import urn.ebay.apis.eBLBaseComponents.DoExpressCheckoutPaymentRequestDetailsType;
import urn.ebay.apis.eBLBaseComponents.ErrorType;
import urn.ebay.apis.eBLBaseComponents.ItemCategoryType;
import urn.ebay.apis.eBLBaseComponents.PaymentActionCodeType;
import urn.ebay.apis.eBLBaseComponents.PaymentDetailsItemType;
import urn.ebay.apis.eBLBaseComponents.PaymentDetailsType;
import urn.ebay.apis.eBLBaseComponents.RefundType;
import urn.ebay.apis.eBLBaseComponents.SetExpressCheckoutRequestDetailsType;
import vn.edu.fpt.capstone.busReservation.dao.MailTemplateDAO;
import vn.edu.fpt.capstone.busReservation.dao.PaymentDAO;
import vn.edu.fpt.capstone.busReservation.dao.PaymentMethodDAO;
import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;
import vn.edu.fpt.capstone.busReservation.dao.ReservationInfoDAO;
import vn.edu.fpt.capstone.busReservation.dao.SystemSettingDAO;
import vn.edu.fpt.capstone.busReservation.dao.TicketDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.MailTemplateBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentBean.PaymentType;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentMethodBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationInfoBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SeatPositionBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.SystemSettingBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.TicketInfoBean;
import vn.edu.fpt.capstone.busReservation.displayModel.RefundInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.CryptUtils;
import vn.edu.fpt.capstone.busReservation.util.CurrencyConverter;
import vn.edu.fpt.capstone.busReservation.util.DateUtils;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;
import vn.edu.fpt.capstone.busReservation.util.MailUtils;
import vn.edu.fpt.capstone.busReservation.util.MailUtils.MailPasswordAuthenticator;

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
public class PaymentLogic extends BaseLogic {

    /**
     * 
     */
    private static final long serialVersionUID = -8459183174212009486L;
    // =====================Database Access Object=====================
    private ReservationDAO reservationDAO;
    private ReservationInfoDAO reservationInfoDAO;
    private PaymentMethodDAO paymentMethodDAO;
    private PaymentDAO paymentDAO;
    private SystemSettingDAO systemSettingDAO;
    private TicketDAO ticketDAO;
    private MailTemplateDAO mailTemplateDAO;

    /**
     * @param reservationDAO
     *            the reservationDAO to set
     */
    @Autowired
    public void setReservationDAO(ReservationDAO reservationDAO) {
        this.reservationDAO = reservationDAO;
    }

    /**
     * @param reservationInfoDAO
     *            the reservationInfoDAO to set
     */
    @Autowired
    public void setReservationInfoDAO(ReservationInfoDAO reservationInfoDAO) {
        this.reservationInfoDAO = reservationInfoDAO;
    }

    /**
     * @param paymentMethodDAO
     *            the paymentMethodDAO to set
     */
    @Autowired
    public void setPaymentMethodDAO(PaymentMethodDAO paymentMethodDAO) {
        this.paymentMethodDAO = paymentMethodDAO;
    }

    /**
     * @param paymentDAO
     *            the paymentDAO to set
     */
    @Autowired
    public void setPaymentDAO(PaymentDAO paymentDAO) {
        this.paymentDAO = paymentDAO;
    }

    /**
     * @param systemSettingDAO
     *            the systemSettingDAO to set
     */
    @Autowired
    public void setSystemSettingDAO(SystemSettingDAO systemSettingDAO) {
        this.systemSettingDAO = systemSettingDAO;
    }

    /**
     * @param ticketDAO
     *            the ticketDAO to set
     */
    @Autowired
    public void setTicketDAO(TicketDAO ticketDAO) {
        this.ticketDAO = ticketDAO;
    }

    /**
     * @param mailTemplateDAO
     *            the mailTemplateDAO to set
     */
    @Autowired
    public void setMailTemplateDAO(MailTemplateDAO mailTemplateDAO) {
        this.mailTemplateDAO = mailTemplateDAO;
    }

    // =========================Main Functions=========================
    public List<PaymentMethodBean> getPaymentMethods()
            throws HibernateException {
        List<PaymentMethodBean> paymentMethods = null;
        PaymentMethodBean paymentMethod = null;
        paymentMethods = paymentMethodDAO.getAll();
        for (Iterator<PaymentMethodBean> paymentMethodIterator = paymentMethods
                .iterator(); paymentMethodIterator.hasNext();) {
            paymentMethod = paymentMethodIterator.next();
            if (paymentMethod.getId() != 2 && paymentMethod.getId() != 3) {
                paymentMethodIterator.remove();
            }
        }
        return paymentMethods;
    }

    // public ReservationInfo getReservationInfo(final String reservationId,
    // final String paymentMethodId) throws IOException,
    // NumberFormatException, ParseException, CommonException,
    // HibernateException {
    // ReservationInfo reservationInfo = null;
    // int quantity = 0;
    // ReservationBean reservationBean = null;
    // TripBean[] startEndTrips = null;
    // BigDecimal basePrice = null;
    // CurrencyConverter converter = null;
    //
    // reservationBean = reservationDAO.loadById(Integer
    // .parseInt(reservationId));
    // reservationInfo = new ReservationInfo();
    // startEndTrips = ReservationUtils
    // .getStartEndTrips(reservationBean.getTrips()).values()
    // .iterator().next();
    // reservationInfo.setRouteName(reservationBean.getTrips().get(0)
    // .getRouteDetails().getRoute().getName());
    // reservationInfo.setSubRouteName(startEndTrips[0].getRouteDetails()
    // .getSegment().getStartAt().getCity().getName()
    // + " - "
    // + startEndTrips[1].getRouteDetails().getSegment().getEndAt()
    // .getCity().getName());
    // reservationInfo.setDepartureStationAddress(startEndTrips[0]
    // .getRouteDetails().getSegment().getStartAt().getAddress());
    // reservationInfo.setDepartureDate(FormatUtils.formatDate(
    // startEndTrips[0].getDepartureTime(),
    // "EEEEE dd/MM/yyyy hh:mm aa", CommonConstant.LOCALE_VN));
    // reservationInfo.setArrivalStationAddress(startEndTrips[1]
    // .getRouteDetails().getSegment().getEndAt().getAddress());
    // reservationInfo.setArrivalDate(FormatUtils.formatDate(
    // startEndTrips[1].getArrivalTime(), "EEEEE dd/MM/yyyy hh:mm aa",
    // CommonConstant.LOCALE_VN));
    // reservationInfo.setSeatNumbers(getSeatNumbers(reservationBean
    // .getSeatPositions()));
    // quantity = reservationBean.getSeatPositions().size();
    // reservationInfo.setQuantity(Integer.toString(quantity));
    // try {
    // converter = CurrencyConverter.getInstance(
    // Currency.getInstance("VND"), Currency.getInstance("USD"));
    // } catch (InstantiationException e) {
    // LOG.error("Impossible error", e);
    // throw new CommonException(e);
    // }
    // basePrice = roundingVND(calculateTicketPrice(tariffDAO
    // .getFares(reservationBean)));
    // reservationInfo.setBasePrice(FormatUtils.formatNumber(basePrice, 0,
    // CommonConstant.LOCALE_VN));
    // reservationInfo.setBasePriceInUSD(FormatUtils.formatNumber(
    // converter.convert(basePrice), 2, CommonConstant.LOCALE_VN));
    // updateReservationPaymentInfo(reservationInfo,
    // Integer.parseInt(paymentMethodId));
    // return reservationInfo;
    // }

    /**
     * @param info
     *            reservation information
     * @param paymentMethodId
     * @throws CommonException
     * @throws HibernateException
     */
    public void updateReservationPaymentInfo(ReservationInfo info,
            final int paymentMethodId) throws CommonException,
            HibernateException {
        BigDecimal fee = null;
        BigDecimal totalAmount = null;
        CurrencyConverter converter = null;
        PaymentMethodBean paymentMethod = null;
        try {
            converter = CurrencyConverter.getInstance(
                    Currency.getInstance("VND"), Currency.getInstance("USD"));
        } catch (InstantiationException e) {
            LOG.error("Impossible error", e);
        } catch (IOException e) {
            // TODO handle error
            throw new CommonException(e);
        }
        paymentMethod = paymentMethodDAO.getById(paymentMethodId);
        try {
            fee = roundingVND(
                    calculateFee(info.getBasePrice(), info.getQuantity(),
                            paymentMethod), RoundingMode.CEILING);
            totalAmount = roundingVND(
                    calculateTotal(info.getBasePrice(), info.getQuantity(), fee),
                    RoundingMode.CEILING);
        } catch (IOException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (ParseException e) {
            // TODO handle error
            throw new CommonException(e);
        }
        info.setTransactionFee(FormatUtils.formatNumber(fee, 0,
                CommonConstant.LOCALE_VN));
        info.setTransactionFeeInUSD(FormatUtils.formatNumber(
                converter.convert(fee), 2, CommonConstant.LOCALE_VN));
        info.setTotalAmount(FormatUtils.formatNumber(totalAmount, 0,
                CommonConstant.LOCALE_VN));
        info.setTotalAmountInUSD(FormatUtils.formatNumber(
                converter.convert(totalAmount), 2, CommonConstant.LOCALE_VN));
    }

    public RefundInfo calculateRefundAmount(int reservationId)
            throws CommonException {
        RefundInfo refundInfo = null;
        ReservationInfoBean reservationInfo = null;
        Double amount = null;
        List<SystemSettingBean> settings = null;
        int refundRate = 0;
        int[] rates = null;
        int[] limits = null;
        String[] settingKey = null;
        int settingCount = 0;
        Calendar timelimit = null;
        Date today = null;
        CurrencyConverter converter = null;
        reservationInfo = reservationInfoDAO.getById(reservationId);
        amount = reservationInfo.getPaidAmount();
        if (amount != null && amount > 0) {
            settings = systemSettingDAO.getAllLike("refund%");
            if (settings == null || settings.size() % 2 != 0) {
                throw new CommonException();
            }
            settingCount = settings.size() / 2;
            rates = new int[settingCount];
            limits = new int[settingCount];
            for (SystemSettingBean setting : settings) {
                settingKey = setting.getId().split("\\.");
                if (settingKey[2].equals("rate")) {
                    rates[Integer.parseInt(settingKey[1]) - 1] = Integer
                            .parseInt(setting.getValue());
                } else {
                    limits[Integer.parseInt(settingKey[1]) - 1] = Integer
                            .parseInt(setting.getValue());
                }
            }
            timelimit = Calendar.getInstance();
            today = new Date();
            for (int i = 0; i < settingCount; i++) {
                timelimit.setTime(reservationInfo.getStartTrip()
                        .getDepartureTime());
                timelimit.add(Calendar.DATE, -limits[i]);
                if (today.before(timelimit.getTime())) {
                    refundRate = rates[i];
                    break;
                }
            }
            if (refundRate == 0) {
                // TODO handle error
                throw new CommonException();
            }
            try {
                converter = CurrencyConverter.getInstance(
                        Currency.getInstance("VND"),
                        Currency.getInstance("USD"));
            } catch (InstantiationException e) {
                LOG.error("Impossible error", e);
            } catch (IOException e) {
                // TODO handle error
                throw new CommonException(e);
            }
            amount = roundingVND(amount, RoundingMode.FLOOR) * refundRate / 100;
            refundInfo = new RefundInfo();
            refundInfo.setRefundAmount(amount);
            refundInfo.setRefundRate(refundRate);
            refundInfo.setRefundAmountInUSD(converter.convert(amount));
            return refundInfo;
        } else {
            // TODO handle error
            throw new CommonException();
        }
    }

    /**
     * @param reservation
     *            reservation information
     * @return the payment details, which includes the total paid or refunded
     *         amount in VND, the service fee for the payment method provider in
     *         VND, and the transaction id
     * @throws CommonException
     */
    public String[] doPaypalRefund(int reservationId) throws CommonException {
        String[] result = null;
        PayPalAPIInterfaceServiceService service = null;
        PaymentBean payment = null;
        RefundTransactionResponseType response = null;
        RefundTransactionReq request = null;
        RefundTransactionRequestType requestDetails = null;
        BasicAmountType amount = null;
        CurrencyConverter converter = null;
        BigDecimal refundAmount = null;
        Date today = null;
        int[] limits = null;
        int[] rates = null;
        int refundRate = 0;
        List<SystemSettingBean> settings = null;
        int settingCount = 0;
        String[] settingKey = null;
        Calendar timelimit = null;
        ReservationInfoBean reservation = null;

        reservation = reservationInfoDAO.getById(reservationId);
        if (ReservationStatus.PAID.getValue().equals(
                reservation.getId().getStatus())) {
            refundAmount = BigDecimal.valueOf(reservation.getPaidAmount());
            settings = systemSettingDAO.getAllLike("refund%");
            if (settings == null || settings.size() % 2 != 0) {
                throw new CommonException();
            }
            settingCount = settings.size() / 2;
            rates = new int[settingCount];
            limits = new int[settingCount];
            for (SystemSettingBean setting : settings) {
                settingKey = setting.getId().split("\\.");
                if (settingKey[2].equals("rate")) {
                    rates[Integer.parseInt(settingKey[1]) - 1] = Integer
                            .parseInt(setting.getValue());
                } else {
                    limits[Integer.parseInt(settingKey[1]) - 1] = Integer
                            .parseInt(setting.getValue());
                }
            }
            timelimit = Calendar.getInstance();
            today = new Date();
            for (int i = 0; i < settingCount; i++) {
                timelimit
                        .setTime(reservation.getStartTrip().getDepartureTime());
                timelimit.add(Calendar.DATE, -limits[i]);
                if (today.before(timelimit.getTime())) {
                    refundRate = rates[i];
                    break;
                }
            }
            if (refundRate == 0) {
                // TODO handle error
                throw new CommonException();
            }
            refundAmount = roundingVND(
                    refundAmount.multiply(BigDecimal.valueOf(refundRate))
                            .divide(BigDecimal.valueOf(100)),
                    RoundingMode.FLOOR);
            payment = reservation.getId().getPayments().get(0);
            request = new RefundTransactionReq();
            requestDetails = new RefundTransactionRequestType();
            request.setRefundTransactionRequest(requestDetails);
            requestDetails.setTransactionID(payment.getTransactionId());
            requestDetails.setRefundType(RefundType.PARTIAL);
            amount = new BasicAmountType();
            requestDetails.setAmount(amount);
            amount.setCurrencyID(CurrencyCodeType.USD);
            try {
                converter = CurrencyConverter.getInstance(
                        Currency.getInstance("VND"),
                        Currency.getInstance("USD"));
            } catch (InstantiationException e) {
                LOG.error("Impossible error", e);
            } catch (IOException e) {
                // TODO handle error
                throw new CommonException(e);
            }
            refundAmount = converter.convert(refundAmount);
            amount.setValue(refundAmount.setScale(2, RoundingMode.FLOOR)
                    .toString());
            try {
                service = new PayPalAPIInterfaceServiceService(this.getClass()
                        .getResourceAsStream("/paypal/sdk_config.properties"));
                response = service.refundTransaction(request);
            } catch (Exception e) {
                // TODO handle error
                throw new CommonException(e);
            }
            if (response != null) {
                if (response.getAck().toString().equalsIgnoreCase("SUCCESS")) {
                    result = new String[3];
                    result[0] = response.getGrossRefundAmount().getValue();
                    result[1] = response.getFeeRefundAmount().getValue();
                    result[2] = response.getRefundTransactionID();
                } else {
                    for (ErrorType error : response.getErrors()) {
                        LOG.error("PAYPAL error: " + error.getErrorCode() + ":"
                                + error.getLongMessage());
                    }
                    // TODO handle error
                    throw new CommonException();
                }
            } else {
                // TODO handle error
                LOG.error("Null response from paypal");
                throw new CommonException();
            }
        } else {
            // TODO handle error
            throw new CommonException();
        }
        return result;
    }

    public String setPaypalExpressCheckout(ReservationInfo reservationInfo,
            String contextPath) throws CommonException {
        PayPalAPIInterfaceServiceService service = null;
        SetExpressCheckoutReq setExpressCheckoutReq = null;
        SetExpressCheckoutRequestType checkoutRequest = null;
        SetExpressCheckoutResponseType checkoutResponse = null;
        SetExpressCheckoutRequestDetailsType details = null;
        BasicAmountType orderTotal = null;
        StringBuilder url = null;
        String paymentToken = null;
        List<PaymentDetailsType> paymentDetailsList = null;
        PaymentDetailsType paymentDetails = null;
        List<PaymentDetailsItemType> items = null;
        PaymentDetailsItemType item = null;

        checkoutRequest = new SetExpressCheckoutRequestType();
        details = new SetExpressCheckoutRequestDetailsType();
        url = new StringBuilder();
        url.append("https://");
        url.append("localhost:8443");
        url.append(contextPath);
        // set return pages
        details.setReturnURL(url.toString() + "/pay/pay01030.html");
        details.setCancelURL(url.toString() + "/pay/pay01031.html");
        // set payment details
        paymentDetailsList = new ArrayList<PaymentDetailsType>();
        paymentDetails = new PaymentDetailsType();
        paymentDetails.setPaymentAction(PaymentActionCodeType.SALE);
        items = new ArrayList<PaymentDetailsItemType>();
        item = new PaymentDetailsItemType();
        item.setName("Ticket");
        item.setQuantity(Integer.parseInt(reservationInfo.getQuantity()));
        try {
            item.setAmount(new BasicAmountType(CurrencyCodeType.USD,
                    FormatUtils.deformatNumber(
                            reservationInfo.getBasePriceInUSD(),
                            CommonConstant.LOCALE_VN).toString()));
        } catch (ParseException e) {
            // TODO handle error
            throw new CommonException(e);
        }
        item.setItemCategory(ItemCategoryType.DIGITAL);
        items.add(item);
        item = new PaymentDetailsItemType();
        item.setName("Fee");
        item.setQuantity(1);
        try {
            item.setAmount(new BasicAmountType(CurrencyCodeType.USD,
                    FormatUtils.deformatNumber(
                            reservationInfo.getTransactionFeeInUSD(),
                            CommonConstant.LOCALE_VN).toString()));
        } catch (ParseException e) {
            // TODO handle error
            throw new CommonException(e);
        }
        item.setItemCategory(ItemCategoryType.DIGITAL);
        items.add(item);
        paymentDetails.setPaymentDetailsItem(items);
        paymentDetailsList.add(paymentDetails);
        details.setPaymentDetails(paymentDetailsList);
        // set total amount
        orderTotal = new BasicAmountType();
        orderTotal.setCurrencyID(CurrencyCodeType.USD);
        try {
            orderTotal.setValue(FormatUtils.deformatNumber(
                    reservationInfo.getTotalAmountInUSD(),
                    CommonConstant.LOCALE_VN).toString());
        } catch (ParseException e) {
            // TODO handle error
            throw new CommonException(e);
        }
        details.setOrderTotal(orderTotal);
        details.setPaymentAction(PaymentActionCodeType.SALE);
        // set details to request
        checkoutRequest.setSetExpressCheckoutRequestDetails(details);

        try {
            service = new PayPalAPIInterfaceServiceService(this.getClass()
                    .getResourceAsStream("/paypal/sdk_config.properties"));
        } catch (IOException e) {
            // TODO handle error
            throw new CommonException(e);
        }
        setExpressCheckoutReq = new SetExpressCheckoutReq();
        setExpressCheckoutReq.setSetExpressCheckoutRequest(checkoutRequest);
        try {
            checkoutResponse = service
                    .setExpressCheckout(setExpressCheckoutReq);
        } catch (SSLConfigurationException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (InvalidCredentialException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (HttpErrorException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (InvalidResponseDataException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (ClientActionRequiredException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (MissingCredentialException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (OAuthException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (IOException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (InterruptedException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (ParserConfigurationException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (SAXException e) {
            // TODO handle error
            throw new CommonException(e);
        }

        if (checkoutResponse != null) {
            if (checkoutResponse.getAck().toString()
                    .equalsIgnoreCase("SUCCESS")) {
                paymentToken = checkoutResponse.getToken();
            } else {
                for (ErrorType error : checkoutResponse.getErrors()) {
                    LOG.error(error.getErrorCode() + ":"
                            + error.getLongMessage());
                }
                // TODO handle error
                throw new CommonException();
            }
        } else {
            // TODO handle error
            LOG.error("Null response from paypal");
            throw new CommonException();
        }
        return paymentToken;
    }

    public GetExpressCheckoutDetailsResponseType getPaypalExpressCheckoutDetails(
            String token) throws CommonException {
        PayPalAPIInterfaceServiceService service = null;
        GetExpressCheckoutDetailsReq checkoutDetailsReq = null;
        GetExpressCheckoutDetailsRequestType checkoutDetailsRequest = null;
        GetExpressCheckoutDetailsResponseType checkoutDetailsResponse = null;
        paymentDAO.endTransaction();
        // Execute payment
        checkoutDetailsRequest = new GetExpressCheckoutDetailsRequestType(token);
        checkoutDetailsReq = new GetExpressCheckoutDetailsReq();
        checkoutDetailsReq
                .setGetExpressCheckoutDetailsRequest(checkoutDetailsRequest);
        try {
            service = new PayPalAPIInterfaceServiceService(this.getClass()
                    .getResourceAsStream("/paypal/sdk_config.properties"));
        } catch (IOException e) {
            // TODO handle error
            throw new CommonException();
        }
        try {
            checkoutDetailsResponse = service
                    .getExpressCheckoutDetails(checkoutDetailsReq);
        } catch (SSLConfigurationException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (InvalidCredentialException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (HttpErrorException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (InvalidResponseDataException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (ClientActionRequiredException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (MissingCredentialException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (OAuthException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (IOException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (InterruptedException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (ParserConfigurationException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (SAXException e) {
            // TODO handle error
            throw new CommonException(e);
        }

        if (checkoutDetailsResponse != null) {
            if ("SUCCESS".equalsIgnoreCase(checkoutDetailsResponse.getAck()
                    .toString())) {
                // do nothing
            } else {
                for (ErrorType error : checkoutDetailsResponse.getErrors()) {
                    LOG.error(error.getErrorCode() + ":"
                            + error.getLongMessage());
                }
                // TODO handle error
                throw new CommonException();
            }
        } else {
            // TODO handle error
            LOG.error("Null response from paypal");
            throw new CommonException();
        }
        return checkoutDetailsResponse;
    }

    public String[] doPaypalExpressCheckoutPayment(
            GetExpressCheckoutDetailsResponseType checkoutDetailsResponse)
            throws CommonException {
        PayPalAPIInterfaceServiceService service = null;
        DoExpressCheckoutPaymentReq doExpressCheckoutPaymentReq = null;
        DoExpressCheckoutPaymentRequestType doRequest = null;
        DoExpressCheckoutPaymentRequestDetailsType details = null;
        DoExpressCheckoutPaymentResponseType doResponse = null;
        String[] result = null;
        details = new DoExpressCheckoutPaymentRequestDetailsType();
        details.setToken(checkoutDetailsResponse
                .getGetExpressCheckoutDetailsResponseDetails().getToken());
        details.setPayerID(checkoutDetailsResponse
                .getGetExpressCheckoutDetailsResponseDetails().getPayerInfo()
                .getPayerID());
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
            service = new PayPalAPIInterfaceServiceService(this.getClass()
                    .getResourceAsStream("/paypal/sdk_config.properties"));
        } catch (IOException e) {
            // TODO handle error
            throw new CommonException();
        }
        try {
            doResponse = service
                    .doExpressCheckoutPayment(doExpressCheckoutPaymentReq);
        } catch (SSLConfigurationException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (InvalidCredentialException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (HttpErrorException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (InvalidResponseDataException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (ClientActionRequiredException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (MissingCredentialException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (OAuthException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (IOException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (InterruptedException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (ParserConfigurationException e) {
            // TODO handle error
            throw new CommonException(e);
        } catch (SAXException e) {
            // TODO handle error
            throw new CommonException(e);
        }
        if (doResponse != null) {
            if (doResponse.getAck().toString().equalsIgnoreCase("SUCCESS")) {

            } else {
                for (ErrorType error : doResponse.getErrors()) {
                    LOG.error(error.getErrorCode() + ":"
                            + error.getLongMessage());
                }
                // TODO handle error
                throw new CommonException();
            }
        } else {
            // TODO handle error
            LOG.error("Null response from paypal");
            throw new CommonException();
        }
        doResponse.getDoExpressCheckoutPaymentResponseDetails()
                .getPaymentInfo().get(0).getTransactionID();
        // get amount from paypal's response
        // paidAmount = BigDecimal.ZERO;
        // fee = BigDecimal.ZERO;
        // for (PaymentDetailsItemType item : ) {
        // if (item.getName().contains("Ticket")) {
        // paidAmount = paidAmount.add(new BigDecimal(item.getAmount()
        // .getValue()).multiply(BigDecimal.valueOf(item
        // .getQuantity())));
        // } else if (item.getName().contains("Fee")) {
        // fee = fee.add(new BigDecimal(item.getAmount().getValue())
        // .multiply(BigDecimal.valueOf(item.getQuantity())));
        // }
        // }
        result = new String[3];
        result[0] = doResponse.getDoExpressCheckoutPaymentResponseDetails()
                .getPaymentInfo().get(0).getGrossAmount().getValue();
        result[1] = doResponse.getDoExpressCheckoutPaymentResponseDetails()
                .getPaymentInfo().get(0).getFeeAmount().getValue();
        result[2] = doResponse.getDoExpressCheckoutPaymentResponseDetails()
                .getPaymentInfo().get(0).getTransactionID();
        paymentDAO.startTransaction();
        return result;
    }

    /**
     * @param reservationId
     *            identifier of the reservation to be paid or refund for
     * @param paymentDetails
     *            the total paid or refunded amount in VND, the service fee for
     *            the payment method provider in VND, and the transaction id
     * @param paymentMethodId
     *            identifier of the payment method
     * @param paymentType
     *            is the transaction a payment or a refund
     * @return reservation code
     * @throws CommonException
     * @throws HibernateException
     */
    public String savePayment(String reservationId, String[] paymentDetails,
            int paymentMethodId, PaymentType paymentType)
            throws CommonException, HibernateException {
        ReservationBean reservation = null;
        PaymentBean payment = null;
        int maxTry = CommonConstant.MAX_REGENERATE_CODE_TRY;
        String reservationCode = null;
        CurrencyConverter converter = null;
        // Update database
        reservation = reservationDAO.getById(Integer.parseInt(reservationId));
        payment = new PaymentBean();
        payment.setReservation(reservation);
        // Payment method
        if (paymentMethodId == 0 && PaymentType.REFUND.equals(paymentType)) {
            // try to get payment method from payment
            payment.setPaymentMethod(reservation.getPayments().get(0)
                    .getPaymentMethod());
        } else {
            payment.setPaymentMethod(paymentMethodDAO.getById(paymentMethodId));
        }
        try {
            converter = CurrencyConverter.getInstance(
                    Currency.getInstance("USD"), Currency.getInstance("VND"));
        } catch (InstantiationException e) {
            LOG.error("Impossible error", e);
            throw new CommonException(e);
        } catch (IOException e) {
            // TODO handle error
            throw new CommonException(e);
        }
        payment.setPayAmount(roundingVND(
                converter.convert(new BigDecimal(paymentDetails[0])),
                RoundingMode.FLOOR).doubleValue());
        payment.setServiceFee(roundingVND(
                converter.convert(new BigDecimal(paymentDetails[1])),
                RoundingMode.FLOOR).doubleValue());
        payment.setTransactionId(paymentDetails[2]);
        // Payment type
        payment.setType(paymentType.getValue());
        paymentDAO.insert(payment);
        // Generate reservation code
        if (CheckUtils.isNullOrBlank(reservation.getCode())) {
            try {
                reservationCode = CryptUtils.generateCode(reservation.getId(),
                        6);
                // Anti duplicate code
                if (reservationDAO.getByCode(reservationCode) != null) {
                    maxTry = 3;
                    for (int i = 0; i < maxTry; i++) {
                        reservationCode = CryptUtils.generateCode(
                                reservation.getId(), 6, reservationCode);
                        if (reservationDAO.getByCode(reservationCode) != null) {
                            // When generated code is duplicated
                            if (i + 1 >= maxTry) {
                                // TODO handle error
                                throw new CommonException();
                            } else {
                                // continue
                            }
                        } else {
                            // stop generate when a unique code has been
                            // generated
                            break;
                        }
                    }
                }
            } catch (NoSuchAlgorithmException e) {
                // impossible
                throw new CommonException(e);
            }
            reservation.setCode(reservationCode);
        } else {
            reservationCode = reservation.getCode();
        }
        if (PaymentType.PAY.equals(paymentType)) {
            reservation.setStatus(ReservationStatus.PAID.getValue());
        } else {
            reservation.setStatus(ReservationStatus.REFUNDED.getValue());
        }
        reservationDAO.update(reservation);
        return reservationCode;
    }

    private BigDecimal calculateTotal(final String basePrice,
            final String quantity, final BigDecimal fee) throws ParseException {
        BigDecimal result = null;
        result = FormatUtils
                .deformatNumber(basePrice, CommonConstant.LOCALE_VN)
                .multiply(new BigDecimal(quantity)).add(fee);
        return result;
    }

    private BigDecimal calculateFee(final String basePrice,
            final String quantity, final PaymentMethodBean paymentMethod)
            throws IOException, ParseException {
        BigDecimal result = null;
        BigDecimal constantFee = null;
        BigDecimal feeRatio = null;
        CurrencyConverter converter = null;
        try {
            converter = CurrencyConverter.getInstance(
                    Currency.getInstance("USD"), Currency.getInstance("VND"));
        } catch (InstantiationException e) {
            LOG.error("Impossible error", e);
        }
        constantFee = converter.convert(BigDecimal.valueOf(paymentMethod
                .getAddition()));
        feeRatio = BigDecimal.valueOf(paymentMethod.getRatio());
        result = BigDecimal.ZERO
                .add(FormatUtils.deformatNumber(basePrice,
                        CommonConstant.LOCALE_VN).multiply(
                        new BigDecimal(quantity)))
                .add(constantFee)
                .divide(BigDecimal.ONE.subtract(feeRatio), 0,
                        RoundingMode.CEILING).multiply(feeRatio)
                .add(constantFee);
        return result;
    }

    private BigDecimal roundingVND(final BigDecimal number,
            RoundingMode roundingMode) {
        return number.divide(BigDecimal.valueOf(500), 0, roundingMode)
                .multiply(BigDecimal.valueOf(500));
    }

    private Double roundingVND(final Double number, RoundingMode roundingMode) {
        if (number == null) {
            return null;
        } else if (roundingMode == null
                || RoundingMode.CEILING.equals(roundingMode)) {
            return Math.ceil(number / 500) * 500;
        } else if (RoundingMode.FLOOR.equals(roundingMode)) {
            return Math.floor(number / 500) * 500;
        } else if (RoundingMode.DOWN.equals(roundingMode)) {
            if (number > 0) {
                return Math.floor(number / 500) * 500;
            } else {
                return Math.ceil(number / 500) * 500;
            }
        } else if (RoundingMode.UP.equals(roundingMode)) {
            if (number > 0) {
                return Math.ceil(number / 500) * 500;
            } else {
                return Math.floor(number / 500) * 500;
            }
        } else if (RoundingMode.UNNECESSARY.equals(roundingMode)) {
            return number;
        } else if (RoundingMode.HALF_UP.equals(roundingMode)) {
            return (double) Math.round(number / 500) * 500;
        } else if (RoundingMode.HALF_DOWN.equals(roundingMode)) {
            return (double) Math.ceil(number / 500 - 0.5) * 500;
        } else {
            throw new UnsupportedOperationException();
        }
    }

    public void sendCancelReservationMail(int reservationId, String contextPath)
            throws CommonException {
        Properties globalProps = null;
        Properties props = null;
        String templateName = null;
        MailTemplateBean mailTemplateBean = null;
        StringBuilder subject = null;
        StringBuilder content = null;
        StringBuilder url = null;
        Session session = null;
        Message message = null;
        List<TicketInfoBean> ticketInfos = null;
        StringBuilder seatNumbers = null;
        int count = 0;
        double total = 0;
        double paidAmount = 0;
        double refundAmount = 0;
        // build subject and content
        globalProps = new Properties();
        try {
            globalProps.load(getClass().getResourceAsStream(
                    "/global.properties"));
        } catch (IOException e) {
            throw new CommonException(e);
        }
        templateName = (String) globalProps.get("mail.template.resCancel");
        ticketInfos = ticketDAO.getTicketInfo(reservationId);
        mailTemplateBean = mailTemplateDAO.getByName(templateName);
        subject = new StringBuilder(mailTemplateBean.getSubject());
        content = new StringBuilder(mailTemplateBean.getText());
        MailUtils.replace(subject, ":companyName:",
                globalProps.getProperty("company.fullName"));
        MailUtils.replace(content, ":companyName:",
                globalProps.getProperty("company.fullName"));
        MailUtils.replace(content, ":siteName:",
                globalProps.getProperty("company.siteName"));
        MailUtils.replace(content, ":fullName:", ticketInfos.get(0).getId()
                .getReservation().getBookerLastName()
                + " "
                + ticketInfos.get(0).getId().getReservation()
                        .getBookerFirstName());
        MailUtils.replace(content, ":reservationCode:", ticketInfos.get(0)
                .getId().getReservation().getCode());
        MailUtils.replace(content, ":bookTime:", DateUtils.date2String(
                ticketInfos.get(0).getId().getReservation().getBookTime(),
                "dd/MM/yyyy hh:mm aa", CommonConstant.LOCALE_VN,
                CommonConstant.DEFAULT_TIME_ZONE));
        MailUtils.replaceLoop(content, "loopTicket", ticketInfos.size());
        seatNumbers = new StringBuilder();
        for (TicketInfoBean bean : ticketInfos) {
            count++;
            MailUtils.replace(content, ":from_" + count + ":", bean
                    .getStartTrip().getRouteDetails().getSegment().getStartAt()
                    .getCity().getName());
            MailUtils.replace(content, ":to_" + count + ":", bean.getEndTrip()
                    .getRouteDetails().getSegment().getEndAt().getCity()
                    .getName());
            MailUtils.replace(content, ":fromDate_" + count + ":", DateUtils
                    .date2String(bean.getStartTrip().getDepartureTime(),
                            "dd/MM/yyyy hh:mm aa", CommonConstant.LOCALE_VN,
                            CommonConstant.DEFAULT_TIME_ZONE));
            MailUtils.replace(content, ":toDate_" + count + ":", DateUtils
                    .date2String(bean.getEndTrip().getArrivalTime(),
                            "dd/MM/yyyy hh:mm aa", CommonConstant.LOCALE_VN,
                            CommonConstant.DEFAULT_TIME_ZONE));
            // clean string builder
            seatNumbers.setLength(0);
            for (SeatPositionBean seatPosition : bean.getId()
                    .getSeatPositions()) {
                seatNumbers.append(seatPosition.getName() + ", ");
            }
            // remove the last ", "
            seatNumbers.setLength(seatNumbers.length() - 2);
            MailUtils.replace(content, ":seatNumbers_" + count + ":",
                    seatNumbers.toString());
            MailUtils.replace(content, ":ticketPrice_" + count + ":",
                    FormatUtils.formatNumber(
                            roundingVND(bean.getTicketPrice(),
                                    RoundingMode.CEILING), 0,
                            CommonConstant.LOCALE_VN));
            total += bean.getTicketPrice()
                    * bean.getId().getSeatPositions().size();
        }
        MailUtils.replace(
                content,
                ":totalAmount:",
                FormatUtils.formatNumber(
                        roundingVND(total, RoundingMode.CEILING), 0,
                        CommonConstant.LOCALE_VN) + " VND");
        if (ticketInfos.get(0).getId().getReservation().getPayments() != null) {
            for (PaymentBean payment : ticketInfos.get(0).getId()
                    .getReservation().getPayments()) {
                if (PaymentType.PAY.getValue().equals(payment.getType())) {
                    paidAmount += payment.getPayAmount();
                } else {
                    refundAmount += payment.getPayAmount();
                }
            }
        }
        MailUtils.replace(
                content,
                ":fee:",
                FormatUtils.formatNumber(
                        roundingVND(paidAmount - total, RoundingMode.FLOOR), 0,
                        CommonConstant.LOCALE_VN) + " VND");
        MailUtils.replace(
                content,
                ":amountToBePaid:",
                FormatUtils.formatNumber(
                        roundingVND(paidAmount, RoundingMode.CEILING), 0,
                        CommonConstant.LOCALE_VN) + " VND");
        MailUtils.replace(
                content,
                ":refundedAmount:",
                FormatUtils.formatNumber(
                        roundingVND(refundAmount, RoundingMode.CEILING), 0,
                        CommonConstant.LOCALE_VN) + " VND");
        url = new StringBuilder();
        url.append(CommonConstant.URL_HTTP);
        url.append(contextPath);
        MailUtils.replace(content, ":siteurl:", url.toString() + "/");
        try {
            mailTemplateDAO.endTransaction();
        } catch (HibernateException e) {
            throw new CommonException(e.getMessage(), e);
        }
        // prepare mail object
        props = new Properties();
        props.put("mail.smtp.auth", globalProps.get("mail.smtp.auth"));
        props.put("mail.smtp.starttls.enable",
                globalProps.get("mail.smtp.starttls.enable"));
        props.put("mail.smtp.host", globalProps.get("mail.smtp.host"));
        props.put("mail.smtp.port", globalProps.get("mail.smtp.port"));
        session = Session.getInstance(
                props,
                new MailPasswordAuthenticator(globalProps
                        .getProperty("mail.auth.username"), globalProps
                        .getProperty("mail.auth.password")));
        try {
            message = new MimeMessage(session);
            message.setFrom(new InternetAddress(globalProps
                    .getProperty("mail.info.from")));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(ticketInfos.get(0).getId()
                            .getReservation().getEmail()));
            try {
                message.setSubject(MimeUtility.encodeText(subject.toString(),
                        "utf-8", "Q"));
            } catch (UnsupportedEncodingException e) {
                throw new CommonException(e);
            }
            message.setContent(content.toString(), "text/html;charset=utf-8");

            Transport.send(message);
        } catch (MessagingException e) {
            throw new CommonException(e);
        }
    }

}
