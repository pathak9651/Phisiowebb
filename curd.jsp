<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>CRUD Operations</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        form { border: 1px solid #ccc; padding: 20px; margin-bottom: 30px; }
        h2 { color: #007bff; }
        input[type="text"], input[type="email"], input[type="number"] {
            width: 250px;
            padding: 5px;
            margin: 5px 0;
        }
        input[type="submit"] { padding: 8px 15px; }
    </style>
</head>
<body>
    <h1>MySQL CRUD with JSP + Servlet</h1>

    <!-- Create -->
    <form method="post" action="CURD">
        <h2>Create Record</h2>
        First Name: <input type="text" name="firstname" required><br>
        Last Name: <input type="text" name="lastname" required><br>
        Mobile: <input type="text" name="mobile" required><br>
        Email: <input type="email" name="email" required><br>
        <input type="submit" value="Create">
    </form>

    <!-- Read -->
    <form method="get" action="CURD">
       <h2>Read Record</h2>
        ID: <input type="number" name="id" required><br>
        <input type="submit" value="Read">
    </form>

    <!-- Update -->
    <form id="updateForm">
        <h2>Update Record</h2>
        ID: <input type="number" name="id" required><br>
        First Name: <input type="text" name="firstname"><br>
        Last Name: <input type="text" name="lastname"><br>
        Mobile: <input type="text" name="mobile"><br>
        Email: <input type="email" name="email"><br>
        <input type="button" value="Update" onclick="sendPutRequest()">
    </form>

    <!-- Delete -->
    <form id="deleteForm">
        <h2>Delete Record</h2>
        ID: <input type="number" name="id" required><br>
        <input type="button" value="Delete" onclick="sendDeleteRequest()">
    </form>

    <div id="response" style="white-space: pre; margin-top: 20px; color: green;"></div>

    <script>
        function sendPutRequest() {
            const form = document.getElementById("updateForm");
            const formData = new FormData(form);
            const params = new URLSearchParams(formData).toString();

            fetch("CURD", {
                method: "PUT",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: params
            })
            .then(response => response.text())
            .then(text => document.getElementById("response").innerText = text);
        }

        function sendDeleteRequest() {
            const form = document.getElementById("deleteForm");
            const formData = new FormData(form);
            const params = new URLSearchParams(formData).toString();

            fetch("CURD", {
                method: "DELETE",
                headers: {
                    "Content-Type": "application/x-www-form-urlencoded"
                },
                body: params
            })
            .then(response => response.text())
            .then(text => document.getElementById("response").innerText = text);
        }
    </script>
</body>
</html>
