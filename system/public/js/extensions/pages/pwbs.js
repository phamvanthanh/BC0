var index = document.getElementById("index");
var pid = index.getAttribute('data-pid');

var wbsCompMixin = {
  props: {
    node: null
  },
  data: function (){
    return {
      open: true,
      description: '',
     
    }
  },
  computed: {
    isFolder: function() {
      return this.node.children && this.node.children
    }
  },
  methods: {
    toggle: function(){
      if(this.isFolder){
        this.open = !this.open
      }
    },
    clickNode: function(){   
      if(!this.isActive)
        this.selectNode();
      else
        this.deselectNode();
    }, 
  }  
};

window.Event = new Vue({

});

var vm = new Vue({
  el: '#app',
  data: {
    pid: pid,  
    pwbs: [],
    wbs:[],
    isNewEntry: false,
    edit: false,
    isShowWbs: false,
    addcodes:[],
    removecodes: [],
    disabledcodes: [],
    updated: false   
    
  },
 
  created: function (){    
   
    this.fetchPwbs();
    this.fetchWbs(); 
    Event.$on('addcode', function(e){ // Add wbs code to array
      vm.selectAddCodes(e);
    });
    Event.$on('deselectraddcode', function(e){ 
      vm.deselectAddCode(e);
    })
    Event.$on('selectremovecode', function(e){ // Add pwbs code to array
      vm.selectRemoveCode(e);
    });
    Event.$on('deselectremovecode', function(e){ // Remove pwbs code from array
      vm.deselectRemoveCode(e);
    });
    Event.$on('newentry', function(e){
      vm.isNewEntry = e;
    })

  
  
  },
  mounted: function(){
    Event.$on('code', function(e){
      vm.disabledcodes.push(e);
      if(vm.disabledcodes.indexOf(0) < 0)
        vm.disabledcodes.unshift(0); 
    })
  },
  methods:{
      fetchPwbs: function()
      {
        var self = this;
        var loc = "/api/"+self.pid+"/pwbs";       
        $.ajax({
        url: loc,
        type: "get",
        data: '',
        success: function(response, status, xhttp) {           
              if(response != '')
              {
                var res = JSON.parse(response);           
                self.pwbs = res;
                return;
              }
              self.pwbs = [];
                    
           
          }
        });
      },
      fetchWbs: function()
      {
        var self = this,
        loc = "/api/wbs";
        $.ajax({
        url: loc,
        type: "get",
        data: '',
        success: function(response, status, xhttp) { 
            if(response !='')
            {
              var res = JSON.parse(response);  
              self.wbs = res;
              return;
            }      
            self.wbs = [];
      
          }
        });
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
   
   
      reset: function(e){       
        if(e == "pwbs"){
          this.fetchPwbs();
          this.removecodes = [];          
        }
        if(e == "wbs"){
          this.fetchWbs();
          this.addcodes = [];
        }
      },
      passPwbs: function(){
          var self=this,
          loc = "/projects/"+self.pid+"/pwbs/pass";
          axios.post(loc, {data: this.addcodes})
          .then(function (response) {
            vm.fetchPwbs(self.pid);
            vm.disabledcodes.push(this.addcodes);
            Event.$emit('reformatwbs');
            vm.addcodes = [];

          })
          .catch(function (error) {
            console.log(error);
          });
      },
      removePwbs: function(){
         var self=this;
         loc = "/projects/"+self.pid+"/pwbs/delete";
         axios.post(loc, {data: self.removecodes})
          .then(function (response) {         
            self.fetchPwbs(self.pid);           
            var i, index;
       
            for(i=0; i < self.removecodes.length; i++)
            {
              
              index = self.disabledcodes.indexOf(self.removecodes[i]);
              if( index >= 0)
                self.disabledcodes.splice(index, 1);                 
               
            }
             self.removecodes = [];
          })
          .catch(function (error) {
            console.log(error);
          });
      }

  },
  components: {
    pwbs:{
      mixins: [wbsCompMixin],
      name: 'pwbs',
      template: '#pwbs-template',
      created: function (){ 
          if(this.node.code == 'undefined')
            Event.$emit('code', 0);                                
          Event.$emit('code', this.node.code);           
          
      },
    },
  
    wbs: {
      mixins: [wbsCompMixin],
      name: 'wbs',
      template: '#wbs-template',
      data: function(){
        return{
          isActive: false,
          isDisabled: false,
         
        }
      },
      props: {
        addcodes: null,
        disabledcodes: null
      },
      // computed: {
      //   isActive: function(){
      //     if(this.addcodes.indexOf(this.node.code) >=0)
      //       return true;
      //     return false;
      //   },
      //   isDisabled: function(){
      //     if(this.disabledcodes.indexOf(this.node.code) >= 0)
      //       return true;
      //     return false;
      //   }
      // },
   
      created: function(){      
        this.disable();
      },
      watch: {
        addcodes: function(){  
          this.activate();
        },
        disabledcodes: function(){
          this.disable();
        }
      },

      updated: function() {
          if(!vm.updated){
            if(vm.disabledcodes.length>0)
            {
              this.disable();   
              vm.updated = true;  
            }
          }        
      },


      methods: {    
        selectNode: function (){
          if(!this.isDisabled) {
           // this.isActive = true;
            Event.$emit('addcode', this.node.code); 
            if(this.$parent.node)           
              this.$parent.selectNode();

          }          
      
        },
        deselectNode: function() {            
            Event.$emit('deselectraddcode', this.node.code);
           // this.isActive = false;              
            if(this.$children)
            for( var i=0; i < this.$children.length; i++) {                      
              if(this.$children[i].isActive)
                this.$children[i].deselectNode();                      
            }       
        },
 
        disable: function() {        
          if(vm.disabledcodes.indexOf(this.node.code) >=0){
            this.isDisabled = true;        
            return;
          }
          this.isDisabled = false;
        },
        activate: function() {
          if(vm.addcodes.indexOf(this.node.code) >= 0){       
            this.isActive = true;
            return;
          }
          this.isActive = false;

        }
   
      }
    },
    epwbs: {
      mixins: [wbsCompMixin],
      name: 'epwbs',
      template: '#epwbs-template',
      data: function() {
        return {          
          pid: pid,       
          code: '',
          name: '',
          quantify: false,
          isNewEntry: false
        }
      },
      created: function(){
        
      },
      props: {
        removecodes: null
      },
      computed: { 
        isActive : function(){
          if(this.removecodes.indexOf(this.node.code) >=0)
            return true;
          return false;
        }
      },

    
      methods: {
        addChild: function(){
          if(!vm.isNewEntry){           
            this.isNewEntry = true;
            Event.$emit('newentry', true);
          }
        },
        cancel: function (){        
          if(vm.isNewEntry){              
            this.isNewEntry = false;
            Event.$emit('newentry', false);
          }
        },
        changeType: function () {
       
          if (!this.isFolder) {
            Vue.set(this.node, 'children', [])
            this.addChild()
            this.open = true
          }
          
        },
        selectNode: function(){
            Event.$emit('selectremovecode', this.node.code); 
            // this.isActive = true;
            if(this.$children)
            for( var i=0; i < this.$children.length; i++){                      
                if(!this.$children[i].isActive)
                this.$children[i].selectNode();                
            }   
            
        },
        deselectNode: function() {                  
            Event.$emit('deselectremovecode', this.node.code); 
            if(this.$parent.isActive)
              this.$parent.deselectNode();

        },
        activate: function() {
          if(this.removecodes.indexOf(this.node.code) >= 0){       
            this.isActive = true;
            return;
          }
          this.isActive = false;

        },
      
        submit: function(){
          
          var self = this,
          loc = "/projects/"+self.pid+"/pwbs/create",
          quantify = self.quantify? 1: 0;
          axios({
            method: 'post',
            url: loc, 
            headers: {
                'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
            },
            data: {
                code: self.code,
                parent_code: self.node.code, 
                name: self.name,
                extension: 1,
                quantify: quantify
              }
          }).then(function (response) {
            self.cancel();
            vm.fetchPwbs(self.pid);            
          })
          .catch(function (error) {
            console.log(error);
          });
        }
      }

    }
  }

});
