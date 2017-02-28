<script type="text/javascript" src="/js/jquery.min.js"></script>

<style>

.current
{
 color:red;
   
}
li {
cursor: pointer; 
}
</style>
<div id="test">
	<ul>    
	    <li class="current">menu item</li>  
	    <li>menu item</li>
	    <li>menu item</li>
	    <li>menu item</li>
	    <li>menu item</li>
	</ul>
</div>
<script type="text/javascript">
$(function(){    
   $("#test li").click(function(){
      //var item=$(this);
       $('ul li').removeClass('current');
       $(this).addClass("current")
    });
       
});

</script>


