<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$systolic = $_POST['systolic'];
$diastolic = $_POST['diastolic'];
$bpID = $_POST['bpID'];

$sqlQuery = "UPDATE blood_pressures SET systolic_pressure = '$systolic' AND diastolic_pressure = '$diastolic' WHERE bp_id = '$bpID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
