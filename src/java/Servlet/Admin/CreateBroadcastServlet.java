/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.Admin;

import DAO.NotificationDAO;
import DTO.NotificationDTO;
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
import javax.servlet.http.Part;

/**
 *
 * @author khang
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB - exceed 2MB => disk, else memory => caching.
        maxFileSize = 1024 * 1024 * 10, // 10MB => maximum upload to server.
        maxRequestSize = 1024 * 1024 * 50) // 50MB => maximum request from server.
public class CreateBroadcastServlet extends HttpServlet {

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
            request.setCharacterEncoding("UTF-8");

            String txtTitle = request.getParameter("txtTitle");
            String editorContent = request.getParameter("editorContent");
            java.sql.Timestamp sendDate = new java.sql.Timestamp(System.currentTimeMillis());

            System.out.println(txtTitle);
            System.out.println(editorContent);

            String fileName = "";
            Part filePart = request.getPart("file");
            if (filePart.getInputStream().available() != 0) {
                
            } else {
                String uploadPath = "C:/project-swp/pictures/Broadcast/";

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
            }
   
            NotificationDTO notification = new NotificationDTO(0, txtTitle, editorContent, sendDate, false, 1,
                    5, 0, 0, fileName);
            NotificationDAO.addBroadcast(notification);
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
