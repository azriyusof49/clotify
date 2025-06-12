/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import userModule.UserData;
import userModule.User;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Azuri
 */
public class Login extends HttpServlet {

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
            HttpSession session = request.getSession();
            /* TODO output your page here. You may use following sample code. */
            String login = request.getParameter("login");
            String name = request.getParameter("username");
            String password = request.getParameter("password");
            
            User e = new User();
            e.setUsername(name);
            e.setPassword(password);

            int status = UserData.Auth(e.getUsername(),e.getPassword());
            
            if (status > 0) {
                // Retrieve the fresh user record
                User role = new User();
                role = UserData.getUserByUsername(e.getUsername());
                session.setAttribute("userId", role.getId());
                session.setAttribute("username", role.getUsername());
                session.setAttribute("role", role.getRole());
                // Check for Admin role first
                if ("admin".equalsIgnoreCase(role.getRole())) {
                    // Forward admins to the admin dashboard
                    request.getRequestDispatcher("admin_homepage.jsp")
                           .forward(request, response);
                } else {
                    // Forward regular users to the homepage
                    request.getRequestDispatcher("catalog.jsp")
                           .forward(request, response);
                }
            } else {
                // Invalid login: set an error attribute and forward back to login page
                request.setAttribute("errorMessage", "Wrong username or password!");
                request.getRequestDispatcher("index.html")
                       .forward(request, response);
            }
            
            out.close();
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
