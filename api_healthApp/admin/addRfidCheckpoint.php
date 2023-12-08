<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$name= $_POST['name'];
$description = $_POST['description'];
$location = $_POST['location'];

$sqlQuery = "INSERT INTO rfid_checkpoint SET rfid_checkpoint_name = '$name', rfid_checkpoint_description = '$description',
 rfid_checkpoint_location = '$location'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
