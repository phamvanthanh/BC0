<?php

$serverName = "localhost";
$userName = "cpses_nhKZx5ubNH"; //cpses_nhqpvYslXN
$password = "thanh03021986";
$database = "nhdyjjgw_qscompanion";//nhdyjjgw_qscompanion

$conn = new mysqli($serverName, $userName, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}


?>


