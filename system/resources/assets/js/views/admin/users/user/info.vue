<template>
  <div class="panel panel-flat">
            <div class="panel-heading">                
                <div class="heading-elements">
                    <div class="heading-btn">
                        <div class="form-group">
                            <div class="switch-box">												  
                                <label class="switch ">	
                                    <span class="switch-label">Edit</span>																										
                                    <input v-model="editMode" @click="editToggle" type="checkbox" name="editMode" >                                    
                                    <div class="slider"></div>
                                </label>
                            </div>
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
                                   
                                    
                                </div>

                            </div>
                          
                    </form>
                </div>
          
            </div>        
        </div>
</template>
<script>

export default {
    props: ['user'],
    data() {
        return {
           
             nations: [],
             editMode: (localStorage.getItem('usersedit') =="false"? false: true),        
            
        
        }

    },
    computed: {
        form: {
            get() {
                if(this.user)
                    return new Form({
                    id: this.user.id,
                    first_name: this.user.first_name,
                    last_name: this.user.last_name,
                    nation_id: this.user.nation_id,                
                    email: this.user.email,
                    phone: this.user.phone,
                    organization: this.user.organization,
                    status: this.user.status                
                    
                });
             
            },
            set(neVal) {

            }
        }
    },
   
    created() {                

        var _this = this;   

        bus.$on('edituser', function(e){                    
           
        })
    },
    created() {
         this.getNations();
    },   

    methods: {

        editToggle() {
            localStorage.setItem('usersedit', this.editMode);
        },

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
