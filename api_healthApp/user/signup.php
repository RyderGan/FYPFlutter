<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$fullName = $_POST['full_name'];
$email = $_POST['email'];
$password = md5($_POST['user_password']);
$userType = $_POST['user_type'];
$gender = $_POST['gender'];
$dob = $_POST['dateOfBirth'];

$sqlQuery = "INSERT INTO users SET full_name = '$fullName', email = '$email', user_password = '$password', user_type = '$userType', gender = '$gender', dateOfBirth = '$dob'";

$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
