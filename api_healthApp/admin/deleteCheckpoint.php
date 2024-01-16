<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['checkpointId'])) {
    $checkpointId = $_POST['checkpointId'];
} else {    
    $checkpointId = "";
}


$sqlQuery1 = "DELETE FROM checkpoints WHERE  checkpoint_id = '$checkpointId'";
$result1 = $connectNow->query($sqlQuery1);
//Sets

// $sqlQuery2 = "DELETE FROM paths WHERE  path_from_cp_id = '$checkpointId'";
// $result2 = $connectNow->query($sqlQuery2);

//Paths
// $sqlQuery3 = "DELETE FROM paths WHERE  path_to_cp_id = '$checkpointId'";
// $result3 = $connectNow->query($sqlQuery3);

if($result1){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}