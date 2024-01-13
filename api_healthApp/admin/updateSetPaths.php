<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$path_list= $_POST['path_list'];
$setID = $_POST['setID'];

$sqlQuery = "UPDATE sets SET set_path_list = '$path_list'
WHERE set_id = '$setID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success" => true));
}else{
    echo json_encode(array("success"=>false));
}