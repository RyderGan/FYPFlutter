<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$userID = $_POST['userID'];
$rating = $_POST['rating'];

$sqlQuery = "INSERT INTO visceral_fats SET user_id = '$userID', rating = '$rating'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
