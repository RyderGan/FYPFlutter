<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$name= $_POST['name'];
$bonus_points = $_POST['bonus_points'];
$type = $_POST['type'];

$sqlQuery = "INSERT INTO sets SET set_name = '$name', set_path_list = '0',
set_bonus_points = '$bonus_points', set_type = '$type'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
