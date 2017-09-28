<!-- template for the modal component -->
<template>
  <transition name="modal">
      
    <div id="uploader_modal" class="modal-mask">
      <div class="modal-wrapper"  >
        <div class="modal-container" :style="style">
            <div class="modal-header">  
               <span class="fs-16">Folder Files Upload</span>       
               <button type="button" class="text-white" @click="$parent.$emit('close')" data-dismiss="modal"><i class="icon-cross2"></i></button>
            </div>

            <div class="modal-body">
                <div class="dropzone-container" > 
                    <dropzone ref="dropzone"
                        :preview-template="template"
                        id="myVueDropzone" 
                        :url="url" 
                        :headers="header"                    
                        :dropzoneOptions="dropzoneOptions"
                        @vdropzone-success="afterSuccess"
                       
                        :thumbnailHeight=40
                        :thumbnailWidth=40
                        :language="language"
                        :maxFileSizeInMB="maxFileSizeInMB"
                        :maxNumberOfFiles="maxNumberOfFiles"
                        :acceptedFileTypes="acceptedFileTypes"
                        >                     
                   
                      
                    </dropzone>
                </div>
              
            </div>


        </div>			
      </div>
    </div>
  </transition>
</template>
<script>
import Dropzone from 'vue2-dropzone';


export default {
    props: ['url', 'width', 'height'],
    computed: {
        style: {
            get() {
                if(this.width){
                    return {width: this.width+'px', height: this.height+'px'}            

                }
            }
        }
    },
    data() {
        return {           
            
            files: [],
            dropzoneOptions: {   
                autoProcessQueue: false,          
                   
            },
            header: {'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
            },
            language: {
                    dictFileTooBig:"File is too big ({{filesize}}MiB). Max filesize: {{maxFilesize}}MiB.",
                    dictDefaultMessage:"Drop files here",
                    dictCancelUploadConfirmation:"Are you sure you want to cancel this upload?",
                    dictCancelUpload:"Cancel upload",
                    dictFallbackMessage:"Your browser does not support drag and drop file uploads.",
                    dictFallbackText:"Please use the fallback form below to upload your files like in the olden days.",
                    dictInvalidFileType:"File format not accepted.",
                    dictMaxFilesExceeded:"You can not upload any more files. (max: {{maxFiles}})",
                    dictRemoveFile:"",
                    addRemoveLinks: false,
                    dictRemoveFileConfirmation:null,
                    dictResponseError:"Server responded with {{statusCode}} code.",
            },
            maxFileSizeInMB: 256,
            maxNumberOfFiles: 100,
            acceptedFileTypes: 'image/*,application/pdf,cad,xls,xlsx,csv',
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
           bus.$emit('uploadsuccess');  
           console.log(this.$refs.dropzone)     
      },
    

       'template':function() {
          return `
   
                  <div class="table table-striped" class="files" id="previews">

                    <div id="template" class="file-row">
                        <!-- This is used as the file preview template -->
                        <div id="thumbail" class="display-td">
                            <span class="preview"><img data-dz-thumbnail /></span>
                        </div>
                        <div id="filename" class="display-td">
                            <span class="name fs-300" data-dz-name></span>
                            <strong class="error text-danger" data-dz-errormessage></strong>
                        </div>
                        <div class="display-td filesize">
                            <span class="dz-size size" data-dz-size ></span>
                        </div>
                        <div class="display-td progressbar">
                            
                            <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                                <div class="progress-bar progress-bar-success" style="width:0%;" data-dz-uploadprogress></div>
                            </div>
                        </div>
                        <div id="actions" class="display-td">
                            <a class="dz-remove" data-dz-remove ><i class="icon-cross2 text-primary"></i></a>
                         </div>
                       
                    </div>

                </div>
          
              `;
      }
   
   },
   
}
</script>

<style lang="scss">

@import './../../../sass/_variables';

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
#uploader_modal .modal-body {
    max-height: calc(100vh - 180px);
    overflow-y: auto;
}

.modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(191, 191, 191, 0.1);
  display: table;
  transition: opacity .3s ease;
}

#upload-file-modal .modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}

#upload-file-modal .modal-container {
  min-width: 600px;
  min-height: 300px;
  margin: 0px auto;
  padding: 5px 5px;
  background-color: #fff;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(191, 191, 191, 0.1);
  transition: all .3s ease;
  font-family: Helvetica, Arial, sans-serif;
}
modal-header {
    position: relative;
}
.modal-closer {
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

.vue-dropzone {
    border: 2px dashed #e5e5e5 !important;
}
.dz-preview,
.dz-image {
    width: 100%;
   
}
.dropzone-container div {
    vertical-align: top;
    
}
.dropzone-container .file-row {
    height: 40px;
    overflow: hidden;
}
.dropzone-container #thumbnail {
    width: 100px;
    padding: 0px 10px;
}
.dropzone-container #filename {
    
    width: calc(100vw - 450px);
    text-overflow: ellipsis;
    padding: 0px 10px;
}

.dropzone-container .filezie {
    width: 150px;
    padding: 0px 10px;
    
}
div.filesize {
    width: 150px;
    padding: 0px 10px;
}

.dropzone-container .progressbar {
    width: 250px;
    padding: 0px 10px;
    
}
.dropzone-container #actions {
    width: 50px;
    padding: 0px 10px;
}
 

</style>