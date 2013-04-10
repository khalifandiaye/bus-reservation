/**
 * 
 */
package vn.edu.fpt.capstone.busReservation.logic;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeUtility;

import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;

import org.hibernate.HibernateException;
import org.springframework.beans.factory.annotation.Autowired;

import vn.edu.fpt.capstone.busReservation.dao.MailTemplateDAO;
import vn.edu.fpt.capstone.busReservation.dao.RoleDAO;
import vn.edu.fpt.capstone.busReservation.dao.UserDAO;
import vn.edu.fpt.capstone.busReservation.dao.bean.MailTemplateBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean;
import vn.edu.fpt.capstone.busReservation.dao.bean.UserBean.UserStatus;
import vn.edu.fpt.capstone.busReservation.displayModel.RegisterModel;
import vn.edu.fpt.capstone.busReservation.displayModel.User;
import vn.edu.fpt.capstone.busReservation.exception.CommonException;
import vn.edu.fpt.capstone.busReservation.util.CheckUtils;
import vn.edu.fpt.capstone.busReservation.util.CommonConstant;
import vn.edu.fpt.capstone.busReservation.util.CryptUtils;
import vn.edu.fpt.capstone.busReservation.util.MailUtils;
import vn.edu.fpt.capstone.busReservation.util.MailUtils.MailPasswordAuthenticator;

/**
 * @author Yoshimi
 * 
 */
public class UserLogic extends BaseLogic {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    private UserDAO userDAO;
    private MailTemplateDAO mailTemplateDAO;
    private RoleDAO roleDAO;

    /**
     * @param userDAO
     *            the userDAO to set
     */
    @Autowired
    public void setUserDAO(UserDAO userDAO) {
        this.userDAO = userDAO;
    }

    /**
     * @param mailTemplateDAO
     *            the mailTemplateDAO to set
     */
    @Autowired
    public void setMailTemplateDAO(MailTemplateDAO mailTemplateDAO) {
        this.mailTemplateDAO = mailTemplateDAO;
    }

    /**
     * @param roleDAO
     *            the roleDAO to set
     */
    @Autowired
    public void setRoleDAO(RoleDAO roleDAO) {
        this.roleDAO = roleDAO;
    }

    public void registerUser(RegisterModel model) throws CommonException {
        // TODO implement it
        UserBean bean = null;
        bean = new UserBean();
        bean.setUsername(model.getUsername());
        try {
            bean.setPassword(CryptUtils.encrypt2String(model.getPassword()));
        } catch (NoSuchAlgorithmException e) {
            // Impossible exception
            throw new CommonException(e);
        }
        if (!CheckUtils.isNullOrBlank(model.getFirstName())) {
            bean.setFirstName(model.getFirstName());
        }
        if (!CheckUtils.isNullOrBlank(model.getLastName())) {
            bean.setLastName(model.getLastName());
        }
        if (!CheckUtils.isNullOrBlank(model.getPhoneNumber())) {
            bean.setPhoneNumber(model.getPhoneNumber());
        }
        if (!CheckUtils.isNullOrBlank(model.getMobileNumber())) {
            bean.setMobileNumber(model.getMobileNumber());
        }
        if (!CheckUtils.isNullOrBlank(model.getEmail())) {
            bean.setEmail(model.getEmail());
        }
        if (!CheckUtils.isNullOrBlank(model.getCivilId())) {
            bean.setCivilId(model.getCivilId());
        }
        bean.setRole(roleDAO.getById(1));
        bean.setStatus(UserStatus.NEW.getValue());
        userDAO.insert(bean);
    }

    public User activateUser(String username, String code)
            throws CommonException {
        User user = null;
        UserBean userBean = null;
        if (CheckUtils.isNullOrBlank(username)
                || CheckUtils.isNullOrBlank(code)) {
            throw new CommonException("msgerrau006");
        }
        userBean = userDAO.getByUsername(username);
        try {
            if (userBean != null
                    && code.equals(CryptUtils.encrypt2String(userBean
                            .getFirstName()
                            + "/"
                            + userBean.getLastName()
                            + "/" + userBean.getEmail()))
                    && UserStatus.NEW.getValue().equals(userBean.getStatus())) {
                userBean.setStatus(UserStatus.ACTIVE.getValue());
                userDAO.update(userBean);
                user = new User();
                user.setUserId(userBean.getId());
                user.setUsername(userBean.getUsername());
                user.setFirstName(userBean.getFirstName());
                user.setLastName(userBean.getLastName());
                user.setEmail(userBean.getEmail());
                user.setMobilePhone(userBean.getMobileNumber());
                user.setRoleId(userBean.getRole().getId());
            } else {
                throw new CommonException("msgerrau006");
            }
        } catch (NoSuchAlgorithmException e) {
            throw new CommonException(e);
        }
        return user;
    }

    public boolean isUsernameExists(String username) {
        return userDAO.getByUsername(username) != null;
    }

    public void sendActivationMail(RegisterModel model, String contextPath)
            throws CommonException {
        sendActivationMail(model.getUsername(), model.getFirstName(),
                model.getLastName(), model.getEmail(), contextPath);
    }

    public void sendActivationMail(String username, String contextPath)
            throws CommonException {
        UserBean user = null;
        try {
            user = userDAO.getByUsername(username);
            sendActivationMail(user.getUsername(), user.getFirstName(),
                    user.getLastName(), user.getEmail(), contextPath);
        } catch (Exception e) {
            String[] params = { CommonConstant.URL_HTTPS
                    + contextPath
                    + "/user/reg01021.html?username=" + username };
            throw new CommonException("msgerrau008", params, e);
        }
    }

    private void sendActivationMail(String username, String firstName,
            String lastName, String email, String contextPath)
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
        // build subject and content
        globalProps = new Properties();
        try {
            globalProps.load(getClass().getResourceAsStream(
                    "/global.properties"));
        } catch (IOException e) {
            throw new CommonException(e);
        }
        templateName = (String) globalProps.get("mail.template.resetPass");
        mailTemplateBean = mailTemplateDAO.getByName(templateName);
        subject = new StringBuilder(mailTemplateBean.getSubject());
        content = new StringBuilder(mailTemplateBean.getText());
        MailUtils.replace(subject, ":companyName:",
                globalProps.getProperty("company.fullName"));
        MailUtils.replace(content, ":siteName:",
                globalProps.getProperty("company.siteName"));
        MailUtils.replace(content, ":username:", username);
        MailUtils.replace(content, ":fullName:", lastName + " " + firstName);
        MailUtils.replace(content, ":email:", email);
        url = new StringBuilder();
        url.append(CommonConstant.URL_HTTPS);
        url.append(contextPath);
        MailUtils.replace(content, ":siteurl:", url.toString() + "/");
        try {
            MailUtils.replace(
                    content,
                    ":url:",
                    url.toString()
                            + "/user/activate-user.html?username="
                            + username
                            + "&code="
                            + CryptUtils.encrypt2String(firstName + "/"
                                    + lastName + "/" + email));
        } catch (NoSuchAlgorithmException e1) {
            throw new CommonException(e1);
        }
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
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(email));
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

    public boolean confirmCaptcha(String challenge, String response,
            String remoteip) throws CommonException {
        Properties globalProps = null;
        ReCaptchaImpl reCaptcha = null;
        ReCaptchaResponse reCaptchaResponse = null;
        globalProps = new Properties();
        try {
            globalProps.load(getClass().getResourceAsStream(
                    "/global.properties"));
        } catch (IOException e) {
            throw new CommonException(e);
        }
        reCaptcha = new ReCaptchaImpl();
        reCaptcha.setPrivateKey(globalProps.getProperty("captcha.privateKey"));
        reCaptchaResponse = reCaptcha
                .checkAnswer(remoteip, challenge, response);
        return reCaptchaResponse.isValid();
    }

    public User loginUser(String username, String password, String contextPath)
            throws CommonException {
        User user = null;
        UserBean userBean = null;
        try {
            userBean = userDAO.checkLogin(username,
                    CryptUtils.encrypt2String(password));
        } catch (NoSuchAlgorithmException e) {
            throw new CommonException(e);
        }
        if (userBean != null
                && UserStatus.ACTIVE.getValue().equals(userBean.getStatus())) {
            user = new User();
            user.setUserId(userBean.getId());
            user.setUsername(userBean.getUsername());
            user.setRoleId(userBean.getRole().getId());
            user.setFirstName(userBean.getFirstName());
            user.setLastName(userBean.getLastName());
            user.setEmail(userBean.getEmail());
            user.setMobilePhone(userBean.getMobileNumber());
        } else if (userBean != null
                && UserStatus.NEW.getValue().equals(userBean.getStatus())) {
            String[] params = { CommonConstant.URL_HTTPS
                    + contextPath
                    + "/user/reg01021.html?username=" + username };
            throw new CommonException("msgerrau007", params);
        } else {
            throw new CommonException("msgerrau001");
        }
        return user;
    }
    
    public void sendResetMailPub(String newPass, String firstName,
            String lastName, String email, String contextPath)
            throws CommonException {
    	sendResetMail(newPass, firstName, lastName, email, contextPath);
    }
    
    private void sendResetMail(String newPass, String firstName,
            String lastName, String email, String contextPath)
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
        // build subject and content
        globalProps = new Properties();
        try {
            globalProps.load(getClass().getResourceAsStream(
                    "/global.properties"));
        } catch (IOException e) {
            throw new CommonException(e);
        }
        templateName = (String) globalProps.get("mail.template.resetPass");
        mailTemplateBean = mailTemplateDAO.getByName(templateName);
        subject = new StringBuilder(mailTemplateBean.getSubject());
        content = new StringBuilder(mailTemplateBean.getText());
        MailUtils.replace(subject, ":companyName:",
                globalProps.getProperty("company.fullName"));
        MailUtils.replace(content, ":siteName:",
                globalProps.getProperty("company.siteName"));
        MailUtils.replace(content, ":fullName:", lastName + " " + firstName);
        MailUtils.replace(content, ":newPass:", newPass);
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
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(email));
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
