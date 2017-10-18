
var vm = new Vue({
    el : "#app",
    data : {
        project: {
            name: null,
            user_id: null,
            nation_id: null,
            industry_id: null,
            from_date: null,
            to_date: null,
            summary: null,
            requirement: null,
            status: 0
        },
        clients: null
    },
    mounted: function(){
        this.getClients();
    },
    methods: {
        submit: function(){
            this.saveProject();
        },
        saveProject: function(){
            var self = this,
            loc = "/projects/new";
            axios({
                method: 'post',
                url: loc,
                headers: {
                    'X-CSRF-Token': $('meta[name="csrf_token"]').attr('content')
                },
                data: self.project
            }).then(function(response){
               self.clearProject();
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
        clearProject: function()
        {
            this.project.name = null,
            this.project.user_id = null,
            this.project.nation_id = null,
            this.project.industry_id = null,
            this.project.from_date = null,
            this.project.to_date = null,
            this.project.summary = null,
            this.project.requirement = null

        }
    }
});