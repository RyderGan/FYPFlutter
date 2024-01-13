<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$name= $_POST['name'];
$distance = $_POST['distance'];
$elevation = $_POST['elevation'];
$difficulty = $_POST['difficulty'];
$points = $_POST['points'];
$time_limit = $_POST['time_limit'];
$pathID = $_POST['pathID'];

$sqlQuery = "UPDATE paths SET path_name = '$name', path_distance = '$distance',
 path_elevation = '$elevation', path_difficulty = '$difficulty',
path_points = '$points', time_limit = '$time_limit' WHERE path_id = '$pathID'";
$result = $connectNow->query($sqlQuery);

$sqlQuery2 = "SELECT * FROM paths WHERE path_id = '$pathID'";
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