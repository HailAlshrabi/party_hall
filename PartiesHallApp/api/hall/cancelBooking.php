<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../library/function.php";

if(isset($_POST["id"]) 
&& isset($_POST["status"])
){
	
	
 $id =htmlspecialchars(strip_tags($_POST["id"])) ;
 $status = htmlspecialchars(strip_tags($_POST["status"]));


 
 $insertArray = array();
 array_push($insertArray,$status) ;
array_push($insertArray,$id) ;


 
$sqlInsert = "UPDATE booking_hall SET status =? WHERE id =? ";
		
$resultInsert = dbExec($sqlInsert, $insertArray);
// $result : is return ( true ) if success execute query or insert or update
if($resultInsert){


 $resJson = array("success"=>true,"message" => "تم إلغاء الحجز بنجاح", "result" => null);
 echo json_encode($resJson, JSON_UNESCAPED_UNICODE);


}else{

 $resJson = array("success"=>false,"message" => "لم تتم إلغاء الحجز بنجاح", "result" => null);
echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}	
 
	
}else{
	 //bad request
     
     $resJson = array("success"=>false,"message" => "لم يتمكن من المصادقة ", "result" => null);
     echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}

?>