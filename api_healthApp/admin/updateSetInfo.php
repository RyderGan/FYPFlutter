<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$name= $_POST['name'];
$bonus_points = $_POST['bonus_points'];
$type = $_POST['type'];
$setID = $_POST['setID'];

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