<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$userID = $_POST['userID'];
$bmiID = $_POST['bmiID'];

$sqlQuery = "DELETE FROM bmis WHERE user_id = '$userID' AND bmi_id = '$bmiID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}