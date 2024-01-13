<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$name= $_POST['name'];
$description = $_POST['description'];
$location = $_POST['location'];
$type = $_POST['type'];

$sqlQuery = "INSERT INTO checkpoints SET checkpoint_name = '$name', checkpoint_description = '$description',
 checkpoint_location = '$location', checkpoint_type = '$type'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
