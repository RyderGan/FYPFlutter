<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['setID'])) {
    $setID = $_POST['setID'];
} else {    
    $setID = "";
}

if (isset($_POST['pathList'])) {
    $pathList = $_POST['pathList'];
} else {    
    $pathList = "";
}

if (isset($_POST['checkpointList'])) {
    $checkpointList = $_POST['checkpointList'];
} else {    
    $checkpointList = "";
}

if (isset($_POST['passedList'])) {
    $passedList = $_POST['passedList'];
} else {    
    $passedList = "";
}

if (isset($_POST['userID'])) {
    $userID = $_POST['userID'];
} else {    
    $userID = "";
}

$status = "Active";

$sqlQuery = "INSERT INTO workout SET workout_set_id = '$setID', workout_path_list = '$pathList', workout_checkpoint_list = '$checkpointList',
workout_passed_list = '$passedList', workout_user_id = '$userID', workout_status = '$status'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
