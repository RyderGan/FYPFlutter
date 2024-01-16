<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['vfID'])) {
    $vfID = $_POST['vfID'];
} else {    
    $vfID = "";
}
if (isset($_POST['rating'])) {
    $rating = $_POST['rating'];
} else {    
    $rating = "";
}

$sqlQuery = "UPDATE visceral_fats SET rating = '$rating' WHERE vf_id = '$vfID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
