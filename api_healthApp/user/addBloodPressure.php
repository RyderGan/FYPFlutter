<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['userID'])) {
    $userID = $_POST['userID'];
} else {    
    $userID = "";
}

if (isset($_POST['systolic'])) {
    $systolic = $_POST['systolic'];
} else {    
    $systolic = "";
}

if (isset($_POST['diastolic'])) {
    $diastolic = $_POST['diastolic'];
} else {    
    $diastolic = "";
}

$sqlQuery = "INSERT INTO blood_pressures SET user_id = '$userID', systolic_pressure = '$systolic', diastolic_pressure = '$diastolic'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
