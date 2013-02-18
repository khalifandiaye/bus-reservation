/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.logic;

import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Currency;
import java.util.Iterator;
import java.util.List;

import javax.xml.parsers.ParserConfigurationException;

import org.hibernate.HibernateException;
import org.xml.sax.SAXException;

import urn.ebay.api.PayPalAPI.DoExpressCheckoutPaymentReq;
import urn.ebay.api.PayPalAPI.DoExpressCheckoutPaymentRequestType;
import urn.ebay.api.PayPalAPI.DoExpressCheckoutPaymentResponseType;
import urn.ebay.api.PayPalAPI.GetExpressCheckoutDetailsReq;
import urn.ebay.api.PayPalAPI.GetExpressCheckoutDetailsRequestType;
import urn.ebay.api.PayPalAPI.GetExpressCheckoutDetailsResponseType;
import urn.ebay.api.PayPalAPI.PayPalAPIInterfaceServiceService;
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
import urn.ebay.apis.eBLBaseComponents.SetExpressCheckoutRequestDetailsType;
import vn.edu.fpt.capstone.busReservation.dao.PaymentDAO;
import vn.edu.fpt.capstone.busReservation.dao.PaymentMethodDAO;
import vn.edu.fpt.capstone.busReservation.dao.ReservationDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentBean.PaymentType;
import vn.edu.fpt.capstone.busReservation.dao.bean.PaymentMethodBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.ReservationBean.ReservationStatus;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.CryptUtils;
import vn.edu.fpt.capstone.busReservation.util.CurrencyConverter;
import vn.edu.fpt.capstone.busReservation.util.FormatUtils;

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
    private PaymentMethodDAO paymentMethodDAO;
    private PaymentDAO paymentDAO;

    /**
     * @param reservationDAO
     *            the reservationDAO to set
     */
    public void setReservationDAO(ReservationDAO reservationDAO) {
        this.reservationDAO = reservationDAO;
    }

    /**
     * @param paymentMethodDAO
     *            the paymentMethodDAO to set
     */
    public void setPaymentMethodDAO(PaymentMethodDAO paymentMethodDAO) {
        this.paymentMethodDAO = paymentMethodDAO;
    }

    /**
     * @param paymentDAO
     *            the paymentDAO to set
     */
    public void setPaymentDAO(PaymentDAO paymentDAO) {
        this.paymentDAO = paymentDAO;
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
            if (paymentMethod.getId() != 2) {
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
            fee = roundingVND(calculateFee(info.getBasePrice(),
                    info.getQuantity(), paymentMethod), RoundingMode.CEILING);
            totalAmount = roundingVND(calculateTotal(info.getBasePrice(),
                    info.getQuantity(), fee), RoundingMode.CEILING);
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
        url.append("http://");
        url.append("localhost:8080");
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
        return result;
    }

    public String savePayment(String reservationId, String[] paymentDetails)
            throws CommonException, HibernateException, IOException {
        ReservationBean reservation = null;
        PaymentBean payment = null;
        int maxTry = CommonConstant.MAX_REGENERATE_CODE_TRY;
        String reservationCode = null;
        CurrencyConverter converter = null;
        paymentDAO.startTransaction();
        // Update database
        reservation = reservationDAO.getById(Integer.parseInt(reservationId));
        payment = new PaymentBean();
        payment.setReservation(reservation);
        // Payment method = PAYPAL
        payment.setPaymentMethod(paymentMethodDAO.getById(2));
        try {
            converter = CurrencyConverter.getInstance(
                    Currency.getInstance("USD"), Currency.getInstance("VND"));
        } catch (InstantiationException e) {
            LOG.error("Impossible error", e);
        }
        payment.setPayAmount(roundingVND(converter.convert(
                new BigDecimal(paymentDetails[0])), RoundingMode.FLOOR).doubleValue());
        payment.setServiceFee(roundingVND(converter.convert(
                new BigDecimal(paymentDetails[1])), RoundingMode.FLOOR).doubleValue());
        payment.setTransactionId(paymentDetails[2]);
        payment.setType(PaymentType.PAY.getValue());
        paymentDAO.insert(payment);
        // Generate reservation code
        try {
            reservationCode = CryptUtils.generateCode(reservation.getId(), 6);
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
                        // stop generate when a unique code has been generated
                        break;
                    }
                }
            }
        } catch (NoSuchAlgorithmException e) {
            LOG.error("Impossible error", e);
            throw new CommonException(e);
        }
        reservation.setCode(reservationCode);
        reservation.setStatus(ReservationStatus.PAID.getValue());
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

    private BigDecimal roundingVND(final BigDecimal number, RoundingMode roundingMode) {
        return number.divide(BigDecimal.valueOf(500), 0, roundingMode)
                .multiply(BigDecimal.valueOf(500));
    }

//    private BigDecimal calculateTicketPrice(final List<TariffBean> fares) {
//        BigDecimal result = null;
//        result = BigDecimal.ZERO;
//        for (TariffBean fare : fares) {
//            result = result.add(BigDecimal.valueOf(fare.getFare()));
//        }
//        return result;
//    }
//
//    private String getSeatNumbers(final List<SeatPositionBean> seatPositions) {
//        StringBuilder result = null;
//        result = new StringBuilder();
//        for (SeatPositionBean seatPosition : seatPositions) {
//            result.append(" " + seatPosition.getId().getName());
//        }
//        // remove first space
//        result.delete(0, 1);
//        return result.toString();
//    }

}
