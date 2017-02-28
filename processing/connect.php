<?php


$serverName = "localhost";
$userName = "root";
$password = "saunau";
$database = "qscompanion"; 

// Create connection
$conn = new mysqli($serverName, $userName, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
?>


