<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$name= $_POST['name'];
$description = $_POST['description'];
$location = $_POST['location'];
$rfidCheckpointId = $_POST['rfidCheckpointId'];

$sqlQuery = "UPDATE rfid_checkpoint SET rfid_checkpoint_name = '$name', rfid_checkpoint_description = '$description',
 rfid_checkpoint_location = '$location' WHERE rfid_checkpoint_id = '$rfidCheckpointId'";
$result = $connectNow->query($sqlQuery);

$sqlQuery2 = "SELECT * FROM rfid_checkpoint WHERE rfid_checkpoint_id = '$rfidCheckpointId'";
$result2 = $connectNow->query($sqlQuery2);

if($result){
    if ($result2->num_rows > 0) {
        while ($rowFound = $result2->fetch_assoc()) {
            $userDetails[] = $rowFound;
        }
        echo json_encode(array(
            "success" => true,
            "userData" => $userDetails[0],  //row number
        ));
    } else {
        echo json_encode(array("success" => false));
    }
}else{
    echo json_encode(array("success"=>false));
}