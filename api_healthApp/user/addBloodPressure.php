<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$userID = $_POST['userID'];
$systolic = $_POST['systolic'];
$diastolic = $_POST['diastolic'];

$sqlQuery = "INSERT INTO blood_pressures SET user_id = '$userID', systolic_pressure = '$systolic', diastolic_pressure = '$diastolic'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
