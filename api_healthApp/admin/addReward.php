<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$rewardTitle = $_POST['rewardTitle'];
$rewardDescription = $_POST['rewardDescription'];
$requiredPt = $_POST['requiredPt'];

$sqlQuery = "INSERT INTO rewards SET reward_title = '$rewardTitle', reward_description = '$rewardDescription',
 required_pt = '$requiredPt'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
