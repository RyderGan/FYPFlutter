<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['checkpoint_list'])) {
    $checkpoint_list = $_POST['checkpoint_list'];
} else {    
    $checkpoint_list = "";
}

if (isset($_POST['pathID'])) {
    $pathID = $_POST['pathID'];
} else {    
    $pathID = "";
}

if($checkpoint_list == ""){
    $checkpoint_list = "0";
}

$sqlQuery = "UPDATE paths SET path_checkpoint_list = '$checkpoint_list'
WHERE path_id = '$pathID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success" => true));
}else{
    echo json_encode(array("success"=>false));
}