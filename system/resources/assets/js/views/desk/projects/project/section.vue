<template>
<div class="panel panel-flat">
    <div class="panel-heading">
         
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
        <router-view :sid="section_id"
                     :editMode="editMode" >
        </router-view>
    </div>
</div>  
</template>
<script>

import pwbsg    from './../../../elements/pwbsg';
import gwbs     from './../../../elements/gwbs';

export default {
    props: ['project_id'],  
    data() {
        return {            
             pid : this.project_id,  
             editMode: (localStorage.getItem('groupingedit') =="false"? false: true),        
             section_id : this.$route.params.sid,
             pwbs: [],
             gwbs: [],
             disabledcodes: [],     
             privatechosencodes: [],       
             removecodes: [],
             addcodes: [],       
             form: new Form({ 
                 id: null,               
                 section_id: this.$route.params.sid,
                 codes: []
             }),
             group: {
                 id: null,
                 name: null
             }

        }

    },

    created() {        
        this.getGroup(this.section_id);
        this.getPwbs(this.pid);
        this.getGwbs(this.section_id);
        this.getDisabledCodes(this.pid);     
        this.getPrivateChosenCodes(this.pid, this.section_id);

        var _this = this;
 
        bus.$on('addcode', function(e){ // Add wbs code to array
            
                _this.selectAddCodes(e);
        });

        bus.$on('deselectraddcode', function(e){ 
          _this.deselectAddCode(e);
        });
        bus.$on('selectremovecode', function(e){ // Add pwbs code to array
        
            _this.selectRemoveCode(e);
        });
        bus.$on('deselectremovecode', function(e){ // Remove pwbs code from array
          _this.deselectRemoveCode(e);
        });
        
  
        bus.$on('refreshPwbs', function(){
          _this.getPwbs(_this.pid);
        });
       
        
    },
    mounted() {
        var alterNavData = [
            { name: 'desk.project.section.packages',
              params: {
                  sid: this.$route.params.sid
              },
              icon: 'icon-cube3',
              display: 'Packages'  
            },

            { name: 'desk.project.section.gwbs',
              params: {
                  sid: this.$route.params.sid
              },
              icon: 'icon-tree5',
              display: 'Swbs'  
            }
        ]
        bus.$emit('alternav', alterNavData);
    },
    beforeDestroy() {
        bus.$emit('closealternav');
    },
    components: {      
        pwbsg,
        gwbs      
    },

    methods: {
        editToggle() {
            localStorage.setItem('groupingedit', this.editMode);
        },

   
        getGroup(sid) {
             axios.get('/api/projects/sections/'+sid)
                 .then(({data})=>{this.group = data})
                 .catch((error)=>{console.log(error)});
        },
        getPwbs(pid) {          
            axios.get('/api/projects/'+pid+'/pwbs') 
                 .then(({data})=>{this.pwbs = data})
                 .catch((error)=>{console.log(error)});
        },
        getGwbs(sid) {          
            axios.get('/api/projects/sections/'+sid+'/gwbs')
                 .then(({data})=>{this.gwbs = data})
                 .catch((error)=>{console.log(error)});
        },
        getDisabledCodes(pid) {
            axios.get('/api/projects/'+pid+'/gwbs')
                .then(({data})=>{this.disabledcodes = data})
                .catch((error)=>{console.log(error)});
        },
        getPrivateChosenCodes(pid, sid) {
             axios.get('/api/projects/'+pid+'/sections/'+sid)
                .then(({data})=>{this.privatechosencodes = data})
                .catch((error)=>{console.log(error)});

        },
        reset(e){        
            if(e == "gwbs") {  
                this.removecodes = [];             
                this.getGwbs(this.section_id);
            }
            if(e == "pwbs") {                    
                this.addcodes = []; 
                this.getDisabledCodes(this.pid);              
                this.getPrivateChosenCodes(this.pid, this.section_id);              
            }
        },
        selectAddCodes(e) {
        
            if(this.addcodes.indexOf(e) < 0)
                this.addcodes.push(e);       
        },
        deselectAddCode(e) {
            var index = this.addcodes.indexOf(e);       
            if(index >= 0)
                this.addcodes.splice(index, 1);     
        },
        selectRemoveCode(e) {
            if(this.removecodes.indexOf(e) < 0)
            this.removecodes.push(e);          
        },
        deselectRemoveCode(e) {
            var index = this.removecodes.indexOf(e);       
            if(index >= 0)
            this.removecodes.splice(index, 1);      
        },
        passGwbs() {        
            this.form.codes = this.addcodes;
            this.form.post('/api/projects/groups/'+this.section_id+'/gwbs/pass')
                    .then((data)=>{
                        this.reset('pwbs');
                        this.reset('gwbs')})
                    .catch((errors)=>{                     
                        console.log(errors) })
        },
        removeGwbs() {
          
            this.form.codes = this.removecodes;   
            this.form.post('/api/projects/groups/'+this.section_id+'/gwbs/delete')
                    .then(({data}) => {         
                         this.reset('pwbs'); 
                         this.reset('gwbs');
                    
                    })                 
                    .catch((errors) =>{
                        console.log(errors); })
                    
        },       

    }
}
</script>