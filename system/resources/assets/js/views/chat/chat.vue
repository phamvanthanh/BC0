<template>					<!-- User menu -->

	<div class="content-wrapper">
		<div class="page-header">
			<div class="page-header-content">
				<div class="page-title">
					 <page-label></page-label>
				</div>

				<div class="heading-elements">
					<div class="heading-btn-group">
						
					</div>
				</div>
			</div>		
		</div>
	
		<div class="content" id="chat-page">
			<div  class="panel panel-flat" style="height: 100%">		

				 <div class="panel-body pt-0 pl-0 pr-10" style="height: 100%">
					 <div class="row" style="height: 100%" >
						<div class="chatnav col-md-3 pr-0 mr-0">						
							<!--USER NAVIGATION-->
							<contact-nav></contact-nav>
							
						</div>
						<div class="chatroom col-md-9 pr-0 pl-0 ml-0" v-if="activecontact.recipient_id" >
							
							<chat-log 
								v-if="activecontact.recipient_id"								
								:contact="activecontact"
							>
							</chat-log>	
							
							<div id="chatroom-composer" >
								<chat-composer     								
									:contact="activecontact"
								>
								</chat-composer>
							</div>
						
						</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>
</template>

<script>

import contactNav from './contactnav';
import chatComposer from './chatcomposer';
import chatLog from './chatlog';

export default {

	data() {
		return  {
			channel: hasRole(this.$store.state.user.roles, 'client')? 2: 1,
		 
			activecontact: {
				sender_id: null,
				recipient_id: null,
				first_name: null,
				last_name: null,
				status: null
			},
		
			form: new Form({
				from_job_id: null,
				message: null,
				to: null,
				channel: null,
				private: null
			}),		

		}
	},	
	created() {

		bus.$on('activecontact', (e)=>{		
			this.activecontact = e;
        });
	},


    components: {
        contactNav,
		chatComposer,
		chatLog,
		
    },

	filters: {
		capital(val) {
			return capitalize(val);
		}
	},
	methods: {
		
		
		
	}
}
</script>

<style lang="scss">
@import './../../../sass/components/_variables';


#chat-page .chatnav,
#chat-page .chatroom {
    height: 100%;
    overflow: hidden;
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




#chat-page .chatnav .chatnav-heading span{
	line-height: 37px;
}

#chat-page .chatnav .chatnav-room {
	position: relative;
	height: calc(100vh - 60px);
	width: 100%;
	overflow-y: auto;
}


#chat-page .chatnav .chatnav-room .active span:not([class*=text-muted]) {
	font-weight: 600;
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