<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$rfidBandUid= $_POST['rfidBandUid'];
$rfidBandName = $_POST['rfidBandName'];
$userID = $_POST['userID'];
$rfidBandID = $_POST['rfidBandID'];

$sqlQuery = "UPDATE rfid_bands SET rfid_band_uid = '$rfidBandUid', 
rfid_band_name = '$rfidBandName', user_id = '$userID' WHERE rfid_band_id = '$rfidBandID'";
$result = $connectNow->query($sqlQuery);

$sqlQuery2 = "SELECT * FROM rfid_bands WHERE rfid_band_id = '$rfidBandID'";
$result2 = $connectNow->query($sqlQuery2);

if($result){
    if ($result2->num_rows > 0) {
        while ($rowFound = $result2->fetch_assoc()) {
            $rfidBandDetails[] = $rowFound;
        }
        echo json_encode(array(
            "success" => true,
            "rfidBand" => $rfidBandDetails[0],  //row number
        ));
    } else {
        echo json_encode(array("success" => false));
    }
}else{
    echo json_encode(array("success"=>false));
}