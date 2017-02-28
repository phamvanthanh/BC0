<div class="panel panel-default">
<div class="panel-heading">
	Project records 
</div>
<div class="panel-body">						
	<div id="tableDiv" class="table-responsive" cellpadding="0" cellspacing="0">
		<?php							
			session_start();
			error_reporting(E_ALL);
			ini_set('display_errors', 1);
			if(isset($_SESSION['valid']))
			{
				
				include_once('../process/_cschema-connect.php');
				include_once('../process/_functions.php');
				//$project_data = fetchData($conn, "project");
				$lead_data = fetchData($conn, "lead");
				$industry_data = fetchData($conn, "industry");
				$project_data = fetchAllProject($conn);
				//json_encode($project_data);
				//var_dump($project);				
				
				echo "<table id=\"table\" class=\"table table-striped table-bordered table-condensed table-hover\">
							<thead>
								<tr class=\"info\">
									<th class=\"item_no\">No</th>
									<th class=\"item_code\">Code</th>
									<th class=\"item_name\">Name</th>
									<th class=\"item_desc\">Nation</th>
									<th class=\"item_desc\">Industry</th>
									<th class=\"item_desc\">Customer</th>
									<th class=\"item_desc\">Controller</th>
									<th class=\"item_desc\">Document</th>
									<th class=\"item_desc\">Confirm Date</th>
									<th class=\"item_desc\">Close Date</th>
									<th class=\"item_desc\">Summary</th>
									<th class=\"item_desc\">Status</th>
								</tr>
							</thead>
							<tbody>";

								for($i = 0; $i < sizeof($project_data); $i++)
								{
								echo "<tr> 
										<td>".($i+1)."</td>
										<td><span class=\"hidden\">".$project_data[$i][0]."</span><a class=\"edit-row\" href=\"#divdash=project_display&divlist=project_list&divform=project_form\" >".$project_data[$i][0]."</td>
										<td><span class=\"hidden\">".$project_data[$i][1]."</span>".$project_data[$i][1]."</td>
										<td><span class=\"hidden\">".$project_data[$i][2]."</span>".$project_data[$i][2]."</td>
										<td><span class=\"hidden\">".$project_data[$i][3]."</span>".$project_data[$i][4]."</td>
										<td><span class=\"hidden\">".$project_data[$i][5]."</span>".$project_data[$i][6]." ".$project_data[$i][7]."</td>
										<td><span class=\"hidden\">".$project_data[$i][8]."</span>".$project_data[$i][9]." ".$project_data[$i][10]."</td>
										<td><span class=\"hidden\">".$project_data[$i][12]."</span>".$project_data[$i][12]."</td>
										<td><span class=\"hidden\">".$project_data[$i][13]."</span>".$project_data[$i][13]."</td>
										<td><span class=\"hidden\">".$project_data[$i][14]."</span>".$project_data[$i][14]."</td>
										<td><span class=\"hidden\">".$project_data[$i][15]."</span>".$project_data[$i][15]."</td>
										<td><span class=\"hidden\">".$project_data[$i][16]."</span>".$status = ($project_data[$i][16]== 0)? 'Open': 'Closed' ."</td>
									 </tr>";								
								}
					echo "</tbody>
				</table>";		
				
			}
			else
			{
				$_SESSION['error'] = "project_display says: Session expired";
				header('Location: notice.php');
			}
			?>
			
	</div>
</div>
<script  type="text/javascript">
							
	var project_json = <?php echo json_encode($project_data); ?>//JSON_FORCE_OBJECT
	
	var name_json = project_json.map(mapName);
	var id_json = project_json.map(mapId);

	
</script>

