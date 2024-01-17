<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data
if (isset($_POST['checkpointId'])) {
    $checkpointId = $_POST['checkpointId'];
} else {    
    $checkpointId = "";
}
$sqlQuery1 = "SELECT * FROM paths";
$result1 = $connectNow->query($sqlQuery1);

if ($result1->num_rows > 0) {
    while ($rowFound = $result1->fetch_assoc()) {
        $allPaths[] = $rowFound;
    }
    foreach ($allPaths as $path) {
        $checkpointList = explode(",", str_replace("]","",str_replace("[","",$path['path_checkpoint_list'])));
        foreach ($checkpointList as $checkpoint) {
            if($checkpoint == $checkpointId){
                $pathID = $path['path_id'];
                $sqlQuery2 = "UPDATE paths SET path_checkpoint_list = '0' WHERE path_id = '$pathID'";
                $result2 = $connectNow->query($sqlQuery2);
            }
        }
    }
} else {
    echo json_encode(array("success" => false));
}

$sqlQuery3 = "DELETE FROM checkpoints WHERE  checkpoint_id = '$checkpointId'";
$result3 = $connectNow->query($sqlQuery3);

if($result3){
    echo json_encode(array("success"=>true));
}else{
    echo json_encode(array("success"=>false));
}