<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$userID = $_POST['userID'];
$title = $_POST['title'];
$description = $_POST['description'];

$sqlQuery = "INSERT INTO feedbacks SET user_id = '$userID', title = '$title', fb_description = '$description'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
