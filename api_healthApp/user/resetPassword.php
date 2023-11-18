<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$password = md5($_POST['password']);
$email = $_POST['email'];

$sqlQuery = "UPDATE users SET user_password = '$password' WHERE email = '$email'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
