/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet;

import DAO.UserDAO;
import DTO.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Daiisuke
 */
@WebServlet(name = "ResetPassServlet", urlPatterns = {"/ResetPassServlet"})
public class ResetPassServlet extends HttpServlet {

    private final static String PASS_PATTERN = "^(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,16}$";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {

            UserDTO user = null;
            UserDAO userDAO = new UserDAO();
            HttpSession session = request.getSession();

            String tokenDB = (String) session.getAttribute("TOKENDB"); //get req attr from verify
            String password = request.getParameter("txtPassword");
            String rePassword = request.getParameter("txtRePassword");

            System.out.println("[SERVLET - Reset]: Token received: " + tokenDB);
            System.out.println("[SERVLET - Reset]: pass received: " + password);
            System.out.println("[SERVLET - Reset]: rePass received: " + rePassword);

            if (!password.equals(rePassword)) {
                request.setAttribute("PASS_INCORRECT", "Password are not matched!");
                RequestDispatcher rd = request.getRequestDispatcher("resetPassword.jsp");
                rd.forward(request, response);
            } else if (!password.matches(PASS_PATTERN)) {
                request.setAttribute("PASS_INCORRECT", "Invalid password. Password must have a length of 8-16 "
                        + "characters and contain at least one special symbol and one uppercase letter.");
                RequestDispatcher rd = request.getRequestDispatcher("resetPassword.jsp");
                rd.forward(request, response);
            } else {
                System.out.println("Password equal");
                userDAO.updatePass(tokenDB, password);
                RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
                rd.forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
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
