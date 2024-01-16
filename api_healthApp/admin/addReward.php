<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

if (isset($_POST['rewardTitle'])) {
    $rewardTitle = $_POST['rewardTitle'];
} else {    
    $rewardTitle = "";
}

if (isset($_POST['rewardDescription'])) {
    $rewardDescription = $_POST['rewardDescription'];
} else {    
    $rewardDescription = "";
}

if (isset($_POST['requiredPt'])) {
    $requiredPt = $_POST['requiredPt'];
} else {    
    $requiredPt = "";
}

$sqlQuery = "INSERT INTO rewards SET reward_title = '$rewardTitle', reward_description = '$rewardDescription',
 required_pt = '$requiredPt'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
