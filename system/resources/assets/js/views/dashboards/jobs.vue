<template>

    <div class="panel panel-flat">
        <div class="panel-heading">
            <h6 class="panel-title">Jobs</h6>
            <div class="heading-elements">
                
            </div>
        </div>
    
        <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-3">
                        <ul class="list-inline text-center">
                           
                            <li class="text-center">
                                <div class="fw-600 fs-30">{{counts.actives}}</div>
                                <div class="text-bold">Active</div>
                            </li>
                        </ul>

                        <div class="col-lg-10 col-lg-offset-1">
                            <div class="content-group" id="new-visitors"></div>
                        </div>
                    </div>

                    <div class="col-lg-3">
                        <ul class="list-inline text-center">
                     
                            <li class="text-center">
                                <div class="fw-600 fs-30">{{counts.all - counts.awardeds}}</div>
                                <div class="text-bold">Unwarded</div>
                            </li>
                        </ul>

                        <div class="col-lg-10 col-lg-offset-1">
                            <div class="content-group" id="new-sessions"></div>
                        </div>
                    </div>

                    <div class="col-lg-3">
                        <ul class="list-inline text-center">
                         
                            <li class="text-center">
                                <div class="fw-600 fs-30">{{counts.finishes}}</div>
                                <div class="text-bold">Finished</div>
                            </li>
                        </ul>

                        <div class="col-lg-10 col-lg-offset-1">
                            <div class="content-group" id="total-online"></div>
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
                            <div class="content-group" id="total-online"></div>
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
        this.countJobs();
    },
    methods: {
        countJobs() {
            axios.get('api/dashboard/countjobs')
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

