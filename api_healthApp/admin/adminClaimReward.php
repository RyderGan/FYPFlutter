<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$claimRewardID = $_POST['claimRewardID'];

$sqlQuery = "UPDATE claim_rewards SET claim_reward_status = 'claimed' WHERE claim_reward_id = '$claimRewardID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
    //Add notification
}else{
    echo json_encode(array("success"=>false));
}