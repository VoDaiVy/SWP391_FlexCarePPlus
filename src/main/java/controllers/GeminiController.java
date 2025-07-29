package controllers;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Base64;
import org.json.JSONObject;
import utils.GeminiService;
import utils.S3Uploader;

/**
 *
 * @author PC
 */
@WebServlet(name = "GeminiController", urlPatterns = {"/aiGenInfo", "/aiGenImage"})
public class GeminiController extends HttpServlet {

    private final GeminiService geminiService = new GeminiService();

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet GeminiController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GeminiController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        String path = request.getServletPath();

        if ("/aiGenInfo".equals(path)) {
            // Nhận JSON, gọi AI tối ưu tiêu đề & mô tả
            request.setCharacterEncoding("UTF-8");
            response.setContentType("application/json;charset=UTF-8");
            StringBuilder sb = new StringBuilder();
            try (BufferedReader reader = request.getReader()) {
                String line;
                while ((line = reader.readLine()) != null) {
                    sb.append(line);
                }
            }
            JSONObject json = new JSONObject(sb.toString());

            // Lấy chủ đề từ request
            String topic = json.optString("topic");
            if (topic == null || topic.trim().isEmpty()) {
                response.setStatus(400);
                response.getWriter().write("{\"error\":\"Missing topic\"}");
                return;
            }

            // Gọi GeminiService để sinh tin tức
            String aiResult = geminiService.generateVetNews(topic);

            // Parse kết quả trả về từ Gemini (JSON)
            JSONObject outer = new JSONObject(aiResult);
            String innerText = outer
                    .getJSONArray("candidates")
                    .getJSONObject(0)
                    .getJSONObject("content")
                    .getJSONArray("parts")
                    .getJSONObject(0)
                    .getString("text");

            // innerText là chuỗi JSON, cần parse tiếp
            JSONObject inner = new JSONObject(innerText);

            // Trả về đúng JSON {title, content}
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(inner.toString());
            return;
        }

        if ("/aiGenImage".equals(path)) {
            response.setContentType("application/json;charset=UTF-8");
            String dataUrl = request.getParameter("imageData");
            try (PrintWriter out = response.getWriter()) {
                if (dataUrl != null && dataUrl.startsWith("data:image/")) {
                    String base64 = dataUrl.substring(dataUrl.indexOf(",") + 1);
                    byte[] imageBytes = Base64.getDecoder().decode(base64);
                    String fileName = "ai-gen-" + System.currentTimeMillis() + ".png";
                    long contentLength = imageBytes.length;
                    String urlS3 = S3Uploader.uploadToS3(new java.io.ByteArrayInputStream(imageBytes), fileName, contentLength);
                    out.print("{\"url\":\"" + urlS3 + "\"}");
                } else {
                    out.print("{\"error\":\"Invalid image data\"}");
                }
                return;
            } catch (Exception e) {
                response.setStatus(500);
                response.getWriter().print("{\"error\":\"" + e.getMessage() + "\"}");
                return;
            }
        }

        // Nếu không đúng endpoint
        response.sendError(HttpServletResponse.SC_NOT_FOUND);
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
