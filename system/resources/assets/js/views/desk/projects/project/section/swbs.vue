<template>

<div  id="pwbs-edit" class="bootstrap-duallistbox-container row" >
    <div  class="col-md-6" v-show="editMode" >
        <div class="row ml-0 mr-0 display-flex">
            
                <input @keyup="pwbsSearch"  class="tree-search" placeholder="Search for pwbs..." >   	
           
                <button @click="reset('pwbs')" type="button" class="btn  btn-default w-60"> 
                    <i class="icon-reset"></i>
                </button>
           
          
                <button @click="passGwbs" type="button" class="btn btn-primary w-60"> 
                    <i class="icon-circle-right2"></i>
                </button>
            
        </div>
        <div class="box tree-default well border-left-info border-left-lg">
            <ul id="wbs-ul"  class="ui-wbstree wbstree-container wbstree-plain">							
                <pwbsg										
                    :node.sync="pwbs"
                    :addcodes="addcodes"
                    :disabledcodes="disabledcodes" 
                    :privatechosencodes="privatechosencodes"
                    :filterString = "pwbsFilterString" >
                </pwbsg>
            </ul>
        </div>
    </div>						

    <div  :class="[editMode? 'col-md-6': 'col-md-12']">
        <div  v-if="editMode" >
              <div class="row ml-0 mr-0 display-flex">
                <button  @click="removeGwbs" type="button" class="btn btn-warning w-60">
                    <i class="icon-circle-left2"></i>
                </button>               
                <button @click="reset('gwbs')"  type="button" class="btn  btn-default w-60"> 
                    <i class="icon-reset"></i>
                </button>    
        
                <input @keyup="swbsSearch"  class="tree-search" placeholder="Search for swbs..." >             									
								
            </div>
        </div>								
        <div :class="[editMode? 'well': '',  'box tree-default border-left-info border-left-lg']">
            <ul id="pwbs-edit-ul" class="ui-wbstree wbstree-container wbstree-plain" >
                <gwbs										
                    :node="gwbs"                                        
                    :removecodes="removecodes" 
                    :filterString = "swbsFilterString" >
                </gwbs>							
                
            </ul>
        </div>
    </div>						
</div>

</template>
<script>

import pwbsg    from './../../../../elements/pwbsg';
import gwbs     from './../../../../elements/gwbs';

export default {  
    data() {
        return {

             pid : this.$route.params.pid,           
             section_id : this.$route.params.sid,
             pwbs: [],
             gwbs: [],
             disabledcodes: [],     
             privatechosencodes: [],       
             removecodes: [],
             addcodes: [],       
             form: new Form({ // Grouping form
                 id: null,               
                 section_id: this.$route.params.sid,
                 codes: []
             }),
             group: {
                 id: null,
                 name: null
             },
             pwbsFilterString: '',
             swbsFilterString: '',
             filterlist: []           

        }
    },
    props: {
        editMode: false
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
    computed: {
        notifications() {
            return this.$store.state.notifications
        },        
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
            this.form.post('/api/projects/sections/'+this.section_id+'/gwbs/pass')
                    .then((data)=>{
                        this.reset('pwbs');
                        this.reset('gwbs')})
                    .catch((errors)=>{                     
                        console.log(errors) })
        },
        removeGwbs() {
          
            this.form.codes = this.removecodes;   
            this.form.post('/api/projects/sections/'+this.section_id+'/gwbs/delete')
                    .then(({data}) => {         

                         this.reset('pwbs'); 
                         this.reset('gwbs');
                    
                    })                 
                    .catch((errors) =>{
                        console.log(errors); })
                    
        },      

        pwbsSearch(event) {
            this.pwbsFilterString = event.target.value;
        },
        swbsSearch(event) {
            this.swbsFilterString = event.target.value;
        }, 

    }

}
</script>