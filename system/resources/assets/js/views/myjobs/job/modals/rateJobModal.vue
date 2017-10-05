<!-- template for the modal component -->
<template>
  <transition id="rate-job-modal" name="modal">
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">
            <div class="modal-header">   
               <span class="fs-16">Job Rating</span>   
               <button type="button" class="text-white" @click="$parent.$emit('closemodal')"><i class="icon-cross2"></i></button>
            </div>

            <div class="modal-body">
               
                    <form @submit.prevent="onSubmit"  @change="form.errors.clear($event.target.name)"   >    
                             <div class="col-md-12">
                                <div class="form-group">
                                    <label>Job: #{{data.job_id}} - {{data.name}}</label>                                            
                                    
                                </div>
                                
                            </div>                        
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Rate:</label>                                            
                                    <Rate :length="5"  :value="data.rate" @afterRate="onAftereRate" ></Rate>
                                </div>
                                
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label>Comments:</label>
                                    <textarea type="text" :value="data.comment" v-model="form.comment" rows="4" placeholder="Please place your fair comments"  value="" class="form-control"></textarea>
                                </div>
                            </div>
                             <div class="col-md-12">
                                <div class="form-group">
                                    <button type="submit"  class="btn btn-primary">Save Rate</button>
                                </div>
                            </div>                    
                                   
                 </form>
            </div>

            <div class="modal-footer">
                
            </div>

        </div>			
      </div>
    </div>
  </transition>
</template>
<script>
import Rate from 'vue-rate';


export default {
    props:['data'],
    data() {
        return {
            form: new Form({
                job_id: this.data.job_id,
                rate: parseInt(this.data.rate),
                comment: this.data.comment
            })           
        }
    },
    components: {
        Rate
    },
    methods: {
        onSubmit() {
            // this.form.job_id = this.data.job_id;
            this.form.post('/api/jobs/rate')
                     .then(({data})=>{
                         this.$parent.$emit('closemodal');
                         this.$parent.$emit('refreshparent');
                         notice(this.form.notifications, 6000);

                     })
                     .catch((error)=>{
                         this.$parent.$emit('closemodal');
                         notice(this.form.notifications, 6000);
                     })
        },
        onAftereRate(rate) {
            this.form.rate = rate;
        }
       
   },
   
}
</script>
<style lang="scss">

@import './../../../../../sass/components/_variables';


#rate-job-modal .modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}

#rate-job-modal .modal-container {
  width: 500px;
  margin: 0px auto;
  padding: 0px;
  background-color: #fff;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
  transition: all .3s ease;
  font-family: Helvetica, Arial, sans-serif;
}
#rate-job-modal  .modal-header {
    position: relative;
    background-color:$brand-primary-bg;
    color:$text-white; 
    padding-top: 5px;
    padding-bottom: 5px;
  
}
#rate-job-modal  .modal-header button{
    position:absolute;
    float: right;
    right: 3px;
    background-color: transparent;
    border: none;  
}

#rate-job-modal  .modal-header button i{
     opacity: 0.7;
}

#rate-job-modal  .modal-header button:hover i {
    opacity: 0.9;
}
.modal-closer {
    position: absolute;
    top:2px;
    right: 2px;
}

.modal-body {
  margin: 0px;
}

.modal-default-button {
  float: right;
}


.modal-enter {
  opacity: 0;
}

.modal-leave-active {
  opacity: 0;
}

.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}
</style>