<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['name'])) {
    $name = $_POST['name'];
} else {    
    $name = "";
}
if (isset($_POST['bonus_points'])) {
    $bonus_points = $_POST['bonus_points'];
} else {    
    $bonus_points = "";
}
if (isset($_POST['type'])) {
    $type = $_POST['type'];
} else {    
    $type = "";
}

$sqlQuery = "INSERT INTO sets SET set_name = '$name', set_path_list = '0',
set_bonus_points = '$bonus_points', set_type = '$type'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
