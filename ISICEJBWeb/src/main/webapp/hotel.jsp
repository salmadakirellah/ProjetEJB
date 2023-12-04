<%@page import="entities.Hotel"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Liste des Hotels</title>

    <!-- Inclure les fichiers CSS de Bootstrap -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
    
    <!-- Inclure les fichiers CSS de Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

    <!-- Inclure les fichiers CSS et JavaScript de DataTables -->
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.24/css/jquery.dataTables.css">
    <script type="text/javascript" charset="utf8" src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.24/js/jquery.dataTables.js"></script>

    <script>
        $(document).ready(function() {
            // Initialiser le DataTable sur la table avec l'ID "HotelTable"
            $('#HotelTable').DataTable();

            // Cacher le formulaire d'ajout au chargement de la page
            $('#addForm').hide();
        });

        // Fonction pour afficher/cacher le formulaire d'ajout
        function toggleAddForm() {
            $('#addForm').toggle();
        }

        function deleteHotel(id) {
            var confirmation = confirm("tes-vous sur de vouloir supprimer cette Hotel ?");
            if (confirmation) {
                var form = document.createElement('form');
                form.method = 'post';
                form.action = 'HotelController';
                var input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'action';
                input.value = 'delete';
                form.appendChild(input);
                input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'id';
                input.value = id;
                form.appendChild(input);
                document.body.appendChild(form);
                form.submit();
            }
        }

        function updateHotel(id) {
            var newNom = prompt("Nouveau nom de la Hotel :");
            if (newNom !== null) {
                window.location.href = "HotelController?action=update&id=" + id + "&newNom=" + encodeURIComponent(newNom);
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <!-- Bouton pour afficher/cacher le formulaire d'ajout -->
        <button onclick="toggleAddForm()" class="btn btn-success"><i class="fas fa-plus"></i> Add</button>

        <!-- Formulaire d'ajout (initialement caché) -->
        <div id="addForm" style="margin-top: 20px;">
            <form action="HotelController?action=add" method="post">
                <label for="id">ID :</label>
                <input type="text" name="id" class="form-control" required><br>

                <label for="nom">Nom :</label>
                <input type="text" name="nom" class="form-control" required><br>

                <label for="address">Address :</label>
                <input type="text" name="address" class="form-control" required><br>

                <label for="telephone">Telephone :</label>
                <input type="text" name="telephone" class="form-control" required><br>

                <label for="ville">Ville :</label>
                <input type="text" name="ville" class="form-control" required><br>

                <button class="btn btn-primary">Enregistrer</button>
            </form>
        </div>

        <h1>Liste des Hotels :</h1>

        <!-- Utiliser la classe "table" de Bootstrap pour styliser le tableau -->
        <table id="HotelTable" class="table">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nom</th>
                    <th>Address</th>
                    <th>Telephone</th>
                    <th>Ville</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${Hotels}" var="v">
                    <tr>
                        <td>${v.id}</td>
                        <td>${v.nom}</td>
                        <td>${v.address}</td>
                        <td>${v.telephone}</td>
                        <td>${v.ville}</td>
                        <td>
                            <button onclick="updateHotel(${v.id})" class="btn btn-warning">
                                <i class="fas fa-edit"></i>
                            </button>
                        </td>
                        <td>
                            <button onclick="deleteHotel(${v.id})" class="btn btn-danger">
                                <i class="fas fa-trash"></i>
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Inclure le fichier JavaScript de Bootstrap à la fin du document -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
