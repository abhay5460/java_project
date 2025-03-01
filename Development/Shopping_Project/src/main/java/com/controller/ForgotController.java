package com.controller;

import java.io.IOException;
import java.util.Properties;
import java.util.Random;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.dao.ForgotDao;
import com.model.Customer;

@WebServlet("/ForgotController")
public class ForgotController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String SENDER_ID = "dhairyathakkar2006@gmail.com";
    private static final String PASSWORD = "ofqnmayearvrvzmq";
    private static final String HOST = "smtp.gmail.com";
    private static final int OTP_LENGTH = 6;
    private static final int OTP_VALIDITY = 10 * 60; // 10 minutes

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action.toLowerCase()) {
            case "submit":
                handleOtpSubmission(request, response);
                break;
            case "verify":
                handleOtpVerification(request, response);
                break;
            case "confirm":
                handlePasswordReset(request, response);
                break;
            default:
                response.sendRedirect("index.jsp");
                break;
        }
    }

    private void handleOtpSubmission(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        ForgotDao dao = new ForgotDao();
        Customer customer = dao.checkEmail(email);

        if (customer == null) {
            request.setAttribute("invalidemail", "Email Address Not Valid");
            request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
        } else {
            sendOtpEmail(request, response, customer);
        }
    }

    private void sendOtpEmail(HttpServletRequest request, HttpServletResponse response, Customer customer) throws ServletException, IOException {
        try {
            String email = customer.getEmail();
            String username = customer.getFirstname() + " " + customer.getLastname();
            int otp = generateOtp();
            sendEmail(email, username, otp);

            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setMaxInactiveInterval(OTP_VALIDITY); // Session valid for 10 minutes
            session.setAttribute("UserData", customer);
            request.getRequestDispatcher("SendOTP.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("SendOtpError", "OTP Not Sent");
            request.getRequestDispatcher("forgotpassword.jsp").forward(request, response);
            e.printStackTrace();
        }
    }

    private int generateOtp() {
        Random rand = new Random();
        return rand.nextInt((int) Math.pow(10, OTP_LENGTH - 1) * 9) + (int) Math.pow(10, OTP_LENGTH - 1);
    }

    private void sendEmail(String email, String username, int otp) throws Exception {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", HOST);
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        Session session = Session.getInstance(props, new Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_ID, PASSWORD);
            }
        });

        Message message = new MimeMessage(session);
        message.setFrom(new InternetAddress(SENDER_ID));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
        message.setSubject("OTP Request");
        String msgContent = "<!DOCTYPE html><html><head></head><body><center><div style='background-color:#f8f8f8; width:500px; height:200px'><div style='background-color:#00e58b; width:500px; height:50px'><h3 style='color:white; padding-top:10px;'>EmailDemo.com</h3></div><p style='color:gray; margin-left:-300px;'>Dear "
                + username + ",</p><br><p style='color:gray; margin-top:-10px;'>" + otp
                + " is your One Time Password. Do NOT share this code with anyone for security reasons. This is valid for 10 minutes.</p><div></center></body></html>";
        message.setContent(msgContent, "text/html; charset=utf-8");

        Transport.send(message);
    }

    private void handleOtpVerification(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        String generatedOtp = String.valueOf(session.getAttribute("otp"));
        String enteredOtp = request.getParameter("EnterOTP");

        if (generatedOtp.equalsIgnoreCase(enteredOtp)) {
            request.setAttribute("Otpmatch", "OTP Match");
            request.getRequestDispatcher("ResetPassword.jsp").forward(request, response);
        } else {
            request.setAttribute("notmatch", "OTP Not Match");
            request.getRequestDispatcher("SendOTP.jsp").forward(request, response);
        }
    }

    private void handlePasswordReset(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String newPassword = request.getParameter("newpassword");
        HttpSession session = request.getSession(false);
        Customer customer = (Customer) session.getAttribute("UserData");
        customer.setPassword(newPassword);

        ForgotDao dao = new ForgotDao();
        int result = dao.resetPassword(customer);
        if (result > 0) {
            response.sendRedirect("index.jsp");
            System.out.println("Password Recovery Success!");
        } else {
            System.out.println("Error");
        }
    }
}
