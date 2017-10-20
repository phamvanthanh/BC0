<template>
<div class="content-wrapper">
  <div class="page-header">
      <div class="page-header-content">
          <div class="page-title">
              <page-label></page-label>
          </div>
          <div class="heading-elements">
          
          </div>
      </div>   
  </div>

  <div class="content">
    <i :class="{loader:loading}"></i>    
    <div :class="{hidden:loading}" class="panel panel-flat">
      <div class="panel-heading">  
        <input id="wbs-search"  placeholder="Search..." @keyup="search" >   				
        <div class="heading-elements">          
          <div class="heading-btn">
            <div class="form-group">             
                <div class="switch-box">												  
                    <label class="switch ">	
                        <span class="switch-label">Edit</span>																										
                        <input v-model="editMode" @click="toggleEditMode" type="checkbox"  >
                        
                        <div class="slider"></div>
                    </label>
                </div>             
            </div>								
          </div>
          
        </div>					
      </div>
    
      <div class="panel-body" >                 
          <div class="tree-default">
            <ul id="wbs-ul"  class="ui-wbstree">							
              <wbs		
                :node="wbs"
                :editMode="editMode"
                :isNewEntry="isNewEntry" 
                :filterString="filterString">									
              </wbs>               
            </ul>
          </div>			
      </div>  
    </div>
    <notify :warns="$store.state.notifications"></notify>
  </div>
</div>  
</template>
<script>
import notify from './../../../core/Notify';
import wbs from './wbsnode';

export default {
 
    data() {
        return {
            loading: true,
            filterInput: '',
            filterString: '',
            editMode: (localStorage.getItem('wbseditmode') == "false"? false: true) ,
            wbs:[],
            isNewEntry: false,
            currentActive: {},
            filterlist: [],
           
        }
    },
    created() {
      
        let _this = this;
        this.getWbs();

        bus.$on('newentry', function(e){
          _this.isNewEntry = e;
        });

        bus.$on('refreshwbs', function(){       
          _this.getWbs();
          
        });
    },
   

    components: {
       notify,
       wbs
    },
    methods: {
      toggleEditMode: function(){      
        localStorage.setItem('wbseditmode', this.editMode)          
      },      
          
      getWbs: function() {
        axios.get('/api/desk/wbs')
             .then(({data})=>{
               this.wbs = data;
               this.loading = false;});
      },  
      search(event) {
       
        this.filterString = event.target.value;
      }    
      
    }
}
 

</script>
<style>
input#wbs-search {
  width: 250px;
}
</style>

