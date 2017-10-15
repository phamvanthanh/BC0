<template>
  <div class="wrapper">
	  <navbar >	
			
	  </navbar>
	  <sidebar ></sidebar>
	  <maincontent  >
		  <vs-crumbs slot="crumbs" ></vs-crumbs>		
	  </maincontent>
  </div>
</template>

<script>
import navbar from './navbar';
import sidebar from './sidebar';
import maincontent from './content';
require ('./breadcrumbs.vue')

export default {
	data() {
		return {
			accessLogged: false
		}
		
	},
	components: {
		navbar,
		sidebar,
		maincontent
	},

	


  
 

}
</script>





