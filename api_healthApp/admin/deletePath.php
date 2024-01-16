<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['pathID'])) {
    $pathID = $_POST['pathID'];
} else {    
    $pathID = "";
}

$sqlQuery = "DELETE FROM paths WHERE  path_id = '$pathID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}