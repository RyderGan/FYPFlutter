<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

if (isset($_POST['userID'])) {
    $userID = $_POST['userID'];
} else {    
    $userID = "";
}

if (isset($_POST['notifyID'])) {
    $notifyID = $_POST['notifyID'];
} else {    
    $notifyID = "";
}
$hasRead = 1;

$sqlQuery = "UPDATE notifications SET hasRead = '$hasRead' WHERE notify_id = '$notifyID' AND user_id = '$userID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
