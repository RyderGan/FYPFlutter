<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$userID = $_POST['userID'];

$sqlQuery = "UPDATE workout SET workout_status = 'Completed'
WHERE workout_user_id = '$userID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success" => true));
}else{
    echo json_encode(array("success"=>false));
}