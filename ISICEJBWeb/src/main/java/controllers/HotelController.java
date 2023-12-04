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
import dao.IDaoLocalHotel;
import entities.Hotel;
import entities.Ville;
@WebServlet("/HotelController")
public class HotelController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @EJB(beanName = "hotelService")
    private IDaoLocalHotel ejb;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Entering doGet method of HotelController");
        // Charger la liste des htels
        List<Hotel> hotels = ejb.findAll();
        request.setAttribute("hotels", hotels);

        List<Ville> villes = ejb.findAllVilles();
        request.setAttribute("villes", villes);

        // Rediriger vers la page principale (liste des htels)
        RequestDispatcher dispatcher = request.getRequestDispatcher("hotel.jsp");
        dispatcher.forward(request, response);
        System.out.println("Exiting doGet method of HotelController");
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("Entering doPost method of HotelController");
        List<Hotel> hotels = ejb.findAll();
        request.setAttribute("hotels", hotels);
        List<Ville> villes = ejb.findAllVilles();
        request.setAttribute("villes", villes);

        String action = request.getParameter("action");

        if ("add".equalsIgnoreCase(action)) {
            // Logique pour ajouter un htel
            String nom = request.getParameter("nom");
            String adresse = request.getParameter("adresse");
            String telephone = request.getParameter("telephone");
            int villeId = Integer.parseInt(request.getParameter("villeId"));

            Ville ville = ejb.findVilleById(villeId);
            Hotel hotel = new Hotel(nom, adresse, telephone, ville);

            ejb.create(hotel);
        } else if ("delete".equalsIgnoreCase(action)) {
            // Logique pour supprimer un htel
            int hotelId = Integer.parseInt(request.getParameter("hotelId"));
            Hotel hotel = ejb.findById(hotelId);
            ejb.delete(hotel);
        } if ("updateHotel".equalsIgnoreCase(action)) {
            // Logique pour mettre  jour un htel
            int hotelId = Integer.parseInt(request.getParameter("hotelId"));
            String nom = request.getParameter("nom");
            String adresse = request.getParameter("adresse");
            String telephone = request.getParameter("telephone");
            int villeId = Integer.parseInt(request.getParameter("villeId"));

            Ville ville = ejb.findVilleById(villeId);
            Hotel hotel = ejb.findById(hotelId);

            if (hotel != null) {
                hotel.setNom(nom);
                hotel.setAdresse(adresse);
                hotel.setTelephone(telephone);
                hotel.setVille(ville);
                ejb.update(hotel);
                System.out.println("Hotel updated successfully");
            } else {
                System.out.println("Hotel not found for update");
            }

            // Ne redirigez pas ici
            // response.sendRedirect("HotelController");
        }

        response.sendRedirect("HotelController");
        RequestDispatcher dispatcher = request.getRequestDispatcher("hotel.jsp");
        dispatcher.forward(request, response);
        System.out.println("Exiting doPost method of HotelController");
    }

}
