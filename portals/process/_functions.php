<?php 
/*
DELIMITER $$
DROP FUNCTION IF EXISTS `junk`.`GetAncestry` $$
CREATE FUNCTION `junk`.`GetAncestry` (GivenID INT) RETURNS VARCHAR(1024)
DETERMINISTIC
BEGIN
    DECLARE rv VARCHAR(1024);
    DECLARE cm CHAR(1);
    DECLARE ch INT;

    SET rv = '';
    SET cm = '';
    SET ch = GivenID;
    WHILE ch > 0 DO
        SELECT IFNULL(parent_id,-1) INTO ch FROM
        (SELECT parent_id FROM categories WHERE id = ch) AS A;
        IF ch > 0 THEN
            SET rv = CONCAT(rv,cm,ch);
            SET cm = ',';
        END IF;
    END WHILE;
    RETURN rv;
END $$
DELIMITER ;
*/


/*

DELIMITER $$
DROP FUNCTION IF EXISTS findDepth $$

CREATE FUNCTION findDepth(idToSearch INT) RETURNS INT BEGIN

 DECLARE depth INT;
 SET depth = 0;

 WHILE ( idToSearch  is not  null) DO

   SET idToSearch = ( select parent_id
     from wbs_global
     where item_id = idToSearch
                  );

   SET depth = depth + 1;

 END WHILE;

 RETURN depth;

END;
$$
DELIMITER;



/* GET SUB-TREE */
/*

DELIMITER $$

DROP FUNCTION IF EXISTS getTree $$
CREATE FUNCTION getTree (GivenID INT) RETURNS varchar(1024) CHARSET latin1
DETERMINISTIC
BEGIN

    DECLARE rv,q,queue,queue_children VARCHAR(1024);
    DECLARE queue_length,front_id,pos INT;

    SET rv = GivenID;
    SET queue = GivenID;
    SET queue_length = 1;

    WHILE queue_length > 0 DO
         IF queue_length = 1 THEN
			SET front_id = queue;
				SET queue = '';
			ELSE
			SET front_id = SUBSTR(queue,1,LOCATE(',',queue)-1);
				SET pos = LOCATE(',',queue) + 1;
				SET q = SUBSTR(queue,pos);
				SET queue = q;
		END IF;
        SET queue_length = queue_length - 1;

        SELECT IFNULL(qc,'') INTO queue_children
        FROM (SELECT GROUP_CONCAT(code) qc
        FROM wbs WHERE parent_code = front_id) A;

        IF LENGTH(queue_children) = 0 THEN
            IF LENGTH(queue) = 0 THEN
                SET queue_length = 0;
            END IF;
        ELSE
            IF LENGTH(rv) = 0 THEN
                SET rv = queue_children;
            ELSE
                SET rv = CONCAT(rv, ',', queue_children);
            END IF;
            IF LENGTH(queue) = 0 THEN
                SET queue = queue_children;
            ELSE
                SET queue = CONCAT(queue, ',', queue_children);
            END IF;
            SET queue_length = LENGTH(queue) - LENGTH(REPLACE(queue, ',', '')) + 1;
        END IF;
    END WHILE;

    RETURN rv;

END $$ 



*/?>


<?php
	//session_start();
	error_reporting(E_ALL);
	ini_set('display_errors', 1);
	
	function deleteRecord($connect, $table, $field, $id)
	{
		$sql = "DELETE FROM $table WHERE $field = $id";
			if($connect->query($sql)){
				 $res = array('query' => 'Delete', $field => (int)$id);
			     echo json_encode($res);
			}
			else
				echo "Error: " . $sql . "<br>" . $connect->error;


	}
	function hieRecord($connect, $inputs, $table, $keytable = null){
		if(isset($inputs['save'])){ // Insert record
			if(isset($inputs['query']) && $inputs['query'] == 'update' )
			{
				
				    $sql = "UPDATE $table SET `name` ='".(string)$inputs['name']."', `description` ='".(string)$inputs['description']."' WHERE `id` = ".(int)$inputs['id']."";	
								
				if($connect->query($sql)) {
					$res = array('query' => 'Update', 'id' => (int)$inputs['id']);
					echo json_encode($res);					
					if( isset($inputs['parents'])) {
						
						$sql = "DELETE FROM $keytable WHERE childId = ".(int)$inputs['id']."";
						if($connect->query($sql)) {
							
							for( $i = 0; $i < sizeof($inputs['parents']); $i++)	{
								$sql = "INSERT INTO $keytable (parentId, childId) VALUES ('".(int)$inputs['parents'][$i]."', '".(int)$inputs['id']."')";
								if(!$connect->query($sql))
									echo "Error: " . $sql . "<br>" . mysql_connect_error();// $connect->error;	
							}
						}
						else
						echo "Query: " . $sql . "<br> Error:" . $connect->error;
					}
					
				}
				else
					echo "Error: " . $sql . "<br>" . $connect->error;
			}
			else
			{				
				$sql = "INSERT INTO $table (id, name, description) VALUES ('".(int)$inputs['id']."', '".(string)$inputs['name']."', '".(string)$inputs['description']."')";		//
				if($connect->query($sql))		
				{				
					$res = array('query' => 'Insert', 'id' => (int)$inputs['id']);
					echo json_encode($res);
					if(isset($inputs['parents'])) {
						for( $i = 0; $i < sizeof($inputs['parents']); $i++)
						{
							$sql = "INSERT INTO $keytable (parentId, childId) VALUES ('".(int)$inputs['parents'][$i]."', '".(int)$inputs['id']."')";
							if(!$connect->query($sql))
								echo "Error: " . $sql . "<br>" . $connect->error;	
						}
					}
							
				}
				else
					echo "Error: " . $sql . "<br>" . $connect->error;
			}
		}
		
		if(isset($inputs['delete'])) { // delete records
			deleteRecord($connect, $table, 'Id', $inputs['id']);			
		} 
	}
	// End of heirarchy function

	


	function fetchData($connect, $table){ // Fetch WBS data
		$sql = "SELECT * FROM $table";
		$result = $connect->query($sql);
		
		if($result)
		{
			return $result->fetch_all();									
		}
		else
			echo "Error: " . $sql . "<br>" . $connect->error;
	}
	function fetchAllUser($connect){ // Fetch users' data
		$sql = "SELECT id, firstName, lastName, email, phone, organization, education, college, class, status  FROM user";
		$result = $connect->query($sql);
		
		if($result)
		{
			return $result->fetch_all();									
		}
		else
			echo "Error: " . $sql . "<br>" . $connect->error;
	}
	function fetchUser($connect, $userId){ // Fetch users' data
		$sql = "SELECT id, email, firstName, lastName, phone, organization, education, college, class, status  FROM user WHERE id=$userId";
		$result = mysqli_query($connect,$sql);	
		if($result)
		{
			$row = mysqli_fetch_array($result, MYSQLI_NUM);		
		return $row;
		}
		else
			echo "Error: " . $sql . "<br>" . $connect->error;
		
	
	}
	function fetchData2($connect, $table, $key_table){ // Select all parents
	
		$sql = "SELECT  *, (SELECT (GROUP_CONCAT($key_table.parentId)) 
			FROM $key_table
			WHERE $key_table.childId = $table.id) AS parent
			FROM $table";

		if(!$result = $connect->query($sql))
			echo "Error: " . $sql . "<br>" . $connect->error;
		else
			return $result->fetch_all();
									
	}
	function fetchAllProject($connect){
	
		$sql = "SELECT p.id, p.name, p.location, i.id, i.name, l.id, l.firstName, l.lastName, p.controller, u.firstName, u.lastName, u.email, p.link, p.confirmDate, p.closeDate, p.summary, p.status, p.timestamp  FROM project as p
		INNER JOIN industry as i
		ON p.industry = i.id
		INNER JOIN lead as l
		ON p.leadId = l.id 
		INNER JOIN user as u
		ON p.controller = u.id
		ORDER BY p.id";
		$result = $connect->query($sql);
		
		if($result)
		{
			return $result->fetch_all();									
		}

	}
	function fetchProject($connect, $pid){
	
		$sql = "SELECT p.id, p.name, p.location, i.id, i.name, l.id, l.firstName, l.lastName, p.controller, u.firstName, u.lastName, u.email, p.link, p.confirmDate, p.closeDate, p.summary, p.status, p.timestamp  FROM project as p
		INNER JOIN industry as i
		ON p.industry = i.id
		INNER JOIN lead as l
		ON p.leadId = l.id 
		INNER JOIN user as u
		ON p.controller = u.id
		WHERE p.id = $pid";
		$result = $connect->query($sql);
		
		if($result)
		{
			return $result->fetch_all();									
		}

	}
	
	function fetchEmployeeProject($connect, $employeeId){
	
	//	$sql = "SELECT emp.projectId, p.id, p.name, p.location, i.name, p.controller, u.firstName, u.lastName, u.email, p.link, p.closeDate, p.summary, p.status, p.timestamp
		$sql = "SELECT emp.projectId, p.name, p.location, i.name, p.controller, u.firstName, u.lastName, u.email, p.link, emp.endDate, p.closeDate, p.summary, p.status, p.timestamp 
		FROM emp_project as emp
		INNER JOIN project as p
		ON emp.projectId = p.id
		INNER JOIN industry as i
		ON p.industry = i.id
		INNER JOIN user as u 
		ON emp.employeeId = u.id 
		WHERE emp.employeeId = $employeeId";
		$result = $connect->query($sql);
		
		if($result)
		{
			return $result->fetch_all();									
		}
		else
			echo "Error: " . $sql . "<br>" . $connect->error;

	}
	
	function displayData($inputData, $keyArray, $key){ // Display table data for full heirarachy
		$data = NULL;
		
		$k = 0;
		for($i = 0; $i < sizeof($keyArray); $i++) //$keyArray is foreign key array
		{
			if($keyArray[$i][0] == $key) //$key 
			{
				$data[$k][0] = $keyArray[$i][1];
				for($j = 0; $j < sizeof($inputData); $j++)
				{
					if($data[$k][0] == $inputData[$j][0])
					{
						$data[$k][1] = $inputData[$j][1];
						$data[$k][2] = $inputData[$j][2];					
					}
				}
			
				$k++;
			}
			
		}
		if($data)	
			return $data;

	}
	function projectRecord($connect, $inputs, $table){
		if(isset($inputs['save'])){ // Insert record
			if(isset($inputs['query']) && $inputs['query'] == 'update' )
			{
				$sql = "UPDATE $table SET `name` ='".(string)$inputs['name']."', 
				`location` ='".(string)$inputs['location']."', 
				`industry` ='".(int)$inputs['industry']."', 
				`leadId` ='".(int)$inputs['leadId']."', 
				 `controller` ='".(int)$inputs['controller']."',
				 `link` ='".(string)$inputs['link']."',
				 `summary` ='".(string)$inputs['summary']."',
				 `confirmDate` ='".$inputs['confirmDate']."',
				 `closeDate` ='".$inputs['closeDate']."', 
				`status` ='".(int)$inputs['status']."' 
				WHERE `id` = ".(int)$inputs['id']."";	
				
				if($connect->query($sql)) {
					$res = array('query' => 'Update', 'id' => (int)$inputs['id']);
					echo json_encode($res);
				}
				else
					echo "Error: " . $sql . "<br>" . $connect->error;
			}
			else
			{				
				$sql = "INSERT INTO $table (name, industry, location, leadId, controller, link, summary, confirmDate, closeDate, status) 
				VALUES ('".(string)$inputs['name']."', 
				'".(int)$inputs['industry']."',
				'".(string)$inputs['location']."', 
				'".(int)$inputs['leadId']."', 
				'".(int)$inputs['controller']."',
				'".(string)$inputs['link']."',
				'".(string)$inputs['summary']."', 
				'".(string)$inputs['confirmDate']."', 
				'".(string)$inputs['closeDate']."', 
				'".(int)$inputs['status']."')";	
				if($connect->query($sql))		
				{				
					$res = array('query' => 'Insert', 'id' => (int)$inputs['id']);
					echo json_encode($res);						
				}
				else
					echo "Error: " . $sql . "<br>" . $connect->error;
			}
		}
		
		if(isset($inputs['delete'])) { // delete records
			deleteRecord($connect, $table, 'id', $inputs['id']);
			
		} 
			

	}
	function displayProjectWBS($inputData, $keyArray, $key){ // Display table data for full heirarachy
		$data = NULL;
		
		$k = 0;
		for($i = 0; $i < sizeof($keyArray); $i++) //$keyArray is foreign key array
		{
			if($keyArray[$i][0] == $key) //$key 
			{
				$data[$k][0] = $keyArray[$i][1];
				for($j = 0; $j < sizeof($inputData); $j++)
				{
					if($data[$k][0] == $inputData[$j][0])
					{
						$data[$k][1] = $inputData[$j][1];
						$data[$k][2] = $inputData[$j][2];					
					}
				}
			
				$k++;
			}
			
		}
		if($data)	
			return $data;

	} 
	
	function insert($connect, $inputs)
	{   
		if(isset($inputs['save'])){
			$data = $input['data'];
			unset($input['save']);
			unset($input['data']);
			
			if(isset($input['parents']))
			{
				$parents = $input['parents'];
				unset($input['parents']);
				$fKeyTable = $input['keyTable'];
				unset($input['keyTable']);
			}	

			$columns = implode(",",array_keys($inputs));
			$values  = implode("','", array_values($inputs));
			$sql = "INSERT INTO $data (".mysqli_real_escape_string($connect, $columns).") VALUES ('".mysqli_real_escape_string($connect, $values)."')";
			if($connect->query($sql))
			{				
					if(isset($parents)) 
					{
						for( $i = 0; $i < sizeof($inputs['parents']); $i++)
						{
							$sql = "INSERT INTO $fkeytable (parentId, childId) VALUES ('".(int)$parents[$i]."', '".(int)$inputs['id']."')";
							if(!$connect->query($sql))
								echo "Error: " . $sql . "<br>" . $connect->error;
							else
							{
								$res = array('query' => 'Insert', 'id' => (int)$inputs['id']);
								echo json_encode($res);
							}
						}
					}
					else
					{
						$res = array('query'=>'Insert', 'id'=>(int)$inputs['id']);
						echo json_encode($res);
					}

			}
		}
	}
	function projectSectionFetch($connect, $id)
	{		
		$sql = "SELECT ps.childId, s.name FROM project_section  AS ps 
		INNER JOIN section AS s On ps.childId = s.id
		WHERE ps.projectId = $id ORDER BY ps.childId";
		$result = $connect->query($sql);
		if($result)
		{									
			return $result->fetch_all();					
		}	
	}
	function fetchProjectFK($connect, $table, $id){
		$sql = "SELECT  parentId, childId FROM $table WHERE projectId = $id";
		$result = $connect->query($sql);
		
		if($result)
		{
			return $result->fetch_all();									
		}

	}
	function InsertWbs($connect, $inputs){
			if(count($inputs['records']) > 0);
			{
				$records = $inputs['records'];
				$num = count($inputs['records']); 
				//var_dump($inputs['records']);
						
				for($i = 0; $i < $num; $i++ )
				{				
				

					switch((string)$records[$i]['data_type'])
					{
						case 'section':
							{
								$sql = "INSERT INTO project_section (projectId, childId) VALUES  ('".(int)$records[$i]['project']."', '".(int)$records[$i]['id']."')";
								
							}
							break;
						case 'activity':
							{
								$sql = "INSERT INTO project_activity (projectId, childId, parentId) VALUES  ('".(int)$records[$i]['project']."', '".(int)$records[$i]['id']."', '".(int)$records[$i]['parent']."')";
								
							}
							break;
						case 'material':
							{
								$sql = "INSERT INTO project_material (projectId, childId, parentId) VALUES  ('".(int)$records[$i]['project']."', '".(int)$records[$i]['id']."', '".(int)$records[$i]['parent']."')";
								
							}
							break;
						default:
							break;
					}
					if($connect->query($sql))
						echo "Good";
					else 
						echo $connect->error; 

				}				
			}
		}


	function removeWbs($connect, $inputs){
			if(count($inputs['records']) > 0);
			{
				$records = $inputs['records'];
				$num = count($inputs['records']); 
						
				for($i = 0; $i < $num; $i++ )
				{				
					$projectId = mysqli_real_escape_string($connect, $records[$i]['project']);
					$childId = mysqli_real_escape_string($connect, $records[$i]['id']);
					$parentId = mysqli_real_escape_string($connect, $records[$i]['parent']);
					switch((string)$records[$i]['data_type'])
					{
						case 'section':
							{
								if($parentId != '#')
									$sql = "DELETE FROM project_section  WHERE projectId = '$projectId' AND parentId = $parentId AND childId = '$childId'";
									
								else
									$sql = "DELETE FROM project_section  WHERE projectId = '$projectId' AND childId = '$childId'";
							}
							break;
						case 'activity':
							{
								$sql = "DELETE FROM project_activity WHERE projectId = '$projectId' AND parentId = $parentId AND childId = '$childId'";
								
							}
							break;
						case 'material':
							{
								$sql = "DELETE FROM project_material WHERE projectId = '$projectId' AND parentId = $parentId AND childId = '$childId'";
								
							}
							break;
						default:
							break;
					}
					if($connect->query($sql))
					{
						echo "Delete Successes";
						//$connect->close();
					}
					else 
						echo $sql."<br/>".$connect->error; 

				}				
			}
		}
		
		function projectEmployee($connect, $inputs) {		
		
			if(isset($inputs['save'])){ // Insert record
								
					$sql = "INSERT INTO emp_project (projectId, employeeId) VALUES ('".(int)$inputs['projectId']."', '".(int)$inputs['employeeId']."')";		//
					if($connect->query($sql))		
					{				
						$res = array('query' => 'Insert', 'projectId' => (int)$inputs['projectId'],  'employeeId' => (int)$inputs['employeeId']);						
						echo json_encode($res);			
					}
					else
						echo "Error: " . $sql . "<br>" . $connect->error;
				
			}
			
			if(isset($inputs['delete'])) { // delete records
				   $projectId = mysqli_real_escape_string($connect, $inputs['projectId']);
				   $employeeId = mysqli_real_escape_string($connect, $inputs['employeeId']);
				   $sql = "DELETE FROM emp_project WHERE projectId = $projectId AND employeeId = $employeeId";
				   if($connect->query($sql))
				   {
				   		$res = array('query' => 'delete', 'projectId' => (int)$inputs['projectId'],  'employeeId' => (int)$inputs['employeeId']);
						echo json_encode($res);
				   }
				   else 
				   		echo "Error: " . $sql . "<br>" . $connect->error;
				
			} 

		} 
		function fetchProjectEmployee($connect) {		
			
			$sql = "SELECT ep.projectId, p.name, u.id, u.firstName, u.lastName, u.email, u.phone  FROM emp_project as ep
			INNER JOIN project as p
			ON ep.projectId = p.id
			INNER JOIN user as u
			ON ep.employeeId = u.id 
			WHERE p.status = 0 
			ORDER BY ep.projectId";
			$result = $connect->query($sql);
			
			if($result)
			{
				return $result->fetch_all();									
			}
			

		} 

		function fetchEmployeePwbs($connect, $table, $key1, $key2)
		{
			if($table != "emp_project_section")
				$sql = "SELECT parentId, childId FROM $table WHERE employeeId = $key1 AND projectId = $key2";
			else
				$sql = "SELECT childId FROM $table WHERE employeeId = $key1 AND projectId = $key2";
			$result = $connect->query($sql);
			
			if($result)
			{
				return $result->fetch_all();									
			}
		}
		function employeePwbsSectionFetch($connect, $projectId, $employeeId)
		{		
			$sql = "SELECT eps.childId, s.name FROM emp_project_section  AS eps 
			INNER JOIN section AS s On eps.childId = s.id
			WHERE eps.projectId = $projectId and eps.employeeId = $employeeId ORDER BY eps.childId";
			$result = $connect->query($sql);
			if($result)
			{									
				return $result->fetch_all();					
			}	
		}

		function insertPwbsEmployee($connect, $inputs) {		
			
			var_dump($inputs);
			

			if(count($inputs['records']) > 0);
			{
				$records = $inputs['records'];
				$num = count($inputs['records']); 
				$employeeId = $_SESSION['employeeId'];
				$projectId = $_SESSION['projectId'];
				//var_dump($inputs['records']);
			  			
				for($i = 0; $i < $num; $i++ )
				{				
				

					switch((string)$records[$i]['data_type'])
					{
						case 'section':
							{
								$sql = "INSERT INTO emp_project_section (employeeId, projectId, childId) VALUES  ($employeeId, '".(int)$records[$i]['project']."', '".(int)$records[$i]['id']."')";
								if(!$connect->query($sql))
									echo "error 1: ". $connect->error;
							
							}
							break;
						case 'activity':
							{
								$sql = "INSERT INTO emp_project_activity (employeeId, projectId,  parentId, childId) VALUES  ($employeeId, '".(int)$records[$i]['project']."', '".(int)$records[$i]['parent']."', '".(int)$records[$i]['id']."')";
								if(!$connect->query($sql))
									echo "error 2: ". $connect->error;
							}
							break;
						case 'material':
							{
								$sql = "INSERT INTO emp_project_material (employeeId, projectId, parentId, childId) VALUES  ($employeeId, '".(int)$records[$i]['project']."', '".(int)$records[$i]['parent']."', '".(int)$records[$i]['id']."')";
								if(!$connect->query($sql))
									echo "error 3: ". $connect->error;
							}
							break;
						default:
							break;
					}
					//if($connect->query($sql))
					//	echo "Good";
				//	else 
						 

				}				
			} 
		
			

		} 
		function removePwbsEmployee($connect, $inputs){
			if(count($inputs['records']) > 0);
			{
				$records = $inputs['records'];
				$num = count($inputs['records']); 
						
				for($i = 0; $i < $num; $i++ )
				{				
					$projectId = mysqli_real_escape_string($connect, $records[$i]['project']);
					$childId = mysqli_real_escape_string($connect, $records[$i]['id']);
					$parentId = mysqli_real_escape_string($connect, $records[$i]['parent']);
					$employeeId = $_SESSION['employeeId'];
					switch((string)$records[$i]['data_type'])
					{
						case 'section':
							{
								if($parentId != '#')
									$sql = "DELETE FROM emp_project_section  WHERE projectId = '$projectId' AND parentId = $parentId AND childId = '$childId' AND employeeId = $employeeId";
								else
									$sql = "DELETE FROM emp_project_section  WHERE projectId = '$projectId' AND childId = '$childId' AND employeeId = $employeeId";
							}
							break;
						case 'activity':
							{
								$sql = "DELETE FROM emp_project_activity WHERE projectId = '$projectId' AND parentId = $parentId AND childId = '$childId' AND employeeId = $employeeId";
								
							}
							break;
						case 'material':
							{
								$sql = "DELETE FROM emp_project_material WHERE projectId = '$projectId' AND parentId = $parentId AND childId = '$childId' AND employeeId = $employeeId";
								
							}
							break;
						default:
							break;
					}
					if($connect->query($sql))
					{
						echo "Delete Successes";
						//$connect->close();
					}
					else 
						echo $sql."<br/>".$connect->error; 

				}				
			}
		}

		function addUser($connect, $inputs){
		
			$sql = "INSERT INTO user(firstName, lastName, email, password, phone, organization, education, college, class, status)
			 VALUES ('".$inputs["firstName"]."', '".$inputs["lastName"]."', '".$inputs["email"]."', '123456', '".$inputs["phone"]."', '".$inputs["organization"]."', '".$inputs["education"]."', '".$inputs["college"]."', '".$inputs["class"]."', '".$inputs["status"]."')";
			if ($connect->query($sql))
				echo "Insert Successes";
			else
				echo $sql."<br/>".$connect->error; 
			echo $inputs["firstName"];
		}
		function updateUser($connect, $inputs)
		{
			
			 $sql = "UPDATE user SET `firstName` ='".(string)$inputs['firstName']."', 
			 `lastName` ='".(string)$inputs['lastName']."',
			 `email` ='".(string)$inputs['email']."',
			 `phone` ='".(string)$inputs['phone']."', 
			 `organization` ='".(string)$inputs['organization']."',
			 `education` ='".(int)$inputs['education']."',
			 `college` ='".(string)$inputs['college']."',
			 `class` ='".(int)$inputs['class']."',
			 `status` ='".(int)$inputs['status']."'
			  WHERE `id` = ".(int)$inputs['id']."";
			  if ($connect->query($sql))
				echo "Update Successes";
				
			  else
				echo $sql."<br/>".$connect->error;
			
		}

		function deleteUser($connect, $inputs)
		{
			
			 $sql = "DELETE FROM user WHERE `id` ='".(int)$inputs['id']."'";
			
			  if ($connect->query($sql))
				echo "Delete Successes";
			  else
				echo $sql."<br/>".$connect->error;
			
		}
		function globalWbsMap($el)
		{
			return array("record"=>$el, "children"=>null); // For mapping item

		}
		function idMap($el)
		{
			return $el[0];
		}
		class wbsItem_ {

			//var $columns;
			//var $values;
			
			function __construct($connect, $inputs)
			{
				
				if(isset($inputs['query']))
				{
					$this->query = $inputs['query'];
					unset($inputs['query']);
				}
				if(isset($inputs['save']))
					unset($inputs['save']);
				if(isset($inputs['data']))
					unset($inputs['data']);
				if(isset($inputs['id']))
				{
					$this->record_id = $inputs['id'];
					unset($inputs['id']);
				}
				$this->data_array = $inputs;	
						
							    
				$this->connect = $connect;

			}
			function convertToTree(array $flat, $idField = 'code',
                        $parentIdField = 'parent_code',
                        $childNodesField = 'childNodes') {
				$indexed = array();
				// first pass - get the array indexed by the primary id  
				foreach ($flat as $row) {
					$indexed[$row[$idField]] = $row;
					$indexed[$row[$idField]][$childNodesField] = array();
				}
				//var_dump($indexed);
				//second pass  
				$root = null;
				foreach ($indexed as $id => $row) {
					
					$indexed[$row[$parentIdField]][$childNodesField][$id] =& $indexed[$id];
					if (!$row[$parentIdField]) {
						$root = $id;
						
					}
				}

				return array($root => $indexed[$root]);
			}
			function buildTree(array $elements, $parentId = NULL) {
				$branch = array();
				$element['childNodes'] = array();
				foreach ($elements as $element) {
						
					if ($element['parent_code'] == $parentId)
					{
						$children = $this->buildTree($elements, $element['code']);

						if ($children) 
							$element['childNodes'] = $children;						
						else
							$element['childNodes'] = NULL;

						$branch[$element['code']] = $element;
					}
				}

				return $branch;
			}


		
			
			function insertItem(){
			
				if($this->data_array['parent_code'] == '' || $this->data_array['parent_code'] == NULL)
					$this->data_array['parent_code'] = 0;
								
				$sql = "INSERT INTO wbs (code, parent_code, name, status) 
					VALUES ('".$this->data_array['code']."', 
					'".$this->data_array['parent_code']."', 					
					'".$this->data_array['name']."',
				
					'".$this->data_array['status']."')";
								
				
				if ($this->connect->query($sql))
					echo "Insert Successes";
				else
					echo $sql."<br/>".$this->connect->error;				
				
			
			}
			function updateItem()
			{
				$sql = "UPDATE wbs SET 				
				`parent_code` = '".$this->data_array['parent_code']."',				
				`name` = '".$this->data_array['name']."',
				`description` = '".$this->data_array['description']."',
				`status` = '".$this->data_array['status']."'
				WHERE `id` = ".$this->record_id."";	
				if ($this->connect->query($sql))
					echo "Update Successes";
				else
					echo $sql."<br/>".$this->connect->error;
			
				
			}
			function deleteItem()
			{
				
				$code = $this->data_array['code'];
				
				$sql = "SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''))";
				if($this->connect->query($sql))
				{
					$sql = "DELETE FROM wbs WHERE FIND_IN_SET(code, getTree($code)) > 0";
					if(!$this->connect->query($sql))					
						echo $sql."<br/>".$this->connect->error;
					else
						echo $sql;
				}
				else
					echo $sql."<br/>".$this->connect->error;
			} 
			
			function recordId()
			{
				$sql ="SELECT id FROM wbs ORDER BY id";
				$result = $this->connect->query($sql);
				if($result)
				{									
					return json_encode(array_map('idMap', $result->fetch_all()));					
				}
				else
					echo $sql."<br/>".$this->connect->error;

			}			
			
			function retrieveAll()
			{				
              
					$sql = "SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''))";
					if($this->connect->query($sql))
					{				

						$sql = "SELECT id, code, parent_code, name, description, status
						FROM wbs";						
						
						$result = $this->connect->query($sql);
						if($result)
						{
							$rows = array();
							while ($row = mysqli_fetch_assoc($result)) 
							{
								$rows[] = $row;
							}											
							return $rows;
						}	
						else
							echo $sql."<br/>".$this->connect->error;
					}
					else
							echo $sql."<br/>".$this->connect->error;
			}				

		}
		
		class gwbs_ {
			function __construct($connect, $inputs)
			{
				
				if(isset($inputs['query']))
				{
					$this->query = $inputs['query'];
					unset($inputs['query']);
				}
				if(isset($inputs['save']))
					unset($inputs['save']);
				if(isset($inputs['data']))
					unset($inputs['data']);
				if(isset($inputs['id']))
				{
					$this->record_id = $inputs['id'];
					unset($inputs['id']);
				}
				$this->data_array = $inputs;	
				if($this->data_array['parent_code'] == null || $this->data_array['parent_code'] == '')
					$this->data_array['parent_code'] = 0;		
							    
				$this->connect = $connect;

			}
			function insertItem()
			{			
						
				$sql = "LOCK TABLE gwbs WRITE, gwbs AS node READ, gwbs AS parent READ, gwbs AS sub_parent READ, gwbs AS parent_node READ, gwbs AS parents READ";
				if($this->connect->query($sql))
				{

					$sql = "SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''))";
					if($this->connect->query($sql))
					{
						$sql = "SELECT @prevRight := node.rgt, @ex := (COUNT(parent.name) - (sub_tree.depth + 1)) AS depth
							FROM gwbs AS node,
									gwbs AS parent,
									gwbs AS sub_parent,
									(
											SELECT parent_node.name, (COUNT(parents.name) - 1) AS depth
											FROM gwbs AS parent_node,
													gwbs AS parents
											WHERE parent_node.lft BETWEEN parents.lft AND parents.rgt
													AND parent_node.code = '".$this->data_array['parent_code']."'												
											
									) AS sub_tree
							WHERE node.lft BETWEEN parent.lft AND parent.rgt
									AND node.lft BETWEEN sub_parent.lft AND sub_parent.rgt
									AND sub_parent.name = sub_tree.name
								AND node.code < '".$this->data_array['code']."'
								GROUP BY node.code
								HAVING depth <= 1
								ORDER BY node.code DESC
								LIMIT 1";
						
						if($this->connect->query($sql))
						{						
							//if(@prevRight == null || @prevRight == '')
							//{
								//echo @prevRight;
							//}
							$sql = "UPDATE gwbs SET rgt = rgt + 2 WHERE rgt > @prevRight + @ex - 1";
							if($this->connect->query($sql))
							{
								$sql = "UPDATE gwbs SET lft = lft + 2 WHERE lft > @prevRight";
							
								if($this->connect->query($sql))
								{
									$sql = "INSERT INTO gwbs (code, name, lft, rgt, description, status) 
										VALUES('".$this->data_array['code']."', 
										'".$this->data_array['name']."',
										@prevRight + @ex, 
										@prevRight + @ex + 1, 
										'".$this->data_array['description']."',
										'".$this->data_array['status']."')";
										if($this->connect->query($sql))
										{
											$sql = "UNLOCK TABLES";
											$this->connect->query($sql);
										}
										else
											echo $sql."<br/>".$this->connect->error;
								}
								else
									echo $sql."<br/>".$this->connect->error; 
							}
							else
								echo $sql."<br/>".$this->connect->error;										
						}
						else
							echo $sql."<br/>".$this->connect->error;
					}
					else
						echo $sql."<br/>".$this->connect->error;
				}
				else
					echo $sql."<br/>".$this->connect->error;
			
					
					
								

			}
			function deleteItem()
			{
		
				$sql = "LOCK TABLE gwbs WRITE";
				if($this->connect->query($sql))
				{
					$sql = "SELECT @myLeft := lft, @myRight := rgt, @myWidth := rgt - lft + 1 FROM gwbs WHERE code = '".$this->data_array['code']."'";
					if($this->connect->query($sql))
					{
						$sql = "DELETE FROM gwbs WHERE lft BETWEEN @myLeft AND @myRight";
						if($this->connect->query($sql))
						{
							$sql = "UPDATE gwbs SET rgt = rgt - @myWidth WHERE rgt > @myRight";
							if($this->connect->query($sql))
							{
								$sql = "UPDATE gwbs SET lft = lft - @myWidth WHERE lft > @myRight";
								if($this->connect->query($sql))
								{
									$sql = "UNLOCK TABLES";	
									$this->connect->query($sql);
								}
								else
									echo $sql."<br/>".$this->connect->error;
							}
							else
								echo $sql."<br/>".$this->connect->error;
						}
						else
							echo $sql."<br/>".$this->connect->error;
					}
					else
						echo $sql."<br/>".$this->connect->error;

				}
				else
					echo $sql."<br/>".$this->connect->error;	

			}
			function UpdateItem()
			{
				
				
				$sql = "SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''))";
				if($this->connect->query($sql))
				{
					$sql ="SELECT code, (SELECT code 
						FROM gwbs t2 
						WHERE t2.lft < t1.lft AND t2.rgt > t1.rgt    
						ORDER BY t2.rgt-t1.rgt ASC
						LIMIT 1) 
					AS parent FROM gwbs t1
					WHERE code = '".$this->data_array['code']."' 
					ORDER BY (rgt-lft) DESC";
					$result = $this->connect->query($sql);
					if($result)
					{
						$row = $result->fetch_all()[0];
						$currCode = $row[0];
						$currParent = $row[1];
						
					}
						
					else
						echo $sql."<br/>".$this->connect->error;
				}
				else
					echo $sql."<br/>".$this->connect->error;


				if($this->data_array['parent_code'] == $currParent && $this->data_array['code'] == $currCode)
				{
					$sql = "UPDATE gwbs SET name = '".$this->data_array['name']."',
											description = '".$this->data_array['description']."',
											status = '".$this->data_array['status']."'   
							WHERE code = '".$this->data_array['code']."'";
					if(!$this->connect->query($sql))
						echo $sql."<br/>".$this->connect->error;


				}
				
				 

			}
			function retrieveAll()
			{
				$sql = "SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''))";




				$this->connect->query($sql);
				$sql = "SELECT node.id, node.lft, node.rgt, node.code, node.name, node.description, node.status, (COUNT( parent.name ) -1) AS depth FROM gwbs AS node
				CROSS JOIN gwbs AS parent
					WHERE node.lft BETWEEN parent.lft
						AND parent.rgt
				GROUP BY node.code
				ORDER BY node.lft";


				$result = $this->connect->query($sql);
				if($result)				
					return $result;
				else
					echo $sql."<br/>".$this->connect->error;	

			}
			function recordId()
			{
				$sql ="SELECT id FROM gwbs ORDER BY id";
				$result = $this->connect->query($sql);
				if($result)
				{									
					return json_encode(array_map('idMap', $result->fetch_all()));					
				}
				else
					echo $sql."<br/>".$this->connect->error;

			}
			function depth()
			{
				$sql = "SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''))";

				$sql ="SELECT node.name (COUNT(parent.name) - 1) AS depth
						FROM gwbs AS node,
								gwbs AS parent
						WHERE node.lft BETWEEN parent.lft AND parent.rgt AND node.code = 0
						GROUP BY node.name
						ORDER BY node.lft";
				return $this->connect->query($sql);
			}




		}
	
	
?>
