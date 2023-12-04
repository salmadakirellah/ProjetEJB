package dao;

import entities.Hotel;
import entities.Ville;
import java.util.*;
public interface IDaoLocalHotel extends IDaoLocale<Hotel> {
    Ville findVilleById(int id);
    List<Ville> findAllVilles();
}
