<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

if (isset($_POST['userID'])) {
    $userID = $_POST['userID'];
} else {    
    $userID = "";
}

if (isset($_POST['bpID'])) {
    $bpID = $_POST['bpID'];
} else {    
    $bpID = "";
}

$sqlQuery = "DELETE FROM blood_pressures WHERE user_id = '$userID' AND bp_id = '$bpID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
