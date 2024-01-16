<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

if (isset($_POST['userID'])) {
    $userID = $_POST['userID'];
} else {    
    $userID = "";
}

if (isset($_POST['vfID'])) {
    $vfID = $_POST['vfID'];
} else {    
    $vfID = "";
}

$sqlQuery = "DELETE FROM visceral_fats WHERE user_id = '$userID' AND vf_id = '$vfID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
