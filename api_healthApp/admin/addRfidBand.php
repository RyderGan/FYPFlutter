<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$rfidBandUid= $_POST['rfidBandUid'];
$rfidBandName = $_POST['rfidBandName'];
$userID = $_POST['userID'];

$sqlQuery = "INSERT INTO rfid_bands SET rfid_band_uid = '$rfidBandUid', 
rfid_band_name = '$rfidBandName', user_id = '$userID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
