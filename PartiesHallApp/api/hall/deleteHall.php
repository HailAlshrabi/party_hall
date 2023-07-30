<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../library/function.php";

if(isset($_POST["id"]) ){
	
$id =htmlspecialchars(strip_tags($_POST["id"])) ;	

$deleteArray = array();

array_push($deleteArray,$id);

 $sqldelete = "DELETE FROM booking_hall WHERE id =? ";
      
 $resultdelete = dbExec($sqldelete, $deleteArray);
 // $result : is return ( true ) if success execute query or insert or update
 if($resultdelete){

  $resJson = array("success"=>true,"message" => "تم الحذف بنجاح", "result" => null);
  echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
 }else{
  
  $resJson = array("success"=>false,"message" => "لم يتم الحذف بنجاح", "result" => null);
 echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}	

 
	
}else{
	 //bad request
     
     $resJson = array("success"=>false,"message" => "لم يتمكن من المصادقة ", "result" => null);
     echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}

?>