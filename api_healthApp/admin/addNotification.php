<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$userID = $_POST['userID'];
$message = $_POST['message'];

$sqlQuery = "INSERT INTO notifications SET user_id = '$userID', message = '$message', hasRead = '0'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
