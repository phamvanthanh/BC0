<template>
    <div class="panel panel-flat" id="project_treemap" >       
		<tree
			v-if="localdata"
			:data="localdata"
			title="Project Job Map"
			:width="width"
			height="500"
		>
		</tree>
	</div>
</template>
<script>

import tree from '../../../charts/horizontaltree';

export default {
	props: ['project_id', 'job'],
	data() {
		return {
			localdata: null,
			loading: true,
			width: 0
			
		}
	},
	created() {
		this.getSections(this.project_id);
	},
	mounted() {
		this.width = document.getElementById('project_treemap').offsetWidth - 100;
	},

	components: {
		tree
	},

	methods: {
		     getSections(pid) {
            axios.get('/api/projects/'+pid+'/sections')
                 .then(({data})=>{
					 var sections = data.map(function(e) {
						var packages = e.packages.map(function(d) {
							return {
								name: d.name,
								id: d.job.id,
								status: d.job.status,
								children: null
							}
						});

						return { name: e.name,
							id: e.job.id,
							status: e.job.status,
							children: packages 
						}
					 });

                     this.localdata = {
						 name: this.job.jobable.name,
						 id: this.job.id,
						 status: this.job.status,
						 children: sections
					 } 
                      
                })
        }, 
    
	}
}

</script>
