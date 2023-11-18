<?php
include '../connection.php';

$userEmail = $_POST['email'];

$sqlQuery = "SELECT * FROM users WHERE email='$userEmail'";

$result = $connectNow->query($sqlQuery);

if($result->num_rows > 0){
    //same email existed
    echo json_encode(array("emailFound"=>true));
}else{
    //email not yet taken
    echo json_encode(array("emailFound"=>false));
}