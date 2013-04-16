/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.util;

import java.io.File;
import java.io.IOException;

import javax.xml.transform.TransformerException;

import org.apache.fop.apps.FOPException;
import org.junit.Test;

import vn.edu.fpt.capstone.busReservation.displayModel.ReservationInfo;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.logic.ReservationLogic;
import vn.edu.fpt.capstone.busReservation.testUtil.DAOTest;
import vn.edu.fpt.capstone.busReservation.util.xml.PDFUtils;

/**
 * @author Yoshimi
 * 
 */
public class PDFUtilsTest extends DAOTest {
    @Test
    public void convertReservationInfo2PDFTest001() throws CommonException,
            FOPException, IOException, TransformerException {
        ReservationLogic reservationLogic = (ReservationLogic) getBean("reservationLogic");
        ReservationInfo info = reservationLogic.loadReservationInfo(13, 6);
        File xslt = new File(ReservationLogic.class.getResource(
                "/xml/xslt/reservationinfo2fo.xsl").getPath());
        System.out.println(xslt);
        File dir = new File("TEMP");
        dir.mkdirs();
        File pdf = new File(dir, "temp.pdf");
        System.out.println(pdf.getAbsolutePath());
        PDFUtils.convertReservationInfo2PDF(info, xslt, pdf);
    }
}
