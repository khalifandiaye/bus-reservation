/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.util.xml;

import java.io.IOException;

import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo.Ticket;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;

/**
 * @author Yoshimi
 * 
 */
public class ReservationInfoXMLReader extends AbstractObjectReader {

    /*
     * (non-Javadoc)
     * 
     * @see
     * vn.edu.fpt.capstone.busReservation.util.xml.AbstractObjectReader#parse
     * (org.xml.sax.InputSource)
     */
    @Override
    public void parse(InputSource input) throws IOException, SAXException {
        if (input instanceof ReservationInfoInputSource) {
            parse(((ReservationInfoInputSource) input).getReservationInfo());
        } else {
            throw new SAXException("Unsupported InputSource specified. "
                    + "Must be a ProjectTeamInputSource");
        }
    }

    /**
     * Starts parsing the ReservationInfo object.
     * 
     * @param reservationInfo
     *            The object to parse
     * @throws SAXException
     *             In case of a problem during SAX event generation
     */
    public void parse(ReservationInfo reservationInfo) throws SAXException {
        if (reservationInfo == null) {
            throw new NullPointerException(
                    "Parameter reservationInfo must not be null");
        }
        if (handler == null) {
            throw new IllegalStateException("ContentHandler not set");
        }

        // Start the document
        handler.startDocument();

        // Generate SAX events for the ProjectTeam
        generateFor(reservationInfo);

        // End the document
        handler.endDocument();
    }

    /**
     * Generates SAX events for a ReservationInfo object.
     * 
     * @param reservationInfo
     *            ReservationInfo object to use
     * @throws SAXException
     *             In case of a problem during SAX event generation
     */
    protected void generateFor(ReservationInfo reservationInfo)
            throws SAXException {
        if (reservationInfo == null) {
            throw new NullPointerException(
                    "Parameter reservationInfo must not be null");
        }
        if (handler == null) {
            throw new IllegalStateException("ContentHandler not set");
        }

        handler.startElement("reservation");
        handler.element("id", Integer.toString(reservationInfo.getId()));
        handler.element("code", reservationInfo.getCode());
        handler.element("bookerName", reservationInfo.getBookerName());
        handler.element("phone", reservationInfo.getPhone());
        handler.element("email", reservationInfo.getEmail());
        handler.element("basePrice", reservationInfo.getBasePrice());
        handler.element("basePriceInUSD", reservationInfo.getBasePriceInUSD());
        handler.element("transactionFee", reservationInfo.getTransactionFee());
        handler.element("transactionFeeInUSD",
                reservationInfo.getTransactionFeeInUSD());
        handler.element("totalAmount", reservationInfo.getTotalAmount());
        handler.element("totalAmountInUSD",
                reservationInfo.getTotalAmountInUSD());
        if (reservationInfo.getRefundedAmountValue() != null
                && reservationInfo.getRefundedAmountValue() > 0) {
            handler.element("refundedAmount",
                    reservationInfo.getRefundedAmount());
            handler.element("refundedAmountInUSD",
                    reservationInfo.getRefundedAmountInUSD());
        }
        if (CheckUtils.isNullOrBlank(reservationInfo.getRefundRate())) {
            handler.element("refundRate", reservationInfo.getRefundRate());
        }
        handler.element("status", reservationInfo.getStatus());
        if (CheckUtils.isNullOrBlank(reservationInfo.getCancelReason())) {
            handler.element("cancelReason", reservationInfo.getCancelReason());
        }
        for (Ticket ticket : reservationInfo.getTickets()) {
            handler.startElement("ticket");
            handler.element("id", Integer.toString(ticket.getId()));
            handler.element("departureDate", ticket.getDepartureDate());
            handler.element("departureStation", ticket.getDepartureStation());
            handler.element("departureLocation", ticket.getDepartureLocation());
            handler.element("arrivalDate", ticket.getArrivalDate());
            handler.element("arrivalStation", ticket.getArrivalStation());
            handler.element("arrivalLocation", ticket.getArrivalLocation());
            handler.element("busType", ticket.getBusType());
            for (String seat : ticket.getSeats()) {
                handler.element("seat", seat);
            }
            handler.element("ticketPrice", ticket.getTicketPrice());
            handler.element("ticketPriceInUSD", ticket.getTicketPriceInUSD());
            handler.element("status", ticket.getStatus());
            handler.element("cancelReason", ticket.getCancelReason());
            handler.element("returnTrip",
                    Boolean.toString(ticket.isReturnTrip()));
            handler.endElement("ticket");
        }
        handler.endElement("reservation");
    }

}
