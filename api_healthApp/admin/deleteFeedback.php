<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['feedbackID'])) {
    $feedbackID = $_POST['feedbackID'];
} else {    
    $feedbackID = "";
}


$sqlQuery = "DELETE FROM feedbacks WHERE  feedback_id = '$feedbackID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}