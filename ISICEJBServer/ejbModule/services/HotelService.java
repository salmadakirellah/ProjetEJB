package services;

import java.util.List;

import dao.IDaoLocalHotel;
import entities.Hotel;
import entities.Ville;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Stateless(name = "hotelService")
public class HotelService implements IDaoLocalHotel {

    @PersistenceContext
    private EntityManager em;

    @Override
    public Hotel create(Hotel hotel) {
        em.persist(hotel);
        return hotel;
    }

    @Override
    public boolean delete(Hotel hotel) {
        em.remove(em.merge(hotel));
        return true;
    }

    @Override
    public Hotel update(Hotel hotel) {
        return em.merge(hotel);
    }

    @Override
    public Hotel findById(int id) {
        return em.find(Hotel.class, id);
    }

    @Override
    public List<Hotel> findAll() {
        Query query = em.createQuery("SELECT h FROM Hotel h LEFT JOIN FETCH h.ville");
        return query.getResultList();
    }
    public List<Ville> findAllVilles() {
        Query query = em.createQuery("select v from Ville v");
        return query.getResultList();
    }

    // Nouvelle mthode pour obtenir les htels par ville
    public List<Hotel> findHotelsByVille(int villeId) {
        Query query = em.createQuery("select h from Hotel h where h.ville.id = :villeId");
        query.setParameter("villeId", villeId);
        return query.getResultList();
    }
    @Override
    public Ville findVilleById(int id) {
        return em.find(Ville.class, id);
    }
}
