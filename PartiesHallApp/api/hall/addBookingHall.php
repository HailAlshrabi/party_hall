<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../library/function.php";

if(isset($_POST["hallId"]) 
&& isset($_POST["userId"])
&& isset($_POST["date"])

){
	
	
 $hallId =htmlspecialchars(strip_tags($_POST["hallId"])) ;
 $userId = htmlspecialchars(strip_tags($_POST["userId"]));
 $date = htmlspecialchars(strip_tags($_POST["date"]));
 $name =htmlspecialchars(strip_tags($_POST["name"])) ;
 $phone = htmlspecialchars(strip_tags($_POST["phone"]));
 $period = htmlspecialchars(strip_tags($_POST["period"]));

 $selectArray = array();
 array_push($selectArray,$hallId) ;
 array_push($selectArray,$date) ;

 $sqlSelect = "SELECT * FROM booking_hall WHERE hall_id = ? AND date_booking = ? ";
 $result = dbExec($sqlSelect, $selectArray);

 if($result->rowCount() <= 0){
     $insertArray = array();

     array_push($insertArray,$hallId) ;
     array_push($insertArray,$userId) ;
     array_push($insertArray,$date) ;
     array_push($insertArray,$name) ;
     array_push($insertArray,$phone) ;
     array_push($insertArray,$period) ;
     
      
     $sqlInsert = "INSERT INTO booking_hall (hall_id , user_id,date_booking,name,phone,period ) VALUES(? , ?,?,?,?,?) ";
               
     $resultInsert = dbExec($sqlInsert, $insertArray);
     // $result : is return ( true ) if success execute query or insert or update
     if($resultInsert){
     
     
      $resJson = array("success"=>true,"message" => "تم الإضافة بنجاح", "result" => null);
      echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
     
     
     }else{
     
      $resJson = array("success"=>false,"message" => "لم تتم الإضافة بنجاح", "result" => null);
     echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
     }	
 }else{
     $resJson = array("success"=>false,"message" => "الفاعة محجوزة", "result" => null);
     echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
 }

 
	
}else{
	 //bad request
     
     $resJson = array("success"=>false,"message" => "لم يتمكن من المصادقة ", "result" => null);
     echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}

?>