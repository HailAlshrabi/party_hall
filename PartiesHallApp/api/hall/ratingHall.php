<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../library/function.php";

if(isset($_POST["hallId"]) 
&& isset($_POST["ratingStar"])
){
	
	
 $hallId =htmlspecialchars(strip_tags($_POST["hallId"])) ;
 $ratingStar = htmlspecialchars(strip_tags($_POST["ratingStar"]));


 
 $insertArray = array();

array_push($insertArray,$hallId) ;
array_push($insertArray,$ratingStar) ;

 
$sqlInsert = "INSERT INTO star_rating_hall (hall_id , rating_star ) VALUES(? , ?) ";
		
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
	 //bad request
     
     $resJson = array("success"=>false,"message" => "لم يتمكن من المصادقة ", "result" => null);
     echo json_encode($resJson, JSON_UNESCAPED_UNICODE);
}

?>