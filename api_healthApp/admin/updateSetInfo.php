<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

if (isset($_POST['name'])) {
    $name = $_POST['name'];
} else {    
    $name = "";
}
if (isset($_POST['bonus_points'])) {
    $bonus_points = $_POST['bonus_points'];
} else {    
    $bonus_points = "";
}
if (isset($_POST['type'])) {
    $type = $_POST['type'];
} else {    
    $type = "";
}
if (isset($_POST['setID'])) {
    $setID = $_POST['setID'];
} else {    
    $setID = "";
}

$sqlQuery = "UPDATE sets SET set_name = '$name',
set_bonus_points = '$bonus_points', set_type = '$type' WHERE set_id = '$setID'";
$result = $connectNow->query($sqlQuery);

$sqlQuery2 = "SELECT * FROM sets WHERE set_id = '$setID'";
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