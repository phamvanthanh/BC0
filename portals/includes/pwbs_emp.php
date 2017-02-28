<label  for="project_employee">Employee:</label>									
<select  id="project_employee" name="project_employee" style="width: 70%; height: 22px" >						
        <option></option>
        <?php 																	
            session_start();
            error_reporting(E_ALL);
            ini_set('display_errors', 1);
            include_once('../process/_cschema-connect.php');
            $projectId = $_SESSION['projectId'];
            $sql = "SELECT ep.employeeId, u.firstName, u.lastName, u.email 
            FROM emp_project as ep
            INNER JOIN user as u ON ep.employeeId = u.id 
            WHERE ep.projectId = $projectId
            ORDER BY ep.employeeId";
            $result = $conn->query($sql);
            if($result->num_rows > 0)
            {									
                while($row = $result->fetch_assoc())
                {												
                    echo "<option value=".$row['employeeId'].">".$row['firstName']." ".$row['lastName']." | ".$row['email']."</option>";												
                }					
            }							
        ?>				
</select>
        <input class="hidden" name = "data" value="pwbs_employee" >

<script>
var projectEmployeeId = <?php echo json_encode($_SESSION['employeeId']) ; ?>; 

if(typeof(projectEmployeeId) != 'undefined' && projectEmployeeId!= '' && projectEmployeeId != null )
{
    $('select[name*="project_employee"]').children("option[value='" + projectEmployeeId + "']").prop("selected", true);		 

}
</script>