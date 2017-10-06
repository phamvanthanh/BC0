<template>       
<div>
     <div class="col-md-5">
        Name: {{project.name}}<br>       
        Nation: {{project.nation_abbr}}</br>
        Client: {{project.user.first_name}} {{project.user.last_name}}
    </div>
    <div class="col-md-5">  
        Industry: {{project.industry.name}}<br>
        Timeframe: {{project.job.from_date}} to {{project.job.to_date}}<br>
        Status: <span :class="['label', project.job.status == 'active'? 'label-success': 'label-default']" >{{project.job.status | capitalize}}</span>         

    </div>    
    <div class="col-md-12">
        <span>Description:</span><br>
        <span class="pl-5"><pre>{{project.description}}</pre></span>
    </div>
    <div  class="col-md-12">
        <span>Requirements:</span><br>
        <span class="pl-5"><pre>{{project.requirement}}</pre></span>
    </div>
</div>

  
     

  


 

</template>
<script>

export default {  
props: ['project'],
filters: {
    capitalize: function (value) {
      if (!value) return ''
      value = value.toString()
      return value.charAt(0).toUpperCase() + value.slice(1)
    }
  }

}
</script>