<?php
include '../connection.php';

//POST = send/save data
//GET retrieve/read data

$sqlQuery = "SELECT * FROM about_us";
$result = $connectNow->query($sqlQuery);

if ($result->num_rows > 0) {
    while ($rowFound = $result->fetch_assoc()) {
        $aboutUs[] = $rowFound;
    }
    echo json_encode(array(
        "success" => true,
        "aboutUs" => $aboutUs,  //row number
    ));
} else {
    echo json_encode(array("success" => false));
}
