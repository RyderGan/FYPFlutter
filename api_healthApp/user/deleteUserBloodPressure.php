<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$userID = $_POST['userID'];
$bpID = $_POST['bpID'];

$sqlQuery = "DELETE FROM blood_pressures WHERE user_id = '$userID' AND bp_id = '$bpID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
