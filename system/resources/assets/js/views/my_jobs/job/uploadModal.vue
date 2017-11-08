<!-- template for the modal component -->
<template>
  <transition name="modal">
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">
            <div class="modal-header">
       
       
               <button type="button" class="close" @click="$emit('close')" data-dismiss="modal">×</button>
            </div>

            <div class="modal-body">
                <div class="dropzone-container" > 
                    <dropzone ref="projectdropzone"
                        id="myVueDropzone" 
                        :url="uploadUrl" 
                        :headers="header"                    
                        :dropzoneOptions="dropzoneOptions"
                        @vdropzone-success="afterSuccess"
                        :thumbnailHeight="40"
                        :thumbnailWidth="40"
                        :language="language"
                        :maxFileSizeInMB="maxFileSizeInMB"
                        :maxNumberOfFiles="maxNumberOfFiles"
                        :acceptedFileTypes="acceptedFileTypes"
                        >
                       <input type="hidden" v-model="id" name="id"  /> <!-- id is quantity_id if audit -->
                       <input type="hidden" v-model="job_id" name="job_id" />
                       <input type="hidden" v-model="code" name="code"  />
                       <input type="hidden" v-model="fileType" name="file_type"  />
                       <slot name="quantity_id" ></slot>
                    </dropzone>
                </div>
            </div>

            <div class="modal-footer">
                
            </div>

        </div>			
      </div>
    </div>
  </transition>
</template>
<script>
import Dropzone from 'vue2-dropzone';


export default {
    props: {        
        id: '',  
        job_id: null,
        code: '',
        fileType: '',
        fileFormat: '', 
        uploadUrl: null,  
        editMode: true        
    },
    data() {
        return {
           
            // jid: this.$route.params.jid,
            files: [],
            dropzoneOptions: {             
                   
            },
            header: {'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
            },
            language: {
                    dictFileTooBig:"File is too big ({{filesize}}MiB). Max filesize: {{maxFilesize}}MiB.",
                    dictDefaultMessage:"Drop file here",
                    dictCancelUploadConfirmation:"Are you sure you want to cancel this upload?",
                    dictCancelUpload:"Cancel upload",
                    dictFallbackMessage:"Your browser does not support drag and drop file uploads.",
                    dictFallbackText:"Please use the fallback form below to upload your files like in the olden days.",
                    dictInvalidFileType:"File format not accepted.",
                    dictMaxFilesExceeded:"You can not upload any more files. (max: {{maxFiles}})",
                    dictRemoveFile:"Remove",
                    dictRemoveFileConfirmation:null,
                    dictResponseError:"Server responded with {{statusCode}} code.",
            },
            maxFileSizeInMB: 256,
            maxNumberOfFiles: 1,
            acceptedFileTypes: 'image/*,application/pdf,xls,xlsx,csv',
            isOpen: false,         
            
        }
    },
    created() {
      
        this.acceptedFileTypes = this.fileFormat;      
      
    },

    components: {
        Dropzone,
        
    },
    methods: {
     
      afterSuccess(){
          bus.$emit('refreshtable');       
     },
   
   },
   
}
</script>
<style>
i.material-icons {
    display: none !important;
}
#docs-wrapper {
    min-height: 100px;
}
.uploader {    
    overflow-x: hidden;
    overflow-y: hidden;
    min-height: 150px;
    
}
.is-close {
    width: 20px;
    right: -10px;
    position: absolute;
    
}
.dropzone-container {
    z-index: 8;
}
.is-close .dropzone-container {
    display: none;
}
.is-open {
    width: 100%;
    margin-bottom: 20px;
}
div.opener {
    position: absolute;
    height: 100%;
    width: 20px;
    left: 0px;  
    z-index: 9;
    background-color: deepskyblue;
}
div.opener i {
    position:relative;
    top: calc(50% - 10px); /* 50% - 3/4 of icon height */
}
div.is-close div.opener {
    opacity: 1;
}
div.is-open div.opener { 
    opacity: 1;
  
}


.modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, .5);
  display: table;
  transition: opacity .3s ease;
}

.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}

.modal-container {
  width: 300px;
  margin: 0px auto;
  padding: 5px 5px;
  background-color: #fff;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
  transition: all .3s ease;
  font-family: Helvetica, Arial, sans-serif;
}
modal-header {
    position: relative;
}
modal-closer {
    position: absolute;
    top:2px;
    right: 2px;
}
.modal-header h3 {
  margin-top: 0;
  color: #42b983;
}

.modal-body {
  margin: 20px 0;
}

.modal-default-button {
  float: right;
}

/*
 * The following styles are auto-applied to elements with
 * transition="modal" when their visibility is toggled
 * by Vue.js.
 *
 * You can easily play with the modal transition by editing
 * these styles.
 */

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