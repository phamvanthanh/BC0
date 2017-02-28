<div class="panel panel-default">
<div class="panel-heading">
	Activity records
</div>
<div class="panel-body">						
	<div id="tableDiv" class="table-responsive">
		<?php							
			session_start();
			error_reporting(E_ALL);
			ini_set('display_errors', 1);
			if(isset($_SESSION['valid']))
			{
				
				include_once('../process/_cschema-connect.php');
				include_once('../process/_functions.php');
				$activity_data = fetchData2($conn, "activity", "section_activity");
							
				echo "<table id=\"table\" class=\"table table-striped table-bordered table-condensed table-hover\">
							<tr class=\"info\">
								<th class=\"item_no\">No</th><th class=\"item_code\">Code</th><th class=\"item_name\">Name</th><th class=\"item_desc\">Description</th>
							</tr>
							<tbody>";

								for($i = 0; $i < sizeof($activity_data); $i++)
								{
								echo "<tr> 
										<td>".$i."</td>
										<td><span class=\"hidden\">".$activity_data[$i][0]."</span><a class=\"edit-row\" href=\"#divdash=activity_display&divlist=activity_list&divform=activity_form\" >".$activity_data[$i][0]."</td>
										<td><span class=\"hidden\">".$activity_data[$i][1]."</span>".$activity_data[$i][1]."</td>
										<td class=\"hidden\" ><span class=\"hidden\">".$activity_data[$i][3]."</span></td>
										<td><span class=\"hidden\">".$activity_data[$i][2]."</span>".$activity_data[$i][2]."</td>
										
										</tr>";						
								
								}
					echo "</tbody>
				</table>";		
				
			}
			else
			{
				$_SESSION['error'] = "industry_display says: Session expired";
				header('Location: notice.php');
			}
			?>
			
	</div>
</div>
<script  type="text/javascript">
							
	var activity_json = <?php echo json_encode($activity_data); 	?>//JSON_FORCE_OBJECT
	
	var id_json = activity_json.map(mapId);
	var name_json = activity_json.map(mapName);

	
</script>
