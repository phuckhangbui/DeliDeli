/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.UserDAO;
import DTO.UserDTO;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author Admin
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)
public class UploadAvatarImageServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String userId = (String) request.getAttribute("userId");

            String fileName = "";
            Part filePart = request.getPart("file");

            if (filePart == null && filePart.getSize() == 0) {
                request.getRequestDispatcher("UserPublicDetailServlet").forward(request, response);
            } else {
                String uploadPath = "C:/project-swp/pictures/User/" + userId;

                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // MSIE fix.
                InputStream fileContent = filePart.getInputStream();
//
//            // Check if file already exists
                File existingFile = new File(uploadDir.getAbsolutePath() + File.separator + fileName);
                if (existingFile.exists()) {
                    // Append number to filename to avoid overwriting existing file
                    int i = 1;
                    while (existingFile.exists()) {
                        fileName = i + "_" + fileName;
                        existingFile = new File(uploadDir.getAbsolutePath() + File.separator + fileName);
                        i++;
                    }
                }

                // saves the file to the server
                Path filePath = Paths.get(uploadDir.getAbsolutePath() + File.separator + fileName);
                Files.copy(fileContent, filePath);
                fileContent.close();

                UserDAO.updateAvatarImage(new Integer(userId), fileName);

                UserDTO user = UserDAO.getUserByUserId(new Integer(userId));
                HttpSession session = request.getSession();

                session.setAttribute("user", user);
                request.setAttribute("userId", userId);

                request.getRequestDispatcher("UserPublicDetailServlet").forward(request, response);
            }
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
