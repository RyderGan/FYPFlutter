<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$name= $_POST['name'];
$fromCpID = $_POST['fromCpID'];
$toCpID = $_POST['toCpID'];
$distance = $_POST['distance'];
$elevation = $_POST['elevation'];
$difficulty = $_POST['difficulty'];

$sqlQuery = "INSERT INTO paths SET path_name = '$name', path_from_cp_id = '$fromCpID',
 path_to_cp_id = '$toCpID', path_distance = '$distance',
 path_elevation = '$elevation', path_difficulty = '$difficulty'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
