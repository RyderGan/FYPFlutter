<?php
$serverHost = "localhost";
$user = "root";
$password = "";
$databaseName = "iot_healthApp";

$connectNow = new mysqli($serverHost, $user, $password, $databaseName);

// Check connection
if ($connectNow->connect_error) {
  die("Connection failed: " . $connectNow->connect_error);
}
?>