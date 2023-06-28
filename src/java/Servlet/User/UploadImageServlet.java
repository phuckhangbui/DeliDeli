/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlet.User;

import DAO.RecipeImageDAO;
import DTO.RecipeImageDTO;
import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Daiisuke
 */
@WebServlet(name = "ImageUploadServlet", urlPatterns = {"/ImageUploadServlet"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB - exceed 2MB => disk, else memory => caching.
        maxFileSize = 1024 * 1024 * 10, // 10MB => maximum upload to server.
        maxRequestSize = 1024 * 1024 * 50) // 50MB => maximum request from server.

public class UploadImageServlet extends HttpServlet {

    private String getFileName(Part part) {
        String contentDisposition = part.getHeader("content-disposition");
        //Retrieve the value of content-disposition (datatype) in the HTTP Req Header.
        //ex: form-data; name="dataFile"; filename="Something.jpg";
        String[] elements = contentDisposition.split(";");
        for (String element : elements) {
            if (element.trim().startsWith("filename")) {
                return element.substring(element.indexOf('=') + 1).trim().replace("\"", "");
                //Replace all quotation marks (\") with empty space.
                //ex: "filename=\"example.jpg\""; => output: example.jpg
            }
        }
        return null;
    }

    private String setUniqueFileName(Part part, int index) {
        String originalFileName = getFileName(part);
        int dotIndex = originalFileName.lastIndexOf("."); //Go to last position of the string
        String fileExtension = originalFileName.substring(dotIndex + 1); //New position 
        String fileNameWithoutExtension = originalFileName.substring(0, dotIndex);
        String uniqueFileName = fileNameWithoutExtension + "_" + index + "." + fileExtension;
        index++;
        return uniqueFileName;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            //DAO/DTO
            RecipeImageDAO recipeImageDAO = new RecipeImageDAO();
            RecipeImageDTO recipeImage = null;

            //Param
            int recipeId = (Integer) request.getAttribute("recipeId");

            System.out.println("[UploadImage - ID]: " + recipeId);
            recipeImage = recipeImageDAO.checkRecipeImageByID(recipeId);

            //Path
            String uploadPath = "C:/project-swp/pictures/Recipe/" + recipeId;
            String uploadPathThumbnail = uploadPath + "/Thumbnail"; //.../Recipe/[ID]/ImageThumbnail
            String uploadPathDetail = uploadPath + "/Detail";

            //Upload
            File uploadDir = new File(uploadPath);
            File uploadDirThumbnail = new File(uploadPathThumbnail);
            File uploadDirDetail = new File(uploadPathDetail);

            if (!uploadDir.exists()) {
                uploadDir.mkdir(); //mkdir = make directory if not exist.
            }

            if (!uploadDirThumbnail.exists()) {
                uploadDirThumbnail.mkdir();
            }

            if (!uploadDirDetail.exists()) {
                uploadDirDetail.mkdir();
            }

            //Simple patch for now...
            Part thumbnailPart = request.getPart("thumbnail"); // Get thumbnail image file
            System.out.println(thumbnailPart);
            if (thumbnailPart.getInputStream().available() != 0) {
                String thumbnailName = getFileName(thumbnailPart); // Get thumbnail image name
                String thumbnailPath = uploadPathThumbnail + File.separator + thumbnailName;
                thumbnailPart.write(thumbnailPath); // Upload to disk

                if (recipeImage != null) {
                    if (recipeImage.getId() > 0) {
                        // Exist
                        System.out.println("Exist: ThumbnailName = " + thumbnailName);
                        recipeImageDAO.updateRecipeThumbnailImageByID(thumbnailName, recipeId);

                    } else {
                        // Not exist
                        System.out.println("Non-Exist: ThumbnailName = " + thumbnailName);
                        recipeImageDAO.insertRecipeImageByID(true, thumbnailName, recipeId); //Do updateDAO like this

                    }
                } else {
                    recipeImageDAO.insertRecipeImageByID(true, thumbnailName, recipeId); //Do updateDAO like this
                }
            }

            Part detailPart = request.getPart("picture");
            if (detailPart != null) {
                String detailName = getFileName(detailPart);
                String detailPath = uploadPathDetail + File.separator + detailName;
                detailPart.write(detailPath); // Upload to disk

                if (recipeImage != null) {
                    if (recipeImage.getId() > 0) {
                        // Exist
                        System.out.println("Exist: detailName = " + detailName);
                        recipeImageDAO.updateRecipeDetailedImageByID(detailName, recipeId);
                    } else {
                        // Not exist

                        System.out.println("Non-Exist: detailName = " + detailName);
                        recipeImageDAO.insertRecipeImageByID(false, detailName, recipeId);
                    }
                } else {
                    recipeImageDAO.insertRecipeImageByID(false, detailName, recipeId); //Do updateDAO like this
                }

            }
            response.sendRedirect("home.jsp");
        } catch (Exception e) {
            response.sendRedirect("home.jsp");
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
