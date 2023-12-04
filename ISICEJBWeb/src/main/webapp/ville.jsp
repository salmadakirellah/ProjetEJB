<%@page import="entities.Ville"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="ISO-8859-1">
    <title>Liste des Villes</title>

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
            // Initialiser le DataTable sur la table avec l'ID "villeTable"
            $('#villeTable').DataTable();

            // Cacher le formulaire d'ajout au chargement de la page
            $('#addForm').hide();
        });

        // Fonction pour afficher/cacher le formulaire d'ajout
        function toggleAddForm() {
            $('#addForm').toggle();
        }

        function deleteVille(id) {
            var confirmation = confirm("tes-vous sur de vouloir supprimer cette ville ?");
            if (confirmation) {
                var form = document.createElement('form');
                form.method = 'post';
                form.action = 'VilleController';
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


        function updateVille(id) {
            var newNom = prompt("Nouveau nom de la ville :");
            if (newNom !== null) {
                window.location.href = "VilleController?action=update&id=" + id + "&newNom=" + encodeURIComponent(newNom);
            }
        }

    </script>
</head>
<body>
    <div class="container">
    <!-- Bouton pour afficher/cacher le formulaire d'ajout -->
    <button onclick="toggleAddForm()" class="btn btn-success"><i class="fas fa-plus"></i> Ajouter une nouvelle ville</button>

    <!-- Formulaire d'ajout (initialement cach) -->
    <div id="addForm" style="margin-top: 20px;">
        <form action="VilleController?action=add" method="post">
            Nom : <input type="text" name="ville" class="form-control" /> <br>
            <button class="btn btn-primary">Enregistrer</button>
        </form>
    </div>

    <h1>Liste des villes :</h1>

    <!-- Utiliser la classe "table" de Bootstrap pour styliser le tableau -->
    <table id="villeTable" class="table">
        <thead>
            <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Update</th>
                <th>Delete</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${villes}" var="v">
                <tr>
                    <td>${v.id}</td>
                    <td>${v.nom}</td>
                    <td>
                        <button onclick="updateVille(${v.id})" class="btn btn-warning">
                            <i class="fas fa-edit"></i>
                        </button>
                    </td>
                    <td>
                        <button onclick="deleteVille(${v.id})" class="btn btn-danger">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
    <!-- Inclure le fichier JavaScript de Bootstrap  la fin du document -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>
