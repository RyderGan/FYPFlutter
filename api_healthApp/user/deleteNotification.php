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

$sqlQuery = "DELETE FROM notifications WHERE user_id = '$userID' AND notify_id = '$notifyID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
