<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

if (isset($_POST['name'])) {
    $name= $_POST['name'];
} else {    
    $name= "";
}

if (isset($_POST['description'])) {
    $description = $_POST['description'];
} else {    
    $description = "";
}

if (isset($_POST['location'])) {
    $location = $_POST['location'];
} else {    
    $location = "";
}

if (isset($_POST['type'])) {
    $type = $_POST['type'];
} else {    
    $type = "";
}


$sqlQuery = "INSERT INTO checkpoints SET checkpoint_name = '$name', checkpoint_description = '$description',
 checkpoint_location = '$location', checkpoint_type = '$type'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}
?>