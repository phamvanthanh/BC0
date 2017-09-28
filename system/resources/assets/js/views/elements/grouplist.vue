<template>
<div class="panel panel-flat">
    <div class="panel-heading">
        <h6 class="panel-title">Groups</h6>
        <div class="heading-elements">
            <div class="heading-btn">
                <div class="form-group">
                    <div class="switch-box">												  
                        <label class="switch ">	
                            <span class="switch-label">Edit</span>																										
                            <input v-model="editMode" @click="editToggle"type="checkbox" name="edit" >
                            
                            <div class="slider"></div>
                        </label>
                    </div>
                </div>
            </div>
        </div>
    </div>          
    <div class="panel-body">
        <div class="row" v-if="editMode">
            <form @submit.prevent="onSubmit" method="post" >            
                <div class="col-sm-3">
                    <div class="form-group">
                        <label>Nam: <span class="text-danger">*</span></label>
                        <input v-model="form.name" class="form-control required">
                    </div>
                </div>
                <div class="col-sm-8">
                    <div class="form-group">
                        <label>Brief:</label>
                        <input v-model="form.description" class="form-control">
                    </div>
                </div>
                <div class="col-sm-1">
                    <div class="form-group">
                        <label class="transparent" >*</label>
                        <button type="submit" class="btn btn-default form-control">Save</button>
                    </div>
                </div>
            </form>
        </div>
        <div class="table-responsive"> 
            <table class="table">
                <tbody>
                    <tr is="grouprow"  
                        v-for="group in groups"
                        v-bind:key="group.id" 
                        :group ="group"
                        :editMode="editMode">                                                
                    </tr>
                </tbody>
            </table>            
        </div>
    </div>
</div>

</template>
<script>
import grouprow from './../elements/grouprow';
export default {  
    data() {
        return {  
             editMode: (localStorage.getItem('groupsedit') =="false"? false: true),  
             pid: this.$route.params.pid,
             form: new Form({ // New group form
                 id: null,
                 project_id: this.$route.params.pid,
                 name: null,
                 description: null,                 
             }),
             groups: [],        
             activeGroup: null,
        }
    },

    created() { 
       

          
        this.getGroups(this.pid);  
        var _this = this;     
        bus.$on('refreshgroups', function(){
            _this.getGroups(_this.pid);
        });
        bus.$on('editgroup', function(e){
            for(let property in e){
                _this.form[property] = e[property];
            }
        });       
       
    },
    computed: {
        notifications() {
            return this.$store.state.notifications
        },
        
    },
    components: {    
        grouprow,     
    },
    methods: {
        editToggle() {
            localStorage.setItem('groupsedit', this.editMode);
        },
        onSubmit() { 
            this.form.post('/projects/'+this.pid+'/groups')
                     .then(({data})=>{
                         this.formNotify();
                         this.getGroups(this.pid)})
                     .catch(({error})=>{
                         this.formNotify();})

        },
        getGroups(pid) {
            axios.get('/projects/'+pid+'/groups')
                 .then((data)=>{this.groups = data.data })
        }, 
        formNotify() {
            this.$store.commit('loadNotifications', this.form.notifications)
            
        },
       

   
    }
}
</script>
