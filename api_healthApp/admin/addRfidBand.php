<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset( $_POST['rfidBandUid'])) {
    $rfidBandUid= $_POST['rfidBandUid'];
} else {    
    $rfidBandUid= "";
}
if (isset($_POST['rfidBandName'])) {
    $rfidBandName = $_POST['rfidBandName'];
} else {    
    $rfidBandName = "";
}
if (isset($_POST['userID'])) {
    $userID = $_POST['userID'];
} else {    
    $userID = "";
}

$sqlQuery = "INSERT INTO rfid_bands SET rfid_band_uid = '$rfidBandUid', 
rfid_band_name = '$rfidBandName', user_id = '$userID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
