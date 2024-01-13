<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$name= $_POST['name'];
$description = $_POST['description'];
$location = $_POST['location'];
$type = $_POST['type'];
$checkpointId = $_POST['checkpointId'];

$sqlQuery = "UPDATE checkpoints SET checkpoint_name = '$name', checkpoint_description = '$description',
 checkpoint_location = '$location', checkpoint_type = '$type' WHERE checkpoint_id = '$checkpointId'";
$result = $connectNow->query($sqlQuery);

$sqlQuery2 = "SELECT * FROM checkpoints WHERE checkpoint_id = '$checkpointId'";
$result2 = $connectNow->query($sqlQuery2);

if($result){
    if ($result2->num_rows > 0) {
        while ($rowFound = $result2->fetch_assoc()) {
            $userDetails[] = $rowFound;
        }
        echo json_encode(array(
            "success" => true,
            "checkpointData" => $checkpointData[0],  //row number
        ));
    } else {
        echo json_encode(array("success" => false));
    }
}else{
    echo json_encode(array("success"=>false));
}