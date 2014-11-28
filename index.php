<?php
	// Only works with PHP compiled as an Apache module
	$headers = apache_request_headers();

	$objectName = $headers["X-SecondLife-Object-Name"];
	$objectKey     = $headers["X-SecondLife-Object-Key"];
	$ownerKey     = $headers["X-SecondLife-Owner-Key"];
	$ownerName = $headers["X-SecondLife-Owner-Name"];
	$region        = $headers["X-SecondLife-Region"];
	// and so on for getting all the other variables ...

	// get things from $_POST[]
	// Naturally enough, if this is empty, you won't get anything
	$param1    = $_POST["param1"];
	$param2    = $_POST["param2"];
	$param3    = $_POST["param3"];
	$param4    = $_POST["param4"];
	$param5    = $_POST["param5"];

	if ($param1 == "box")
	{
		echo $objectName . " " . $param1 . " " . $param2 . " added\n";
		$boxesFile = fopen("SLboxes.txt", "a");
		fwrite($boxesFile, $param2 . " " . $param3 . "\n");
		fclose($boxesFile);
	}
	elseif ($param1 == "chat")
	{
		echo "chat received";
		$chatFile = fopen("SLchat.txt", "a");
		fwrite($chatFile, $param2 . " " . $param3 . " " . $param4 . " " . $param5 . "\n");
		fclose($chatFile);
	}	
php?>