
<div class="panel panel-default">
<div class="panel-heading">
	Global Work Break Down Structure
</div>
<div class="panel-body">						
	<div id="listDiv" style="height: 450px; overflow-y: auto">
		<?php							
			session_start();
			ob_start();
			error_reporting(E_ALL);
			ini_set('display_errors', 1);
			if(isset($_SESSION['valid']))
			{
				
				include_once('../process/_cschema-connect.php');
				include_once('../process/_functions.php');
				
				$globalWbs = new gwbs_($conn, NUll);
				
				$result = $globalWbs->retrieveAll();
				$idList = $globalWbs->recordId();

				$tree = array();
				while ($row = mysqli_fetch_assoc($result)) {
					$tree[] = $row;
				}
				
				// Bootstrap loop
				$result        = '';
				$currDepth     = 0; 
				$lastNodeIndex = count($tree) - 1;
				// Start the loop
				$target = 0;
				foreach ($tree as $index => $currNode) 
				{
					
					// Level down? (or the first)
					
					if ($currNode['depth'] > $currDepth || $index == 0) {
						$result .= '<ul id="'.$target.'" class="collapse in" >';
						;
					}
					// Level up?
					if ($currNode['depth'] < $currDepth) {
						$result .= str_repeat('</ul></li>', $currDepth - $currNode['depth']);
						
					}
					// Always open a node
				//$t = ($index == 0) ? 1 : 2;
					if($currNode['depth'] == '0')
					{
						//$parent_code = 0;
						$result .= '<li ><span data-toggle="collapse"  data-target = "#'.$currNode['code'].'"></span>';
						
						
					}
					else
					{
						$target = $currNode['code'];
						$result .= '<li><span data-toggle="collapse" 
											  data-target = "#'.$currNode['code'].'" class="index" 
											  data-id="'.$currNode['id'].'" 
											  data-code="'.$currNode['code'].'" 
											  data-description="'.$currNode['description'].'"
											  data-status="'.$currNode['status'].'">'.$currNode['code'].' - <span class="name">'. $currNode['name'].'</span></span>';
					// Check if there's chidren
					}
					if ($index != $lastNodeIndex && $tree[$index + 1]['depth'] <= $tree[$index]['depth']) {
						$result .= '</li>'; // If not, close the <li>
					}
					// Adjust current depth
					$currDepth = $currNode['depth'];
					// Are we finished?
					if ($index == $lastNodeIndex) {
						$result .= '</ul>' . str_repeat('</li></ul>', $currDepth);
					}
				}

				// Indent the code
				// For UTF8: tidy_parse_string($result, array('indent' => true, 'show-body-only' => true), 'UTF8')
				//$result = tidy_parse_string($result, array('indent' => true, 'show-body-only' => true), 'UTF8');
			
				print $result;
			



			}
		?>
			
	</div>

</div>


<script type="text/javascript">
$(document).ready(function(){  
	editMode('listDiv');
	//var rootUl = $('#listDiv').children('ul');
	//console.log($('#listDiv').children('ul'));
	//var divList = document.getElementById("listDiv");
	//var root = $(divList).children('ul');
	//$(root).attr('id', 'treeList');
	//console.log($(root).children('li'));
})

var id_json = <?php echo $idList ?>;
	


</script>
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
?>
<?php 
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

    SET rv = '';
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
        FROM wbs_global WHERE parent_id = front_id) A;

        IF LENGTH(queue_children) = 0 THEN
            IF LENGTH(queue) = 0 THEN
                SET queue_length = 0;
            END IF;
        ELSE
            IF LENGTH(rv) = 0 THEN
                SET rv = queue_children;
            ELSE
                SET rv = CONCAT(rv,',',queue_children);
            END IF;
            IF LENGTH(queue) = 0 THEN
                SET queue = queue_children;
            ELSE
                SET queue = CONCAT(queue,',',queue_children);
            END IF;
            SET queue_length = LENGTH(queue) - LENGTH(REPLACE(queue,',','')) + 1;
        END IF;
    END WHILE;

    RETURN rv;

END $$ 



*/?>