

<div class="panel panel-default">
<div class="panel-heading">
	Global Work Break Down Structure
</div>
<div class="panel-body">						
	<div id="listDiv" >
		<?php							
			session_start();
			error_reporting(E_ALL);
			ini_set('display_errors', 1);
			if(isset($_SESSION['valid']))
			{
				
				include_once('../process/_cschema-connect.php');
				include_once('../process/_functions.php');
								;
				$globalWbs = new wbsItem_($conn, NUll);
				
				//$gwbs = $globalWbs->retrieveAll();
				$result = array();
				$result = $globalWbs->retrieveAll();
				$idList = $globalWbs->recordId();		
				 
				$gwbs = array();
				if($result)					
				    $gwbs = $globalWbs->buildTree($result);
			
				
				function traverseTree($list, $id)
				{
					if(count($list)>0)
					{
						echo "<ul id=\"".$id."\" class=\"collapse in\">";
						foreach($list as $row)
						{
							echo"<li><span 
                            class=\"index\"
								  data-toggle=\"collapse\" 
								  data-target=\"#". $row['code']."\"
								  data-id =".$row['id']."
								  data-code=".$row['code']." 
								  data-parent=".$row['parent_code']."
								  data-status=".$row['status']."
								  

                            ><span class=\"id\">".$row['code']." - </span><span class=\"name\">".$row['name']."</span><span class=\"desc hidden\">".$row['description']."</span></span></li>";
							if(count($row['childNodes']) > 0)
							    traverseTree($row['childNodes'], $row['code']);
						}
						echo "</ul>";
					}


				}

				traverseTree($gwbs, NULL);
			}
			
		?>
			
	</div>

</div>


<script type="text/javascript">
$(document).ready(function(){  
	editMode('listDiv');
})

var id_json = <?php echo $idList ?>;

//var x= JSON.parse(idString);
//var id_json = JSON.parse(idString);
//console.log(id_json);

	


</script>