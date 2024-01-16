<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['full_name'])) {
    $fullName = $_POST['full_name'];
} else {    
    $fullName = "";
}
if (isset($_POST['email'])) {
    $email = $_POST['email'];
} else {    
    $email = "";
}
if (isset($_POST['user_password'])) {
    $password = md5($_POST['user_password']);
} else {    
    $password = md5("");
}
if (isset($_POST['user_type'])) {
    $userType = $_POST['user_type'];
} else {    
    $userType = "";
}
if (isset($_POST['gender'])) {
    $gender = $_POST['gender'];
} else {    
    $gender = "";
}
if (isset($_POST['dateOfBirth'])) {
    $dob = $_POST['dateOfBirth'];
} else {    
    $dob = "";
}

$sqlQuery = "INSERT INTO users SET full_name = '$fullName', email = '$email', user_password = '$password', user_type = '$userType', gender = '$gender', dateOfBirth = '$dob'";

$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
