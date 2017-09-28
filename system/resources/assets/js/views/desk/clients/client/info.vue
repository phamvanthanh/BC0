<template>
<div class="panel panel-flat">
    <div class="panel-heading">

        <div class="heading-elements">
            <div class="heading-btn">
                                            
            </div>
        </div>
    </div>        
    <div class="panel-body"> 
        <div class="col-md-12">
            Name: {{client.first_name}} {{client.last_name}}<br>
            Org.: {{client.organization}}<br>
            Email: {{client.email}}<br>
            Status: {{client.status}}
        </div>                     
        
    </div>
</div>  
</template>
<script>

export default {
    props:['client'],   
    
}
</script>