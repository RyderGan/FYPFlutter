<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$rfidCheckpointId = $_POST['rfidCheckpointId'];

$sqlQuery1 = "DELETE FROM rfid_checkpoint WHERE  rfid_checkpoint_id = '$rfidCheckpointId'";
$result1 = $connectNow->query($sqlQuery1);

$sqlQuery2 = "DELETE FROM paths WHERE  path_from_cp_id = '$rfidCheckpointId'";
$result2 = $connectNow->query($sqlQuery2);

$sqlQuery3 = "DELETE FROM paths WHERE  path_to_cp_id = '$rfidCheckpointId'";
$result3 = $connectNow->query($sqlQuery3);

if($result1 && $result2 && $result3){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}