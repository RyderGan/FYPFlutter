<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$name= $_POST['name'];
$distance = $_POST['distance'];
$elevation = $_POST['elevation'];
$difficulty = $_POST['difficulty'];
$points = $_POST['points'];
$time_limit = $_POST['time_limit'];

$sqlQuery = "INSERT INTO paths SET path_name = '$name', path_checkpoint_list = '[]',
path_distance = '$distance', path_elevation = '$elevation', path_difficulty = '$difficulty', 
 path_points = '$points', time_limit = '$time_limit'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
