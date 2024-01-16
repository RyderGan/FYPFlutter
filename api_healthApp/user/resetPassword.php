<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

if (isset($_POST['email'])) {
    $email = $_POST['email'];
} else {    
    $email = "";
}
if (isset($_POST['password'])) {
    $password = md5($_POST['password']);
} else {    
    $password = md5("");
}

$sqlQuery = "UPDATE users SET user_password = '$password' WHERE email = '$email'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
