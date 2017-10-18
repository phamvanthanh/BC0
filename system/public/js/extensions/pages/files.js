var index = document.getElementById("index");
var pid = index.getAttribute('data-pid');
window.Event = new Vue({

});

    
var vm = new Vue({
    el: '#app',
    
    data: {
        links : [],

        curlink: {
            id: null,
            project_id: pid,
            caption: null,
            url: null,
            
        },
      
        
        files : [],
       
    },    
    created: function(){
        self = this;
        this.getLinks(pid);
       
        Event.$on('edit', function(e){
            self.curlink = e;            
        });
      
    },
    methods: {

        saveLink: function(pid){
            var self = this,
            loc = "/projects/"+pid+"/links";
            axios({
                method: 'post',
                headers: {
                    'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
                },
                url: loc,               
                data: self.curlink
            }).then(function (response) {
               self.getLinks(pid);  
               self.clearCurLink();
                
                }).catch(function (error) {
                console.log(error);
            });
        },

        getLinks: function(pid){
            var self = this,
            loc = "/api/"+pid+"/links";      
            axios({
                method: 'get',
                url: loc,                
            }).then(function(response){
                self.links = response.data;
            })
        },

        submit: function(){
            this.saveLink(pid);
        },

        clearCurLink: function(){
            this.curlink.id = null;
            this.curlink.caption = null;
            this.curlink.url = null;
        },
      
    },
    components : {
        linkrow: {
            name: 'linkrow',
            template: '#link-template',
            props: {link: {
                    id: null,
                    project_id: pid,
                    caption: null,
                    url: null
                },
               
            },
            methods: {
                deleteLink: function(){
                   var yes = confirm('You are about to delete the link permanently. All system will not be able to access the link.');
                   if(yes)
                   {
                        self = this;
                        var  loc = "/projects/"+pid+"/links/delete"; 
                        axios({
                            method:'post',
                            url: loc,
                            data: self.link                         
                        }).then(function(response){
                            vm.getLinks(vm.pid);
                        })
                    }
                },
                editLink: function(){
                    Event.$emit('edit', this.link)
                }
            }
          
        },
        folders: {
            name:'folders',
            template: '#folders-template',          

            data: function(){
                return {
                    isNewFolder: false,
                      curfolder: {
                        id: null,
                        project_id: pid,
                        parent_id: null,
                        path: null,
                        name: null
                    },
                    folders: [],
                }
            },
            created: function(){
                 this.getFolders(pid);
            },
            methods: {
                submitFolder: function(){
                    this.saveFolder(pid);
                },
                saveFolder: function(pid){
                    var self = this,
                    loc = "/projects/"+pid+"/folders";
                    axios({
                        method: 'post',
                        headers: {
                            'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
                        },
                        url: loc,               
                        data: self.curfolder
                    }).then(function (response) {
                        self.getFolders(pid);  
                        self.clearCurFolder();
                        self.isNewFolder = false;
                        
                        }).catch(function (error) {
                            self.isNewFolder = false;
                            if (error.response) {
                                // console.log(error.response.data);
                                console.log(error.response.status);
                                // console.log(error.response.headers);
                            }
                    });
                    
                },
                getFolders: function(pid){
                    var self = this,
                    loc = "/api/"+pid+"/folders";
                    axios({
                        method: 'get',
                        url: loc
                    }).then(function(response){
                    self.folders = response.data;
                    })
                },
                clearCurFolder: function(){
                    this.curfolder.id = null,
                    this.curfolder.name = null,
                    this.curfolder.parent_id = null,
                    this.curfolder.path = null;
                }

            },
            components: {
                foldercomp: {
                    name:'foldercomp',
                    template: '#folder-template',
                    props: {
                        folder: {
                            id: null,
                            project_id: pid,
                            parent_id: null,
                            name: null,
                            
                        },                
                        
                    },
                    data: function(){
                        return {
                            isActive: false
                        }
                    },
                    methods: {
                        deleteFolder: function(){
                            var yes = confirm('You are about to delete the folder permanently. All system will not be able to access content within the folder.');
                            if(yes)
                            {
                                self = this;
                                var  loc = "/projects/"+self.pid+"/folders/delete"; 
                                axios({
                                    method:'post',
                                    url: loc,
                                    data: self.folder                         
                                }).then(function(response){
                                        vm.getFolders(vm.pid);
                                })
                            }
                        },
                        activate: function(){
                            
                            var i;
                            for(i=0; i < this.$parent.$children.length; i++){                          
                                this.$parent.$children[i].isActive = false;
                            }
                            this.isActive = true;
                        }
                        
                    }
                },
            }
        },
       
        filezone:{
            name: 'filezone',
            template: '#filezone-template',
            props: {
                pid: pid,
                
            },
            methods: {
                getFiles: function(){

                },
                uploadFiles: function(){

                }
            }
        } 

    }
}); // End of Vue instance

