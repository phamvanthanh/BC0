
<div class="panel panel-default" id="sform" >
	
	<div class="panel-heading" >
		<form class="form-inline" action="" method="post" >	
				<span >Work Breakdown Structure</span>
				<span>					
						<select  name="project" class="smallInput" >						
								<option></option>
								<?php 																	
									include_once('../process/_cschema-connect.php');
									$sql = "SELECT id, name FROM project WHERE status = 0";
									$result = $conn->query($sql);
									if($result->num_rows > 0)
									{									
										while($row = $result->fetch_assoc())
										{												
											echo "<option value=".$row['id'].">".$row['name']."</option>";												
										}					
									}							
								?>				
						</select>
				</span>
				<span>							
						<input class="btn btn-default btn-xs smallInput"  type="button" name="add" value="Add Items">							
				</span>
				<span>
						<input class="btn btn-default btn-xs smallInput"  type="button" name="remove" value="Remove Items">			
				</span>
				
			</form>
					
	</div>
	<div id="list" class="panel-body">	
		
		<div id="priTableDiv" class="table-responsive col-sm-6">
		<span>Select items to add to the project.</span>
			<?php
				session_start();
				error_reporting(E_ALL);
				ini_set('display_errors', 1);
				
				if(isset($_SESSION['valid']))
				{
					include_once('../process/_cschema-connect.php');
					include_once('../process/_functions.php');
				
					$section_data = fetchData($conn, "section");
					$activity_data = fetchData($conn, "activity");
					$material_data = fetchData($conn, "material");
			
					$section_activity_data = fetchData($conn, "section_activity");
					$activity_material_data = fetchData($conn, "activity_material");
					
					
					echo "<ul id=\"treeList\" >";
						for($i = 0; $i < sizeof($section_data); $i++)
						{
							
							echo "<li id=".$section_data[$i][0]." class=\"sec\" >";
								echo "<span class=\"record\" data-type=\"section\" ><span class=\"id\">".$section_data[$i][0]."</span>"." - "."<span class=\"name\">".$section_data[$i][1]."</span></span>";
								
								$data = displayData($activity_data, $section_activity_data, $section_data[$i][0]);
								echo "<ul id=\"sec$i\" class=\"collapse in\" >";
									for($j = 0; $j <sizeof($data); $j++ )
									{
										echo "<li id=".$activity_data[$i][0]." class=\"act\" >";
											echo "<span class=\"record\" data-type=\"activity\"  ><span class=\"id\">".$data[$j][0]."</span>"." - "."<span class=\"name\">".$data[$j][1]."</span></span>";
											$data1 = displayData($material_data, $activity_material_data, $data[$j][0]);								
											echo "<ul id=\"act$i$j\" class=\"collapse in\" >";
													for($k = 0; $k < sizeof($data1); $k++)
													{
														echo "<li id=".$material_data[$k][0]." class=\"mat\" >
															     <span class=\"record\" data-type=\"material\"  ><span class=\"id\">".$data1[$k][0]."</span>"." - "."<span class=\"name\">".$data1[$k][1]."</span></span>";
																  
														echo "</li>";
													}
											echo "</ul>";

										echo "</li>";
									}
								echo "</ul>";
							echo "</li>";
						}
					echo "</ul>";
					
					
				}
				else
				{					
					$_SESSION['error'] = "industry_display says: Session expired";
					header('Location: ../notice.php');
				}
					

			?>
		</div>
		<div id="pwbs" class="col-sm-6">
					
						

		</div>
		
	
	</div>



  <script>
  
  // $('#priTableDiv').jstree();
  /*
  $(function () {
    // 6 create an instance when the DOM is ready
   
    // 7 bind to events triggered on the tree
	obj = [];
	
    $('#priTableDiv').on('changed.jstree', function (e, data) {
		console.log();
		//console.log(e.text());
		var i, j, r = [], x;
		for(i = 0, j = data.selected.length; i < j; i++) {
			r.push(data.instance.get_node(data.selected[i]));
			x = data.instance.get_node(data.selected[i]);
			console.log(x);
			
		}
		obj.push({'id': $(r).children('span.id').text(),
				  'name': $(r).children('span.name').text()});
		 console.log(obj);
		$('#event_result').html('Selected: ' + r.join(', '));	
  	}).jstree();
   
	// $('#jstree').jstree();
	 $('#jstree').jstree({ 'core' : {
		'data' : [
			{ "id" : "ajson1", "parent" : "#", "text" : "Simple root node" },
			{ "id" : "ajson2", "parent" : "#", "text" : "Root node 2" },
			{ "id" : "ajson3", "parent" : "ajson2", "text" : "Child 1" },
			{ "id" : "ajson4", "parent" : "ajson2", "text" : "Child 2" },
		]
	} }).on('changed.jstree', function (e, data) {
		var i, j, r = [];
		for(i = 0, j = data.selected.length; i < j; i++) {
		r.push(data.instance.get_node(data.selected[i]).text);
		}
		$('#event_result').html('Selected: ' + r.join(', '));	
  	}).jstree();
	;
    // 7 bind to events triggered on the tree
    $('#jstree').on("changed.jstree", function (e, data) {
      	console.log(data.selected);
    	});

  	});
	  */


	 var selectedProjectId = <?php echo $_SESSION['projectId'] ; ?>; 
	 if(typeof(selectedProjectId) != 'undefined' && selectedProjectId!= '' && selectedProjectId != null )
	 {
		 $('select[name*="project"]').children("option[value='" + selectedProjectId + "']").prop("selected", true);
		 load("#pwbs", 'pwbs');

	 }
       
  </script>