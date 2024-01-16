<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['userID'])) {
    $userID = $_POST['userID'];
} else {    
    $userID = "";
}

$sqlQuery1 = "DELETE FROM users WHERE id = '$userID'";
$result1 = $connectNow->query($sqlQuery1);

$sqlQuery2 = "DELETE FROM blood_pressures WHERE user_id = '$userID'";
$result2 = $connectNow->query($sqlQuery2);

$sqlQuery3 = "DELETE FROM bmis WHERE user_id = '$userID'";
$result3 = $connectNow->query($sqlQuery3);

$sqlQuery4 = "DELETE FROM feedbacks WHERE user_id = '$userID'";
$result4 = $connectNow->query($sqlQuery4);

$sqlQuery5 = "DELETE FROM reward_points WHERE user_id = '$userID'";
$result5 = $connectNow->query($sqlQuery5);

$sqlQuery6 = "DELETE FROM stepcounts WHERE user_id = '$userID'";
$result6 = $connectNow->query($sqlQuery6);

$sqlQuery7 = "DELETE FROM user_checkpoints WHERE user_id = '$userID'";
$result7 = $connectNow->query($sqlQuery7);

$sqlQuery8 = "DELETE FROM visceral_fats WHERE user_id = '$userID'";
$result8 = $connectNow->query($sqlQuery8);

//set rfid band value to 0

if($result1 && $result2 && $result4 && $result4 && $result5 && $result6 && $result7 && $result8){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
