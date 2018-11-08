<?php

header("Content-type: text/xml"); 

$myDirectory = opendir(".");

while($entryName = readdir($myDirectory)) 
{
	$dirArray[] = $entryName;
}

closedir($myDirectory);

$indexCount	= count($dirArray);

print("<?xml version='1.0' encoding='utf-8' ?>\n");
print("<data_files>\n");

for($index=0; $index < $indexCount; $index++) 
{
    if (substr("$dirArray[$index]", 0, 1) != "." && $dirArray[$index] != "list_files_xml.php")
	{ 
		print("<file>\n");
		print("<file_name>");
		print("$dirArray[$index]");
		print("</file_name>\n");		
		print("<file_size>");
		print(filesize($dirArray[$index]));
		print("</file_size>\n");
		print("</file>\n");
	}
}
print("</data_files>\n");
?>