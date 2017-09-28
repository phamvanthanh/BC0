<template>
    <div class="panel panel-flat">
        <div :class="{loader:loading}"></div>
        <div :class="{hidden:loading}" class="panel-heading">
         
            <div class="heading-elements">
                <ul class="icons-list">
                    
                    
                </ul>
            </div>
        </div>
		 <div :class="{hidden:loading}"  class="panel-body">
			<div id="org" class="pt-30" >
			
				<figure class="org-chart cf pt-30">
					<ul class="administration">
					<li>					
						<ul class="director" v-if="sections.length > 0" >
						<li class="org-pm" >
							<a href="#">
								<span class="post_info fs-12">
									<span class="">Project: {{job.jobable.name}}</span>
									<span class="" v-if="job.awarded" >Responder:{{ job.awarded.user.first_name}} {{ job.awarded.user.last_name}}</span>					
									<span class="" v-if="job.awarded" >Email: {{job.awarded.user.email}}</span>
									<span class="" v-if="job.awarded" >Phone: {{job.awarded.user.phone}}</span>
									<span class="">Jid: {{job.id}}</span>
								</span>
							</a>
							<!--<ul class="subdirector">
							<li><a href="#"><span>Project Manager Assistant</span></a></li>
							</ul>-->
							<ul class="departments cf" :data-length="sections.length" >								
							<!--<li><a href="#"><span></span></a></li>-->
							
							<li v-for="section in sections" class="department dep-a">
								<a href="#">
									<span class="post_info fs-12">
										<span class="">Section: {{section.job.jobable.name }}</span>
										<span class="" v-if="section.job.awarded" >Responder: {{section.job.awarded.user.first_name}} {{ section.job.awarded.user.last_name}}</span>
										
										<span class="" v-if="section.job.awarded" >Email: {{section.job.awarded.user.email}}</span>
										<span class="" v-if="section.job.awarded" >Phone: {{section.job.awarded.user.phone}}</span>
										<span class="">Jid: {{section.job.id}}</span>
									</span>
								</a>
								<ul class="sections">
								<li v-for="package in section.packages" class="package">
									<a href="#">
										<span class="post_info fs-12" >
											<span class="">Package: {{package.job.jobable.name }}</span>
											<span class="" v-if="package.job.awarded" >Responder: {{package.job.awarded.user.first_name}} {{package.job.awarded.user.last_name}}</span>					
											<span class="" v-if="package.job.awarded">Email: {{package.job.awarded.user.email}}</span>
											<span class="" v-if="package.job.awarded">Phone: {{package.job.awarded.user.phone}}</span>
											<span class="">Jid: {{package.job.id}}</span>
													
										</span>
									</a>
								</li>
								
								</ul>
							</li>
							
							</ul>
						</li>
						</ul>	
					</li>
					</ul>			
				</figure>
			</div>
		</div>
	</div>
</template>
<script>


export default {
	props: ['project_id', 'job'],
	data() {
		return {
			loading: true,
			sections: [],
		}
	},
	created() {
		this.getSections(this.project_id);
	},

	methods: {
		     getSections(pid) {
            axios.get('/api/projects/'+pid+'/sections')
                 .then(({data})=>{
                     var length = data.length; 
                     if(length > 0) {    
											                    
                          $('<style>#org .departments::after{width:calc(100% - 100% /'+length+' + 2px); left: calc(100%/'+2*length+' + 8px);	} 	#org .department { width: calc(100%/'+length+' - 20px);}</style>').appendTo('head');

								this.sections = data;			
						  
                      }
                      else
                        this.sections = [];

                  
                    this.loading = false; 
                })
        }, 
    
	}
}

</script>
<style>


#org *{
	-webkit-box-sizing: border-box;
	-moz-box-sizing: border-box;
	box-sizing: border-box;
	position: relative;
}

#org .cf:before,
#org .cf:after {
    content: " "; /* 1 */
    display: table; /* 2 */
}

#org .cf:after {
    clear: both;
}

/**
 * For IE 6/7 only
 * Include this rule to trigger hasLayout and contain floats.
 */
#org .cf {
    *zoom: 1;
}


#org {
    width: 100%;
	/*max-width: 1142px;*/
	margin: 0 auto;
	padding: 0 20px;
    /*background: #F5EEC9;*/
}

#org a:focus{
	outline: 2px dashed #f7f7f7;
}

@media all and (max-width: 767px){
	#org {
		padding: 0 20px;
	}	
}

#org ul{
	padding: 0;
	margin: 0;
	list-style: none;		
}

#org ul a{
	display: block;
	padding: 5px;	
	border: 2px solid #3097D1;
	text-align: center;
	overflow: hidden;
	/*font-size: .7em;*/
	text-decoration: none;
	/*font-weight: bold;*/
	color: #333;
	height: 80px;
	margin-bottom: -26px;
	box-shadow: 4px 4px 9px -4px rgba(0,0,0,0.4);
	-webkit-transition: all linear .1s;
	-moz-transition: all linear .1s;
	transition: all linear .1s;
}


@media all and (max-width: 767px){
	ul a{
		font-size: 1em;
	}
}

#org ul a span.post_info {

	margin: auto;
	padding-left: auto;

	text-align: left;
	color: 
}
#org ul a span.post_info span{

	margin-top: -0.5em;
	display: block;
}



#org .director > li > a{
	width: 50%;
	margin: 0 auto 0px auto;
}



#org .departments{
	position: absolute;
	width: 100%;
		
}


#org .departments::after{
	content: "";
	display: block;
	position: absolute;
	height: 30px;	
	border-top: 2px solid #3097D1;
	margin: 0 auto;
	top: 34px;
	
}

@media all and (max-width: 767px){
	.departments::after{
		border-right: none;
		left: 0;
		width: 49.8%;
	}  
}

@media all and (min-width: 768px){
   .department:first-child:before,
   .department:last-child:before{
    border:none;
  }
}

#org .department:before{
	content: "";
	display: block;
	position: absolute;
	width: 0;
	height: 32px;
	border-left: 2px solid #3097D1;
	z-index: 1;
	top: -32px;
	left: 50%;
	margin-left: -3px;

}
.org-pm::after {
	content: "";
	display: block;
	position: absolute;
	width: 0;
	height: 34px;
	border-left: 2px solid #3097D1;
	z-index: 1;
	top: 80px;
	left: calc(50% + 8px);

}

#org .department{
	border-left: 2px solid #3097D1;
	float: left;
    top: 68px;
	margin-left: 20px;
	margin-bottom:60px;
}


#org .lt-ie8 .department{
	width: 18.25%;
}

@media all and (max-width: 767px){
	.department{
		float: none;
		width: 100%;
		margin-left: 0;
	}

	.department:before{
		content: "";
		display: block;
		position: absolute;
		width: 0;
		height: 60px;
		border-left: 2px solid white;
		z-index: 1;
		top: -60px;
		left: 0%;
		margin-left: -2px;
	}

	.department:nth-child(2):before{
		display: none;
	}
}

#org .department > a{
	margin: 0 0 -26px -2px;
	z-index: 1;
}

#org .department > a:hover{	
	height: 100px;


}

#org .department > ul{
	margin-top: 0px;
	margin-bottom: 0px;
}

#org .department li{	
	padding-left: 25px;
	border-bottom: 2px solid #3097D1;
	height: 95px;	
}

#org .department li a{
	background: #3097D1;
	top: 48px;	
	position: absolute;
	z-index: 1;
	width: 90%;
	height: 80px;
	vertical-align: middle;
	right: -1px;
	/*background-image: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiA/Pgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgd2lkdGg9IjEwMCUiIGhlaWdodD0iMTAwJSIgdmlld0JveD0iMCAwIDEgMSIgcHJlc2VydmVBc3BlY3RSYXRpbz0ibm9uZSI+CiAgPGxpbmVhckdyYWRpZW50IGlkPSJncmFkLXVjZ2ctZ2VuZXJhdGVkIiBncmFkaWVudFVuaXRzPSJ1c2VyU3BhY2VPblVzZSIgeDE9IjAlIiB5MT0iMCUiIHgyPSIxMDAlIiB5Mj0iMTAwJSI+CiAgICA8c3RvcCBvZmZzZXQ9IjAlIiBzdG9wLWNvbG9yPSIjMDAwMDAwIiBzdG9wLW9wYWNpdHk9IjAuMjUiLz4KICAgIDxzdG9wIG9mZnNldD0iMTAwJSIgc3RvcC1jb2xvcj0iIzAwMDAwMCIgc3RvcC1vcGFjaXR5PSIwIi8+CiAgPC9saW5lYXJHcmFkaWVudD4KICA8cmVjdCB4PSIwIiB5PSIwIiB3aWR0aD0iMSIgaGVpZ2h0PSIxIiBmaWxsPSJ1cmwoI2dyYWQtdWNnZy1nZW5lcmF0ZWQpIiAvPgo8L3N2Zz4=);
	background-image: -moz-linear-gradient(-45deg,  rgba(0,0,0,0.25) 0%, rgba(0,0,0,0) 100%) !important;
	background-image: -webkit-gradient(linear, left top, right bottom, color-stop(0%,rgba(0,0,0,0.25)), color-stop(100%,rgba(0,0,0,0)))!important;
	background-image: -webkit-linear-gradient(-45deg,  rgba(0,0,0,0.25) 0%,rgba(0,0,0,0) 100%)!important;
	background-image: -o-linear-gradient(-45deg,  rgba(0,0,0,0.25) 0%,rgba(0,0,0,0) 100%)!important;
	background-image: -ms-linear-gradient(-45deg,  rgba(0,0,0,0.25) 0%,rgba(0,0,0,0) 100%)!important;
	background-image: linear-gradient(135deg,  rgba(0,0,0,0.25) 0%,rgba(0,0,0,0) 100%)!important;
	filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#40000000', endColorstr='#00000000',GradientType=1 );*/
}

#org .department li a:hover{
	box-shadow: 8px 8px 9px -4px rgba(0,0,0,0.1);
	height: 90px;
	width: 95%;
	top: 39px;
	background-image: none!important;
}

/* Department/ section colors */
#org .department.dep-a a{ background: #fff; }
#org .department.dep-b a{ background: #fff; }
#org .department.dep-c a{ background: #fff; }
#org .department.dep-d a{ background: #fff; }
#org .department.dep-e a{ background: #fff; }


</style>