  <table width="100%" cellpadding="2" cellpadding="10" >
        <tbody >
            <tr  >
                <td class="col-sm-10">               
                    <ul class="list-inline">
                        <li><a  href="/"><img src="/ico/logo-full-black.png" alt="QsCompanion" height="30px" /></a></li>
                        <li><a href="/portals/projects/index.php" id="menu-1">Projects</a></li>                            
                        <li><a href="/portals/projects/mylist.php" id="menu-2" >My project</a></li>                        
                    </ul>                    
                </td>
                <td class="col-sm-2">
                    <span class="pull-right" >
                        <?php
                            
                            if(isset($_SESSION["valid"])) 
                            {				
                                echo "<div class=\"dropdown\">
                                <a href=\"\" class=\"dropdown-toggle\"  data-toggle=\"dropdown\">".$_SESSION["username"]."<span class=\"caret\"></span></a>
                             
                                <ul class=\"dropdown-menu\">
                                    <li><a href=\"/portals/users/uprofile.php\">Profile</a></li>
                                    <li><a href=\"../process/_signout.php\">Sign out</a></li>
                                    
                                </ul>
                                </div>";

                              
                            }
                            else
                                echo "<a href=\"/login.php\">Sign in</a>";
                        
                        ?>
                    </span>
                </td>
                
            </tr>
          
        </tbody>
    </table> 
