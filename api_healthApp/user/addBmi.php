<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['userID'])) {
    $userID = $_POST['userID'];
} else {    
    $userID = "";
}

if (isset($_POST['weight'])) {
    $weight = $_POST['weight'];
} else {    
    $weight = "";
}

if (isset($_POST['height'])) {
    $height = $_POST['height'];
} else {    
    $height = "";
}

$sqlQuery = "INSERT INTO bmis SET user_id = '$userID', user_weight = '$weight', user_height = '$height'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
