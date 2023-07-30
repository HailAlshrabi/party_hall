<?php
include_once "database.php";
// conver kb to Mb = 1024 * 1024 =1048576
define("MB", 1048576);

function dbExec($sql, $param_array)
{
	try{
	// create object from database
    $database = new Database();
    $database->getConnection();
    $myCon = $database->conn;
    $stmt = $myCon->prepare($sql);
    $stmt->execute($param_array);
    return $stmt;
	
	}catch(PDOException $exception)
        {
            echo "connection error " . $exception->getMessage();
        }
}

function dbMultipleExec($sql)
{
	try{
	// create object from database
    $database = new Database();
    $database->getConnection();
    $myCon = $database->conn;
    $stmt = $myCon->prepare($sql);
    // $stmt->execute($param_array);
    return $stmt;
	
	}catch(PDOException $exception)
        {
            echo "connection error " . $exception->getMessage();
        }
}




function filterRequest($requestname)
{
  return  htmlspecialchars(strip_tags($_POST[$requestname]));
}

function getRandomImageName(){
  $times = microtime(true) * 1000;
  return "img".intval($times).rand(1000 , 10000);
}

function base64ToImage($myImage){
  $base64_string = $myImage;
  $image_name = getRandomImageName() . ".png";
  $outputfile = '../../images/'. $image_name ;


  $filehandler = fopen($outputfile, 'wb' ); 

  
  fwrite($filehandler, base64_decode($base64_string));

  fclose($filehandler);

  return $image_name ;
}

function deleteFile($dir, $imagename)
{
  if (file_exists($dir . "/" . $imagename)) {
    unlink($dir . "/" . $imagename);//unlink()-> for delete file
  }
}

?>