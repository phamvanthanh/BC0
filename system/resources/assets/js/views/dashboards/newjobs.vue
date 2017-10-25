<template>
<div class="panel panel-flat">
    <div class="panel-heading">
        <span class="panel-title">New Jobs</span>
        <div class="heading-elements">
            <select v-model="days" >
                <option value="1" > 1 day</option>
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
            :data="jobs"
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
            jobs: [],
            columns: ['id', 'jobable_name', 'jobable_type', 'from_date', 'to_date', 'actions' ],
            options: {
                filterable: false,
                headings: {
                    jobable_name: 'Name',
                    jobable_type: 'Type',
                    actions: ''
                },

                columnsClasses: {                   
                    id: 'w-70',
                    jobable_name: 'column-expanded',                   
                    jobable_type: 'w-70',
                    from_date: 'w-100',
                    to_date: 'w-100',                 
                    actions: 'text-right w-30 action'           

                }
            },
            days: 3
        }
    },
    created() {
        this.getNewJobs(3);
    },
    watch: {
        days: function(val, oldVal) {
            if(oldVal)
                this.getNewJobs(val);
        }
    },
    methods: {
        getNewJobs(days) {
            axios.get('/api/dashboard/newjobs', {params: { days: days}})
                 .then(({data})=>{this.jobs = data})
                 .catch((error)=>{console.log(error)})
        }
    }
}
</script>