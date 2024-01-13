<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$claimRewardID = $_POST['claimRewardID'];

$sqlQuery = "DELETE FROM claim_rewards WHERE  claim_reward_id = '$claimRewardID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}