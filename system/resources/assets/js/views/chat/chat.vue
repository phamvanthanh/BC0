<template>					<!-- User menu -->

	<div class="content-wrapper">
		<div class="page-header">
			<div class="page-header-content">
				<div class="page-title">
					 <window-heading2></window-heading2>
				</div>

				<div class="heading-elements">
					<div class="heading-btn-group">
						
					</div>
				</div>
			</div>		
		</div>
	
		<div class="content" id="chat-page">
			<div  class="panel panel-flat" style="height: 100%">		

				 <div class="panel-body pt-0" style="height: 100%">
					 <div class="row" style="height: 100%" >
						<div class="chatnav col-md-4 pr-0 mr-0">						
								<div class="chatnav-heading">
									<ul class="nav nav-tabs">
										<li v-if="$can('surveyor|qto_controller|project_manager')"  @click.prevent="selectChannel('1')" class="pointer" :class="[channel==1? 'active': '']"><span  >Job Channel</span></li>
										<li v-if="$can('client|project_manager')" @click.prevent="selectChannel('2')" class="pointer ml-15" :class="[channel==2? 'active': '']"><span >Client Channel</span></li>									
									</ul>							
								</div>
								<div  class="tab-content chatnav-room pt-10">
									<div v-if="channel==1" >
										<ul class="pl-0">
											<li v-for="job in jobs" class="media">																					
												<div class="display-block" >
													<div @click="activateJob(job)" :class="[(job.job_id==active_job.job_id && job.co_job_id ==active_job.co_job_id)? 'active': '']" class="display-block pointer">
														<job :job="job"></job>													
													</div>
												</div>											
												<ul v-if="job.relateds" class="mb-5" >
													<li v-for="subjob in job.relateds" @click="activateJob(subjob)"  v-if="subjob.job_id != job.job_id">
														<div :class="[(subjob.job_id==active_job.job_id && subjob.co_job_id ==active_job.co_job_id)? 'active': '']" class="display-block pointer pt-5"  >
															<job :job="subjob"></job>															
														</div>
													</li>												
												</ul>										
											</li>
										</ul>
									</div>
									<div v-if="channel==2"  >
										<ul class="mb-5" >
											<li v-for="project in projects" >
												<div @click="activateJob(project)" :class="[(project.job_id==active_job.job_id)? 'active': '']" class="pointer"  >
													<project :project="project"></project>
													
												</div>
											</li>												
										</ul>									
									</div>
								</div>
							
						</div>
						<div class="chatroom col-md-8 pr-0 pl-0 ml-0">
							<div v-if="channel==1">
								<div  v-if="active_job.job_id" class="chatroom-heading pl-5 pt-5">							   
									<span>									
										<span class="display-block fw-600">#{{active_job.job_id}} - {{active_job.jobable_type | capital}} {{active_job.name}}</span>
										<span class="fs-11 text-muted">Project {{active_job.project}}</span>								
									</span>						
								</div>							
								<div v-if="active_job.job_id" >						
									<chatlog 
										:job="active_job"
										>
									</chatlog>	
								</div>
							</div>
							<div v-if="channel==2">
								<div  v-if="active_job.job_id" class="chatroom-heading pl-5 pt-5">							   
									<span>									
										<span class="display-block fw-600" >#{{active_job.job_id}} - {{active_job.jobable_type | capital}} {{active_job.name}}</span>																		
									</span>						
								</div>							
								<div v-if="active_job.job_id" >						
									<chatlog2 
										:job="active_job"
										>
									</chatlog2>	
								</div>
							</div>
							
							<div id="chatroom-composer" v-if="active_job.job_id" >
								<form @submit.prevent="onSubmit"  method="post" >
									<div class="chat-composer" >
										<input class="msg-input"  name="message"  v-model="form.message"  rows="2" cols="1" placeholder="Enter your message...">
											<a class="chat-actions" @click="uploadFile" ><i class="icon-image4"></i></a>												
										</input>
										<input name="fileUpload" @change="onFileChange" id="file-input" class="chat-actions hidden" type="file" >									
										<button type="submit" class="btn btn-primary">Send</button>
									</div>
									<div class="row">
										<div class="col-xs-6">
											<ul class="icons-list icons-list-extended mt-10">
											</ul>
										</div>								
									</div>
								</form>
							</div>
						
						</div>
					</div>
				</div>
			</div>
		</div>	
	</div>
</template>

<script>
import chatlog from './chatlog';
import chatlog2 from './chatlog2';
import job from './job';
import project from './project';

export default {

	data() {
		return  {
			channel: hasRole(this.$store.state.user.roles, 'client')? 2: 1,
		    jobs: [],
			active_job: {
				job_id: null,
				name: null,
				relateds: []
			},
			projects: [],
			form: new Form({
				from_job_id: null,
				message: null,
				to: null,
				channel: null,
				private: null
			}),		

		}
	},	

    components: {
        chatlog,
		chatlog2,
		job,
		project
    },

	filters: {
		capital(val) {
			return capitalize(val);
		}
	},
    mounted() {
		this.getJobsByUser();
		// thís.getProjects();
	},

	computed: {
		user() {
			return this.$store.state.user;
		},
		sendable() {
			if(typeof this.active_job.to == 'object')
				return (this.active_job.to.length > 0)
			return (typeof this.active_job.to == 'number')

		}
		
	},


	methods: {
		getJobsByUser() {
            axios.get('/api/jobs')
                 .then(({data})=>{
				
                     if(!hasRole(this.$store.state.user.roles, 'client') )
						this.jobs = data.map((e)=>{
							if(e.info.jobable_type == 'project')
								this.projects.push({
									job_id: e.job_id,
									from_job_id: e.job_id,
									to: e.job_id,
									jobable_type: e.info.jobable_type,
									name: e.info.project.name,
									project: e.info.project,
									private: true});
							return {
								job_id: e.job_id,
								from_job_id: e.job_id,
								to: e.relateds.map(function(k){
									return k.id;
								}),	
								private: false,							
								name: e.info.jobable.name,
								jobable_type: e.info.jobable_type,
								title: e.info.jobable_type == 'project'? 'Project Mananger' : e.info.jobable_type == 'section'? 'Section Controller' : e.info.jobable_type == 'package'? 'Surveyor': '',
								project: e.info.project.name,
								from_date: e.info.from_date,
								to_date: e.info.to_date,								
								relateds: e.relateds.map(function(f){
									var x  = e;
									delete x.relateds;
									return {
										job_id: f.id,
										from_job_id: e.job_id,
										co_job_id: e.job_id,
										to: f.id,
										title: f.jobable_type == 'project'? 'Project Mananger' : f.jobable_type == 'section'? 'Section Controller' : f.jobable_type == 'package'? 'Surveyor': '',
									    relateds: [x],
										private: true,
										jobable_type: f.jobable_type,
										name: f.jobable.name,
										project: e.info.project.name
									}							
								}),
								status: e.info.status
							}
						});
					else //Case clients data is projects
						this.projects = data.map(function(e){
							return {
								job_id: e.job.id,
								from_job_id: e.job.id,
								to: e.job.id,
								jobable_type: e.job.jobable_type,
								name: e.name,
								project: {user_id: e.job.jobable.user_id},
								private: true
							}
								
						});
					
				})
                 .catch((error)=>console.log(error))
        },
	
		// getProjects() {
		// 	if(hasRole(this.$store.state.user.roles, 'client') )
        //     axios.get('/api/clients/projects')
        //          .then(({data})=> {
         
        //         this.projects = data.map(function(e){
					
        //             return {
        //                 id: e.id,
        //                 job_id: e.job.id,
        //                 name: e.name,
        //                 nation: e.nation.abbreviation,                   
        //                 industry: e.industry.name,
        //                 from: moment(e.job.from_date).format('YY/MM/DD'),
        //                 to: moment(e.job.to_date).format('YY/MM/DD'),
        //                 created: moment(e.created_at).format('YY/MM/DD'),
        //                 status: e.job.status
        //                 };
        //             });                                
        //     });
        // },
		
		activateJob(job) {	
			this.active_job = job;						
		},
	

		onSubmit() {
			{

				this.form.from_job_id = this.active_job.from_job_id;
				this.form.to = this.active_job.to;
				this.form.private = this.active_job.private;
				this.form.channel = this.channel;
				bus.$emit('newmessage', this.form);
				this.form.post('/api/messages')
						.then(({data})=>{                       
							bus.$emit('getmessages');
						})
						.catch((error)=>{

						});
				this.form.message = null;

			}
			// else {
			// 	if(this.messages.length == 0)
			// 	this.messages.push({message:{message: "No job is related to this job."}});
			// }
			
        },

		uploadFile() {	
			$("#file-input").click();
		},
	 	onFileChange (e) {		
			let files = e.target.files || e.dataTransfer.files

			if (!files.length) {
				return
			};

		    this.file = files[0]
			let formData = new FormData()
			formData.append('file', this.file)

			axios.post('/api/messages/files', formData)
				.then(({data})=>{
					this.form.message = '<img src="'+data.url+'" >';
					this.onSubmit();
					this.form.message = null;

				})
				.catch((error)=>{

				})     
      
        },
	
		selectChannel(e) {
			this.active_job = {};
			this.channel = parseInt(e);			
		}	
	}
}
</script>

<style lang="scss">
@import './../../../sass/_variables';
#chat-page {
	overflow: hidden;
	
}

#chat-page .chatnav,
#chat-page .chatroom {
    height: 100%;
    overflow: hidden;
}
#chat-page .chatnav {
	background-color: $default-bg;
}



#chat-page .chatnav .chatnav-heading,
#chat-page .chatroom .chatroom-heading {

	height: 40px;
	width: 100%;
	overflow: hidden;

}
#chat-page .chatnav .chatnav-heading ul.nav-tabs {
	border: none;
}
#chat-page .chatroom .chatroom-heading {
	border-bottom: solid 1px #ccc;
}

#chat-page .chatroom .chatroom-heading {
	/*border-bottom: solid 1px #ccc;*/
}

#chat-page .chatnav .chatnav-heading span{
	line-height: 37px;
}

#chat-page .chatnav .chatnav-room {
	position: relative;
	height: calc(100vh - 60px);
	width: 100%;
	overflow-y: auto;
}

#chat-page .chatnav .chatnav-room .active {
	border-right: solid 3px #ff9800;
}
#chat-page .chatnav .chatnav-heading li.active {
	border-bottom: solid 3px #ff9800;
}
#chat-page .chatnav .chatnav-room .active span:not([class*=text-muted]) {
	font-weight: 600;
}

#chat-page .chatroom .chatroom-heading span,
.chatnav-room span {
	line-height: 1 !important;
}
.chatnav-room li > div {
	height: 30px;
}

#chat-page .chat-composer {
    position: absolute;
	bottom: 0;
	display: flex;
	width: 100%;
	height: 30px;
	
}

#chat-page .chatroom-log {
	height: calc(100vh - 170px);
	overflow-y: auto; 
	padding-bottom: 80px;

}
.chatnav {
	line-height: 1 !important;
}
.chat-composer input {
    flex: 1 auto;
}
.chat-composer button {
    border-radius: 0;
}

.msg-composer {
	border: 1px solid #ccc;

	height: 30px;
}
.msg-input {
	/*border: none;*/
}
.msg-input {
	position: relative;
	/*background: transparent*/
}
.chat-actions {
	position:absolute;
	right: 60px;
	height: 100%;
	line-height: 30px;
}


 


</style>