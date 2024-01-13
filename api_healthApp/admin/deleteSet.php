<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$setID = $_POST['setID'];

$sqlQuery = "DELETE FROM sets WHERE  set_id = '$setID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}