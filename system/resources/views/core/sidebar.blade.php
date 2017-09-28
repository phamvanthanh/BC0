@if(Auth::check())

	<div class="sidebar sidebar-main">
		<div class="sidebar-content">
			<!-- User menu -->
		
			<div class="sidebar-category sidebar-category-visible">
				<div class="category-content no-padding">
					<ul class="navigation navigation-main navigation-accordion">

						<!-- Main -->
						<li><router-link to="/"><i class="icon-home4"></i> <span>Dashboard</span></router-link></li>
						@if($user->hasRole('superuser')
						|| $user->hasRole('surveyor')
						|| $user->hasRole('qto_controller')
						|| $user->hasrole('project_manager'))							
						<li><router-link to="/jobs"><i class="icon-drawer3"></i><span>My Jobs</span></router-link></li>							
						<li><router-link to="/works"><i class="icon-paperplane"></i><span>Jobs</span></router-link></li>
						@endif
						
						<!--Sales, Director, Accounting Shared sections -->
						@if($user->hasRole('superuser')
						|| $user->hasRole('sale_manager') 
						|| $user->hasRole('superuser') 
						|| $user->hasRole('project_director'))
						<li  >
							<a   href="#" ><i class="icon-spinner4"></i> <span>Desk</span></a>
							<ul>
								@if($user->hasRole('superuser')
								|| $user->hasRole('sale_manager'))
								<li><router-link to="/desk/contracts">Contracts</router-link></li>
								<li><router-link to="/desk/invoces">Invoices</router-link></li>								
								<li><router-link to="/desk/quoations">Quotations</router-link></li>
								@endif
								
								<!--Director, sales sections, -->
								
								<li><router-link to="/desk/projects">Projects</router-link></li>
								<li><router-link to="/desk/projects/new">New Project</router-link></li>
								
								<!--Director -->
								<li><router-link to="/desk/works">Works</router-link></li>								
								<li><router-link to="/desk/clients">Clients</router-link></li>
								<li><router-link to="/desk/wbs">Wbs</router-link></li>
							</ul>
						</li>

						@endif

						<!--Admin section -->
						@if($user->hasRole('admin') || $user->hasRole('superuser'))
						<li >
							<a href="#"><i class="icon-cogs"></i> <span>Admin</span></a>
							<ul>
								<li><router-link to="/admin/users">Users</router-link></li>										
								<li><router-link to="/admin/roles">Roles</router-link></li>									
								<li><router-link to="/admin/permissions">Permissions</router-link></li>	
								<li><router-link to="/admin/nations">Nations</router-link></li>	
							</ul>	
						</li>
						@endif

						@if($user->hasRole('superuser')
						|| $user->hasRole('client') )
							
							<li >
								<a href="#"><i class="icon-user-tie"></i> <span>Clients</span></a>
								<ul>
									<li><router-link to="/clients/projects">Projects</router-link></li>		
									<li><router-link to="/clients/projects/new">New Project</router-link></li>					
										
								</ul>	
							</li>
						@endif						
					</ul>
				</div>
			</div>
		</div>
	</div>

@endif
