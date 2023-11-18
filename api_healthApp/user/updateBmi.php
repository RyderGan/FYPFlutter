<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$bmiID = $_POST['update_bmiID'];
$weight = $_POST['update_weight'];
$height = $_POST['update_height'];

$sqlQuery = "UPDATE bmis SET user_weight = '$weight', user_height = '$height' WHERE bmi_id = '$bmiID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
