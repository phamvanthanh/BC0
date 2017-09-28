<template>				
        <div v-show="editMode" id="pwbs-edit" class="bootstrap-duallistbox-container row" >
            <div  class="col-md-6" v-if="isShowWbs">
                <div :class="{loader:wbsLoading}"></div>
                <div :class="{hidden:wbsLoading}" class="row ml-0 mr-0 display-flex">
                     <input @keyup="wbsSearch"  class="tree-search" placeholder="Search for wbs..." >             									
                    <button @click='reset("wbs")' type="button" class="btn  btn-default w-60"> 
                    <i class="icon-reset"></i>
                    </button>
                    <button @click="passPwbs" type="button" class="btn btn-primary w-60"> 
                    <i class="icon-circle-right2"></i>
                    </button>
                </div>
                <div :class="{hidden:wbsLoading}" class="box tree-default well border-left-info border-left-lg">
                    <ul id="wbs-ul"  class="ui-wbstree wbstree-container wbstree-plain">							
                        <wbs		
                            :node="wbs"
                            :addcodes="addcodes"
                            :disabledcodes="disabledcodes"
                            :filterString="wbsFilterString">									
                        </wbs>
                    </ul>
                </div>
            </div>
            <div v-bind:class="{'col-md-6': isShowWbs, 'col-md-12': !isShowWbs}">
                <div :class="{loader:pwbsLoading}"></div>
                <div :class="{hidden:pwbsLoading}" class="row mr-0 ml-0 display-flex">
                     <button  @click="removePwbs" type="button" class="btn btn-warning w-60">
                        <i class="icon-circle-left2"></i>
                    </button>               
                    <button @click='reset("pwbs")' type="button" class="btn btn-default w-60"> 
                        <i class="icon-reset"></i>
                    </button>              
                    <input  @keyup="pwbsSearch" placeholder="Search for pwbs..." class="tree-search" > 
                </div>								
                <div :class="{hidden:pwbsLoading}" class="box tree-default well border-left-info border-left-lg">
                    <ul id="pwbs-edit-ul" class="ui-wbstree wbstree-container wbstree-plain" >							
                        <epwbs 
                            class="pwbs"
                            :node="pwbs"
                            :removecodes="removecodes"
                            :editMode="editMode"
                            :isNewEntry="isNewEntry"
                            :jobableId="info.jobable_id"
                            :filterString="pwbsFilterString" >
                        </epwbs>
                    </ul>
                </div>
            </div>
        
        </div>				
  
	</div>	

</template>
<script>


import wbs from './../../elements/wbs';
import epwbs from './../../elements/epwbs';

export default {
   
    data() {
        return {
            pwbsLoading: true,
            wbsLoading: true,
            wbsFilterString: '',
            pwbsFilterString: '',
            disabledcodes: [],            
            removecodes: [],
            addcodes: [],
            pwbs: [],
            wbs:[],
            isNewEntry: false,
            form: new Form({
              project_id: this.pid,
              codes: null
            }),
            filterlist: [],  
            
        }
    },
    props: {
        info: {},
        editMode: false,
        isShowWbs: false
    },
    created() {
        
        this.getPwbs(this.info.jobable_id);
        this.getWbs();

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
        bus.$on('newentry', function(e){
          _this.isNewEntry = e;
        });
        bus.$on('refreshPwbs', function(){
          _this.getPwbs(_this.info.jobable_id);
        })

    },
    mounted: function(){
        var _this = this;
        bus.$on('disabledcode', function(e){
          _this.disabledcodes.push(e);
          if(_this.disabledcodes.indexOf(0) < 0)
            _this.disabledcodes.unshift(0); 
        })
    },
 
    components: {
        wbs: wbs,
        epwbs
    },
    methods: {
 
      getPwbs: function(id) {
        axios.get('/api/projects/'+id+'/pwbs')
            .then(({data})=>{
                this.pwbs = data;
                this.pwbsLoading = false;
            });
      },    
      getWbs: function() {
        axios.get('/api/desk/wbs')
            .then(({data})=>{
                this.wbs = data;
                 this.wbsLoading = false;
            });
      },  
      reset: function(e){    
        
        if(e == "pwbs"){
          this.getPwbs(this.info.jobable_id);
          this.removecodes = [];          
        }
        if(e == "wbs"){
         // this.getWbs();
          this.addcodes = [];
        }
      },
     
      selectAddCodes: function(e) {
          if(this.addcodes.indexOf(e) < 0)
            this.addcodes.push(e);       
      },
      deselectAddCode: function(e) {
         var index = this.addcodes.indexOf(e);       
         if(index >= 0)
         this.addcodes.splice(index, 1);     
      },
      selectRemoveCode: function(e) {
         if(this.removecodes.indexOf(e) < 0)
          this.removecodes.push(e);          
      },
      deselectRemoveCode: function(e) {
         var index = this.removecodes.indexOf(e);       
         if(index >= 0)
          this.removecodes.splice(index, 1);      
      },
      passPwbs: function(){
       
          this.form.codes = this.addcodes;

          this.form.post('/api/projects/'+this.info.jobable_id+'/pwbs/pass')
                   .then((data)=>{
                     this.reset('wbs');
                     this.reset('pwbs')})
                   .catch((errors)=>{                     
                     console.log(errors) })
      },
      removePwbs: function(){
         this.form.codes = this.removecodes;   
         this.form.post('/api/projects/'+this.info.jobable_id+'/pwbs/delete')
                  .then(({data}) => {         
                    this.getPwbs(this.info.jobable_id);           
                    var i, index;       
                    for(i=0; i < this.removecodes.length; i++) {                      
                      index = this.disabledcodes.indexOf(this.removecodes[i]);
                      if( index >= 0)
                        this.disabledcodes.splice(index, 1);                     
                    }
                    this.removecodes = [];
                   })                 
                  .catch((errors) =>{
                    console.log(errors); })
                 
      },
      wbsSearch(event) {
          this.wbsFilterString = event.target.value;
      },
      pwbsSearch(event) {
          this.pwbsFilterString = event.target.value;
      }    
    }
}

  

</script>


