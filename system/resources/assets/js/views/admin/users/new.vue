<template>
<div class="content-wrapper">
    <!-- Page header -->
    <div class="page-header">
        <div class="page-header-content">
            <div class="page-title">
                <window-heading2></window-heading2>        
            </div>

            <div class="heading-elements">
                <div class="heading-btn-group" >
                   
                </div>
            </div>
        </div>

    
    </div>

    <div class="content">        
        <div class="panel panel-flat">
            <div class="panel-heading">                
                <div class="heading-elements">
                    <div class="heading-btn">
                        <div class="form-group">
                            
                        </div>
                    </div>
                </div>
            </div>                
            <div class="panel-body">
                <div class="col-md-12" v-if="editMode">
                    <form method="post" @submit.prevent="onSubmit" >                                   
                        
                            <div class="col-md-3 pl-5">
                                <div class="form-group">
                                    <label >First Name:</label>
                                    <input v-model="form.first_name"  type="text" placeholder="First name" class="form-control">
                                </div>
                            </div>

                            <div class="col-md-3"> 
                                <div class="form-group">
                                    <label >Last Name:</label>
                                    <input v-model="form.last_name"   type="text" placeholder="Last name" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-3"> 
                                <div class="form-group">
                                    <label >Nation:</label>
                                    <select v-model="form.nation_id"   type="text" placeholder="Nation" class="form-control">
                                        <option></option>                                    
                                        <option :value="nation.id" v-for="nation in nations" >{{nation.name}}</option>
                                    
                                    </select>
                                </div>
                            </div>
                            <div class="col-md-3"> 
                                <div class="form-group">
                                    <label >Email:</label>
                                    <input v-model="form.email"   type="text" placeholder="Email" class="form-control">
                                </div>
                            </div>          
                            
    
                            <div class="col-md-3 pl-5"> 
                                <div class="form-group">
                                    <label >Phone:</label>
                                    <input v-model="form.phone"   type="text" placeholder="phone" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-3"> 
                                <div class="form-group">
                                    <label >Organization:</label>
                                    <input v-model="form.organization"   type="text" placeholder="Orginization" class="form-control">
                                </div>
                            </div>
                            <div class="col-md-3">
                                <div class="form-group">
                                    <label>Status:</label> 
                                    <div class="input-group input-sm">
                                        <label class="radio-inline"><input type="radio"   value="1" v-model="form.status" checked>Active</label>
                                        <label class="radio-inline"><input type="radio"   value="0" v-model="form.status" >Deactive</label>
                                    </div>
                                </div>
                            </div>                       
                            <div class="col-md-12 pl-5">
                                <div class="form-group">
                                    
                                    <button type="submit" class="btn btn-primary">Save</button>
                                    <button @click.prevent="clearForm" slot="clearForm" class="btn btn-default ml-10">Clear</button>
                                    
                                    
                                </div>

                            </div>
                        
                    </form>
                </div>
        
            </div>        
        </div>
        <notify  :warns="$store.state.notifications" ></notify>
    </div>
</div>
</template>
<script>
import notify from './../../../core/Notify';
export default {
    props: ['user'],
    components: {
        notify
    },
    data() {
        return {
           
             nations: [],
             editMode: (localStorage.getItem('usersedit') =="false"? false: true), 
             form: new Form({
                    id: null,
                    first_name: null,
                    last_name: null,
                    nation_id: null,                
                    email: null,
                    phone: null,
                    organization: null,
                    status: null 
                }),          
        
        }

    },  

    created() {
         this.getNations();
    },   

    methods: {

      
        onSubmit() { 
            this.form.post('/api/admin/users')
                     .then(({data})=>{
                         notice(this.form.notifications, 6000);
                         this.form.reset();
                         this.$parent.$emit('refreshuser');
                        //  this.getUsers(this.pid)
                     })
                     .catch(({error})=>{
                        notice(this.form.notifications, 6000);  
                     })

        },

        clearForm() {
            this.form.reset();
        }, 

       
        getNations() {
            axios.get('/api/admin/nations')
                 .then((data)=>{this.nations = data.data })
        },    
        

    }


}
</script>


