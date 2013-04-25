/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.util;

import java.io.IOException;

import javax.xml.transform.TransformerException;

import org.junit.Test;
import org.xml.sax.SAXException;

import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;

/**
 * @author Yoshimi
 * 
 */
public class PDFUtilsTest extends DAOTest {
    @Test
    public void convertReservationInfo2PDFTest001() throws CommonException,
            IOException, TransformerException, SAXException {
//        ReservationLogic reservationLogic = (ReservationLogic) getBean("reservationLogic");
//        ReservationInfo info = reservationLogic.loadReservationInfo(13, 6);
//        File xslt = new File(ReservationLogic.class.getResource(
//                "/xml/xslt/reservationinfo2fo.xsl").getPath());
//        System.out.println(xslt);
//        File dir = new File("TEMP");
//        dir.mkdirs();
//        File pdf = new File(dir, "temp.pdf");
//        System.out.println(pdf.getAbsolutePath());
//        PDFUtils.convertReservationInfo2PDF(info, xslt, pdf);
    }
}
