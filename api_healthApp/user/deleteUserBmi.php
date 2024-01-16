<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

if (isset($_POST['userID'])) {
    $userID = $_POST['userID'];
} else {    
    $userID = "";
}

if (isset($_POST['bmiID'])) {
    $bmiID = $_POST['bmiID'];
} else {    
    $bmiID = "";
}

$sqlQuery = "DELETE FROM bmis WHERE user_id = '$userID' AND bmi_id = '$bmiID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
