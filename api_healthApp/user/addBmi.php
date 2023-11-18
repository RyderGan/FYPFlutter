<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$userID = $_POST['userID'];
$weight = $_POST['weight'];
$height = $_POST['height'];

$sqlQuery = "INSERT INTO bmis SET user_id = '$userID', user_weight = '$weight', user_height = '$height'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
