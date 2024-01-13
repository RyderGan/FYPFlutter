<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$userID = $_POST['userID'];
$msg = $_POST['msg'];
$hasRead = 0;

$sqlQuery = "INSERT INTO notifications SET user_id = '$userID', msg = '$msg', hasRead = '$hasRead'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
