<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['rewardID'])) {
    $rewardID = $_POST['rewardID'];
} else {    
    $rewardID = "";
}

$sqlQuery = "DELETE FROM rewards WHERE  reward_id = '$rewardID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}