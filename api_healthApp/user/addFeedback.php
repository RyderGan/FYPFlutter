<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

if (isset($_POST['userID'])) {
    $userID = $_POST['userID'];
} else {    
    $userID = "";
}

if (isset($_POST['title'])) {
    $title = $_POST['title'];
} else {    
    $title = "";
}

if (isset($_POST['description'])) {
    $description = $_POST['description'];
} else {    
    $description = "";
}

$sqlQuery = "INSERT INTO feedbacks SET user_id = '$userID', title = '$title', fb_description = '$description'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
