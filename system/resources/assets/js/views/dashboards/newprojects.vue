<template>
<div class="panel panel-flat">
    <div class="panel-heading">
        <span class="panel-title">New Projects</span>
        <div class="heading-elements">
            <select v-model="days" >
                <option value="1" > 1 days</option>
                <option value="3" selected > 3 days</option>
                <option value="7" > 7 days</option>
                <option value="10" > 10 days</option>
                <option value="15" > 15 days</option>
                <option value="30" > 30 days</option>
            </select>
        </div>
    </div>
     <div class="container-fluid">
        <v-client-table
            :data="projects"
            :columns="columns"
            :options="options" >
            <template slot="actions" scope="props" >
                <router-link :to="{name: 'job', params: {id: props.row.id}}" class="text-primary" ><i class="icon-unfold"></i></router-link>
            
            </template>
                
        </v-client-table>
    </div>
</div>
</template>

<script>
export default {
    data() {
        return {
            projects: [],
            columns: ['id', 'name', 'nation_abbr', 'industry', 'from_date', 'to_date', 'actions' ],
            options: {
                    filterable: false,
                    headings: {                      
                        nation_abbr: 'Type',
                        actions: ''
                    },

                columnsClasses: {                   
                    id: 'w-70',
                    name: 'column-expanded',                   
                    nation_abbr: 'w-70',
                    industry: 'w-80',
                    from_date: 'w-100',
                    to_date: 'w-100',                 
                    actions: 'text-right w-30 action'           

                }
            },
            days: 3
        }
    },
    created() {
        this.getNewProjects(3);
    },
    watch: {
        days: function(val, oldVal) {
            if(oldVal)
                this.getNewProjects(val);
        }
    },
    methods: {
        getNewProjects(days) {
            axios.get('/api/dashboard/newprojects', {params: {days: days}})
                 .then(({data})=>{this.projects = data})
                 .catch((error)=>{console.log(error)})
        }
    }
}
</script>