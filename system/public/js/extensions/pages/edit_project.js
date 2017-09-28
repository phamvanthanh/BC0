var index = document.getElementById("index");
var pid = index.getAttribute('data-pid');


    
var vm = new Vue({
    el: '#app',
    
    data: {
        pid     : pid,
        project : null,
        clients : null,
        nations : null,
        value: null
    },    
    mounted: function(){
        this.getProject(this.pid);
        this.getClients();
    },
    methods: {
        getProject: function(pid)
        {
            var loc = "/api/"+pid+"/project",
            self = this;             
            $.ajax({
            url: loc,
            type: "get",
            data: '',
            success: function(response, status, xhttp) {           
                    self.project = response;            
                }
            })
        },
        saveProject: function(pid){
            var self = this,
            loc = "/projects/"+pid;
            axios({
                method: 'post',
                url: loc,
                headers: {
                    'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
                },
                data: self.project
            }).then(function (response) {
               console.log(response);            
          })
        },
        getClients: function(){
            var self = this,
            loc = "/api/clients"
            axios({
                method: 'get',
                url: loc,                
            }).then(function(response){
                self.clients = response.data;
            })
        },
        submit: function(){
            this.saveProject(this.pid);
        }
    }
}); // End of Vue instance

