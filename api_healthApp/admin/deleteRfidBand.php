<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$rfidBandID = $_POST['rfidBandID'];

$sqlQuery1 = "DELETE FROM rfid_bands WHERE  rfid_band_id = '$rfidBandID'";
$result1 = $connectNow->query($sqlQuery1);

$sqlQuery2 = "DELETE FROM checkpoint_history WHERE  rfid_band_id = '$rfidBandID'";
$result2 = $connectNow->query($sqlQuery2);

if($result1 && $result2){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}