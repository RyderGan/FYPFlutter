<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['update_bmiID'])) {
    $bmiID = $_POST['update_bmiID'];
} else {    
    $bmiID = "";
}

if (isset($_POST['update_weight'])) {
    $weight = $_POST['update_weight'];
} else {    
    $weight = "";
}

if (isset($_POST['update_height'])) {
    $height = $_POST['update_height'];
} else {    
    $height = "";
}

$sqlQuery = "UPDATE bmis SET user_weight = '$weight', user_height = '$height' WHERE bmi_id = '$bmiID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
