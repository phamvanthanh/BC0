<template>
<div>
    <div class="col-md-4" >
        <div class="panel panel-flat">
            <div class="panel-heading">
                
                <div class="heading-elements">
                    
                </div>
            </div>
            
            <div class="panel-body">
                1. Issues <br>
                2. Number of projects, finished <br>
                3. 
            </div>
        </div>
    </div>
</div>
</template>
<script>

export default {
    
    created() {
        this.getProjects(this.$store.state.user.id)
    }, 

    methods: {
        getProjects(uid) {
            axios.get('api/widgets/clients/'+uid+'/projects')
                 .then(({data})=>{
                     console.log(data);
                 })
        }
    }
}

</script>

