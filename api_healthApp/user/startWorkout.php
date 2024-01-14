<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$setID = $_POST['setID'];
$pathList = $_POST['pathList'];
$checkpointList = $_POST['checkpointList'];
$passedList = $_POST['passedList'];
$userID = $_POST['userID'];
$status = "Active";

$sqlQuery = "INSERT INTO workout SET workout_set_id = '$setID', workout_path_list = '$pathList', workout_checkpoint_list = '$checkpointList',
workout_passed_list = '$passedList', workout_user_id = '$userID', workout_status = '$status'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
