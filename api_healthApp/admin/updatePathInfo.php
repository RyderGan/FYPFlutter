<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['name'])) {
    $name= $_POST['name'];
} else {    
    $name= "";
}

if (isset($_POST['distance'])) {
    $distance = $_POST['distance'];
} else {    
    $distance = "";
}

if (isset($_POST['elevation'])) {
    $elevation = $_POST['elevation'];
} else {    
    $elevation = "";
}

if (isset($_POST['difficulty'])) {
    $difficulty = $_POST['difficulty'];
} else {    
    $difficulty = "";
}

if (isset($_POST['points'])) {
    $points = $_POST['points'];
} else {    
    $points = "";
}

if (isset($_POST['time_limit'])) {
    $time_limit = $_POST['time_limit'];
} else {    
    $time_limit = "";
}

if (isset($_POST['type'])) {
    $type = $_POST['type'];
} else {    
    $type = "";
}

if (isset($_POST['pathID'])) {
    $pathID = $_POST['pathID'];
} else {    
    $pathID = "";
}

$sqlQuery = "UPDATE paths SET path_name = '$name', path_distance = '$distance',
 path_elevation = '$elevation', path_difficulty = '$difficulty',
path_points = '$points', time_limit = '$time_limit', path_type = '$type' WHERE path_id = '$pathID'";
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