<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$userID = $_POST['userID'];
$notifyID = $_POST['notifyID'];

$sqlQuery = "DELETE FROM notifications WHERE user_id = '$userID' AND notify_id = '$notifyID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
