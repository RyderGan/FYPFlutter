<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['pathID'])) {
    $pathID = $_POST['pathID'];
} else {    
    $pathID = "";
}

$sqlQuery1 = "SELECT * FROM sets";
$result1 = $connectNow->query($sqlQuery1);

if ($result1->num_rows > 0) {
    while ($rowFound = $result1->fetch_assoc()) {
        $allSets[] = $rowFound;
    }
    foreach ($allSets as $set) {
        $pathList = explode(",", str_replace("]","",str_replace("[","",$set['set_path_list'])));
        foreach ($pathList as $path) {
            if($path == $pathID){
                $setID = $set['set_id'];
                $sqlQuery2 = "UPDATE sets SET set_path_list = '0' WHERE set_id = '$setID'";
                $result2 = $connectNow->query($sqlQuery2);
            }
        }
    }
} else {
    echo json_encode(array("success" => false));
}

$sqlQuery = "DELETE FROM paths WHERE  path_id = '$pathID'";
$result = $connectNow->query($sqlQuery);

if($result){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}