<div class="panel panel-info" >
	
	<div class="panel-heading" >
		<span class="tree-title" >Heirarchy</span>
		<span class="search-input" ><input type="text" id="searchInput"  onkeyup="listSearch()" placeholder="Search.." title="Type in a name"></span>
		<span id="tree-nav" class="commands" >
			<span><a class="tree"  data-target=".sec" >Industry > </a>
				<span >
					<span><a class="tree"  data-target=".act" >Section > </a>								
						<span  >
							<span><a class="tree"  data-target=".mat" >Activity > </a>
								<span>
									<span><a class="tree">Material</a></span>
								</span>								
							</span>								
						</span>							
					</span>						
				</span>
			</span>				
		</span>		
	</div>
	<div id="list" class="panel-body">		
		<div id="priTableDiv" class="table-responsive">
			<?php
				session_start();
				error_reporting(E_ALL);
				ini_set('display_errors', 1);
				
				if(isset($_SESSION['valid']))
				{
					include_once('../process/_cschema-connect.php');
					include_once('../process/_functions.php');
					$industry_data = fetchData($conn, "industry");
					$section_data = fetchData($conn, "section");
					$activity_data = fetchData($conn, "activity");
					$material_data = fetchData($conn, "material");
					$industry_section_data = fetchData($conn, "industry_section");
					$section_activity_data = fetchData($conn, "section_activity");
					$activity_material_data = fetchData($conn, "activity_material");
					
					//var_dump($industry_section_data);
					echo "<ul id=\"treeList\">";
						for($i = 0; $i < sizeof($industry_data); $i++)
						{
							
							echo "<li class=\"ind\" >";
								echo "<a class=\"index\" data-toggle=\"collapse\" data-target=\"#ind$i\" ><span class=\"id\">".$industry_data[$i][0]."</span>"." - "."<span class=\"name\">".$industry_data[$i][1]."</span><span class=\"desc hidden\">".$industry_data[$i][2]."</span></a>";
								
								$data = displayData($section_data, $industry_section_data, $industry_data[$i][0]);
								echo "<ul id=\"ind$i\" class=\"collapse in\" >";
									for($j = 0; $j <sizeof($data); $j++ )
									{
										echo "<li class=\"sec\" >";
											echo "<a class=\"index\" data-toggle=\"collapse\" data-target=\"#sec$i$j\" ><span class=\"id\">".$data[$j][0]."</span>"." - "."<span class=\"name\">".$data[$j][1]."</span><span class=\"desc hidden\">".$section_data[$j][2]."</span></a>";
											$data1 = displayData($activity_data, $section_activity_data, $data[$j][0]);								
											echo "<ul id=\"sec$i$j\" class=\"collapse in\" >";
													for($k = 0; $k < sizeof($data1); $k++)
													{
														echo "<li class=\"act\" >
															     <a class=\"index\" data-toggle=\"collapse\" data-target=\"#act$i$j$k\" ><span class=\"id\">".$data1[$k][0]."</span>"." - "."<span class=\"name\">".$data1[$k][1]."</span><span class=\"desc hidden\">".$activity_data[$k][2]."</span></a>";
																  $data2 = displayData($material_data, $activity_material_data, $data1[$k][0]);	
																	echo "<ul id=\"act$i$j$k\" class=\"collapse in\" >";
																			for($l = 0; $l < sizeof($data2); $l++)
																			{
																				echo "<li class=\"mat\" >
																						<span class=\"id\">".$data2[$l][0]."</span>"." - "."<span class=\"name\">".$data2[$l][1]."</span><span class=\"desc hidden\">".$material_data[$l][2]."</span>
																					</li>";				  

																			}
																     echo "</ul>";		
																	

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
	</div>
	
</div>
