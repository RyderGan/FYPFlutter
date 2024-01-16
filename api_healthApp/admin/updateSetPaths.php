<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['path_list'])) {
    $path_list = $_POST['path_list'];
} else {    
    $path_list = "";
}
if (isset($_POST['setID'])) {
    $setID = $_POST['setID'];
} else {    
    $setID = "";
}

$sqlQuery = "UPDATE sets SET set_path_list = '$path_list'
WHERE set_id = '$setID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success" => true));
}else{
    echo json_encode(array("success"=>false));
}