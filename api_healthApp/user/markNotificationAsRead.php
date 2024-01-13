<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$notifyID = $_POST['notifyID'];
$userID = $_POST['userID'];
$hasRead = 1;

$sqlQuery = "UPDATE notifications SET hasRead = '$hasRead' WHERE notify_id = '$notifyID' AND user_id = '$userID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
