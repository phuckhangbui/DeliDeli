/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import Mail.email;
import User.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import Token.tokenGenerator;

/**
 *
 * @author Daiisuke
 */
@WebServlet(name = "EmailConfirmServlet", urlPatterns = {"/EmailConfirmServlet"})
public class EmailConfirmServlet extends HttpServlet {

    private String host; // sender
    private String port; // protocol port
    private String user; // sender email address
    private String pass; // sender email pass

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ServletContext context = getServletContext();
        host = context.getInitParameter("host");
        port = context.getInitParameter("port");
        user = context.getInitParameter("user");
        pass = context.getInitParameter("pass");
        // Get the STMP config inside web.xml and load it.

        HttpSession session = request.getSession();
        tokenGenerator token = new tokenGenerator();
        UserDAO userDAO = new UserDAO();

        String generatedToken = token.tokenGenerate();
        String userEmail = (String) request.getParameter("txtEmail");
        String userType = (String) request.getAttribute("USER_TYPE");

        userType = (userType == null) ? "ForgotPassUser" : userType;

        System.out.println("[EMAIL - CONF]: User email: " + userEmail);
        System.out.println("[EMAIL - CONF]: User type: " + userType);
        System.out.println("[EMAIL - CONF]: User generated token: " + generatedToken);

        userDAO.updateTokenByEmail(userEmail, generatedToken);

        String recipient = userEmail; // After that add the user email.

        String subject = "";
        String content = "";
        String result = "There's nothing here .3.";

        if (userType != null && userType.equals("ForgotPassUser")) {
            subject = "[NOTICE] DeliDeli ID Password Reset Confirmation"; // Title of the email
            content = "Click the following link to reset your account: \n\n"
                    + "http://localhost:8084/ProjectSWP/MainController?action=verify&token=" + generatedToken + "&type=" + userType;
            //verify = servlet; token = param.
        } else if (userType != null && userType.equals("RegisterUser")) {
            subject = "[NOTICE] DeliDeli ID Confirmation"; // Title of the email
            content = "Click the following link to access your account: \n\n"
                    + "http://localhost:8084/ProjectSWP/MainController?action=verify&token=" + generatedToken + "&type=" + userType;
            //verify = servlet; token = param.
        }

        System.out.println("[EMAIL - CONF]: The token system generated: " + generatedToken);

        try {
            email.sendVerificationEmail(host, port, user, pass, recipient, subject, content);
            result = "The message has sent successfully, please check your email.";
        } catch (Exception ex) {
            ex.printStackTrace();
            result = "There was a problem: " + ex.getMessage();
        } finally {
            System.out.println("Email has been sent.");
            request.setAttribute("EMAILRESULT", result);
            RequestDispatcher rd = request.getRequestDispatcher("ResultMessage.jsp");
            rd.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
