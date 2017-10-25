<template>

    <div class="panel panel-flat">
        <div class="panel-heading">
            <h6 class="panel-title">Issues</h6>
            <div class="heading-elements">
                
            </div>
        </div>
    
        <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-3">
                        <ul class="list-inline text-center">
                           
                            <li class="text-center">
                                <div class="fw-600 fs-30">{{counts.opens}}</div>
                                <div class="text-bold">Open</div>
                            </li>
                        </ul>

                        <div class="col-lg-10 col-lg-offset-1">
                            <div class="content-group" id="new-visitors"></div>
                        </div>
                    </div>

                    <div class="col-lg-3">
                        <ul class="list-inline text-center">
                     
                            <li class="text-center">
                                <div class="fw-600 fs-30">{{counts.all}}</div>
                                <div class="text-bold">Total</div>
                            </li>
                        </ul>

                        <div class="col-lg-10 col-lg-offset-1">
                            <div class="content-group" id="new-sessions"></div>
                        </div>
                    </div>

                   
                </div>
            </div>

            <div class="position-relative" id="traffic-sources"></div>
        </div>

</div>
</template>
<script>
export default {
    data() {
        return {
            counts: {}
        }
    },
    created() {
        this.countIssues();
    },
    methods: {
        countIssues() {
            axios.get('api/dashboard/countissues')
                 .then(({data})=>{
                     this.counts = data;
                 })
                 .catch((error)=>{
                     console.log(error);
                 })
        }
    }
}

</script>

