package controllers;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import dao.IDaoLocale;
import entities.Ville;

@WebServlet("/VilleController")
public class VilleController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @EJB
    private IDaoLocale<Ville> ejb;
       

    

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	  List<Ville> villes = ejb.findAll();
          request.setAttribute("villes", villes);
        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            
            String nom = request.getParameter("ville");
            ejb.create(new Ville(nom));
        } else if ("delete".equalsIgnoreCase(action)) {
           
            int villeId = Integer.parseInt(request.getParameter("id"));
            Ville villeToDelete = ejb.findById(villeId);
            ejb.delete(villeToDelete);
        } else if ("update".equalsIgnoreCase(action)) {
            // Logique pour mettre  jour une ville
            int villeId = Integer.parseInt(request.getParameter("id"));
            Ville villeToUpdate = ejb.findById(villeId);
            String newNom = request.getParameter("newNom");
            villeToUpdate.setNom(newNom);
            ejb.update(villeToUpdate);
        }

      
        RequestDispatcher dispatcher = request.getRequestDispatcher("ville.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

}