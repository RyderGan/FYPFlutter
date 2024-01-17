<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['name'])) {
    $name= $_POST['name'];
} else {    
    $name= "";
}

if (isset($_POST['description'])) {
    $description = $_POST['description'];
} else {    
    $description = "";
}

if (isset($_POST['location'])) {
    $location = $_POST['location'];
} else {    
    $location = "";
}

if (isset($_POST['type'])) {
    $type = $_POST['type'];
} else {    
    $type = "";
}

if (isset($_POST['checkpointId'])) {
    $checkpointId = $_POST['checkpointId'];
} else {    
    $checkpointId = "";
}

$sqlQuery = "UPDATE checkpoints SET checkpoint_name = '$name', checkpoint_description = '$description',
 checkpoint_location = '$location', checkpoint_type = '$type' WHERE checkpoint_id = '$checkpointId'";
$result = $connectNow->query($sqlQuery);

$sqlQuery2 = "SELECT * FROM checkpoints WHERE checkpoint_id = '$checkpointId'";
$result2 = $connectNow->query($sqlQuery2);

if($result){
    if ($result2->num_rows > 0) {
        while ($rowFound = $result2->fetch_assoc()) {
            $checkpointData[] = $rowFound;
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