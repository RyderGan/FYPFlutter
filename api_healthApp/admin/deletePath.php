<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$pathID = $_POST['pathID'];

$sqlQuery = "DELETE FROM paths WHERE  path_id = '$pathID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}