<template>
<div class="panel panel-flat">
    <div class="panel panel-flat">
							
        <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-4">
                        <ul class="list-inline text-center">
                           
                            <li class="text-center">
                                <div class="fw-600 fs-30">{{counts.actives}}</div>
                                <div class="text-bold">Active Projects</div>
                            </li>
                        </ul>

                        <div class="col-lg-10 col-lg-offset-1">
                            <div class="content-group" id="new-visitors"></div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <ul class="list-inline text-center">
                     
                            <li class="text-center">
                                <div class="fw-600 fs-30">{{counts.finishes}}</div>
                                <div class="text-bold">Finished Projects</div>
                            </li>
                        </ul>

                        <div class="col-lg-10 col-lg-offset-1">
                            <div class="content-group" id="new-sessions"></div>
                        </div>
                    </div>

                    <div class="col-lg-4">
                        <ul class="list-inline text-center">
                            <li>
                                <a href="#" class="btn border-indigo-400 text-indigo-400 btn-flat btn-rounded btn-icon btn-xs valign-text-bottom"><i class="icon-people"></i></a>
                            </li>
                            <li class="text-left">
                                <div class="text-semibold">Total online</div>
                                <div class="text-muted"><span class="status-mark border-success position-left"></span> 5,378 avg</div>
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
        this.countProjects();
    },
    methods: {
        countProjects() {
            axios.get('api/dashboard/countprojects')
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

