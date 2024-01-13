<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$userID = $_POST['userID'];
$rewardID = $_POST['rewardID'];

$sqlQuery = "INSERT INTO claim_rewards SET reward_id = '$rewardID', 
user_id = '$userID', claim_reward_status = 'new'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
