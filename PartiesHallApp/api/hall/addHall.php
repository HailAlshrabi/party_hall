<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once "../../library/function.php";

if(isset($_POST["name"]) 
&& isset($_POST["price"])
&& isset($_POST["address"])
&& isset($_POST["addressDetails"])
&& isset($_POST["latitude"])
&& isset($_POST["longitude"])
&& isset($_POST["phoneNumbers"])
&& isset($_POST["infoHall"])
&& isset($_POST["city"])
){
	
	
 $name =htmlspecialchars(strip_tags($_POST["name"])) ;
 $price = htmlspecialchars(strip_tags($_POST["price"]));
 $address =htmlspecialchars(strip_tags($_POST["address"])) ;
 $addressDetails =htmlspecialchars(strip_tags($_POST["addressDetails"]));
 $latitude =htmlspecialchars(strip_tags($_POST["latitude"])) ;
 $longitude =htmlspecialchars(strip_tags($_POST["longitude"]));
 $phoneNumbers =htmlspecialchars(strip_tags($_POST["phoneNumbers"])) ;
 $infoHall =htmlspecialchars(strip_tags($_POST["infoHall"]));
 $city =htmlspecialchars(strip_tags($_POST["city"])) ;

 $imageShowing =htmlspecialchars(strip_tags($_POST["imageShowing"])) ;
 $image1 =htmlspecialchars(strip_tags($_POST["image1"])) ;
 $image2 =htmlspecialchars(strip_tags($_POST["image2"])) ;
 $image3 =htmlspecialchars(strip_tags($_POST["image3"])) ;
 
 $insertArray = array();

array_push($insertArray,$name) ;
array_push($insertArray,$price) ;
array_push($insertArray,$address) ;
array_push($insertArray,$addressDetails) ;
array_push($insertArray,$latitude ) ;
array_push($insertArray,$longitude) ;
array_push($insertArray,$phoneNumbers) ;
array_push($insertArray,$infoHall) ;
array_push($insertArray,$city) ;

if( $imageShowing != ''){
  $image_name = base64ToImage($imageShowing);
  array_push($insertArray,$image_name);
}

if( $image1 != ''){
  $image_name1 = base64ToImage($image1);
  array_push($insertArray,$image_name1);
}
if( $image2 != ''){
  $image_name2 = base64ToImage($image2);
  array_push($insertArray,$image_name2);
}
if( $image3 != ''){
  $image_name3 = base64ToImage($image3);
  array_push($insertArray,$image_name3);
}

 
$sqlInsert = "INSERT INTO hall_table (hall_name , price , address , address_details,latitude ,longitude ,phoneNumbers,info_hall,city,image_displaying,image1 ,image2,image3) VALUES(? , ? , ?,?,?,?,?,?,?,?,?,?,?) ";
		
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