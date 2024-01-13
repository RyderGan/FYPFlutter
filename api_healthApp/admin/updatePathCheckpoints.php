<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$checkpoint_list= $_POST['checkpoint_list'];
$pathID = $_POST['pathID'];

$sqlQuery = "UPDATE paths SET path_checkpoint_list = '$checkpoint_list'
WHERE path_id = '$pathID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success" => true));
}else{
    echo json_encode(array("success"=>false));
}