import VueRouter from 'vue-router';
Vue.use(VueRouter);

let routes = [
  
    {
        path: '/',     
        component: require('./core/index.vue'),
        meta: { 
            display: "Dashboard",
            permission: 'any', 
            fail: './views/error'
        },      

        children: [
            {
                path: '',
                name: 'dashboard',
                component: require('./views/home.vue'),
                meta: { 
                    display: "Dash board",
                    permission: 'any', 
                    fail: './views/error'
                },

            },
             {
                path: '/mysettings',
                name: 'mysettings',
                component: require('./views/mysettings/mysettings.vue'),
                meta: { 
                    display: "Account Setting",
                    permission: 'superuser|client|surveyor|qto_controller|project_manager', 
                    fail: './views/error'
                },

            },
            {
                path: '/messenger',
                name: 'messenger',
                component: require('./views/chat/chat'),
                meta: { 
                    display: "Messsages",
                    permission: 'superuser|client|surveyor|qto_controller|project_manager', 
                    fail: './views/error'
                },
            }, 
            {
                path: '/forms',
                name: 'forms',
                component: require('./views/forms/forms'),
                meta: { 
                    display: "Forms",
                    permission: 'superuser|surveyor|qto_controller|project_manager', 
                    fail: './views/error'
                
                },
            },
            {
                path: '/myjobs',
                name: 'myjobs',
                component:require('./views/myjobs/jobs.vue'),
                meta: { 
                    display: "My Jobs",
                    permission: 'superuser|surveyor|qto_controller|project_manager',
                    fail: './views/error'
                }
                           
            }, 
            {
                path: '/bids',
                name: 'bids',
                component:require('./views/mybids/bids.vue'),
                meta: { 
                    display: "My Bids",
                    permission: 'superuser|surveyor|qto_controller|project_manager',
                    fail: './views/error'
                }
                           
            }, 
            {
                path: '/myjobs/:id',
                component: require('./views/myjobs/job.vue'),
                meta: { 
                    displa: 'Job',
                    permission: 'superuser|surveyor|qto_controller|project_manager',
                    fail: './views/error'},        
                    children: [
                    {
                        path: '',
                        name: 'myjob',
                        redirect: 'info',
                        meta: { 
                            display: "Job Information",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './views/error'
                        }
                    },
                    {
                        path:'info',
                        name:'myjob.info',
                        component:require('./views/myjobs/job/info.vue'),
                        meta: { 
                            display: "Job Information",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './views/error'
                        }
                    }, {
                        path: 'jwbs',
                        name:'myjob.jwbs',
                        component:require('./views/myjobs/job/jwbs.vue'),
                        meta: { 
                            display: "JWBS",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './views/error'
                        }
                    },  {
                        path: 'unitify',
                        name:'myjob.units',
                        component:require('./views/desk/projects//project/unitify.vue'),
                        meta: { 
                            display: "Units",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './views/error'
                        }
                    },  {
                        path: 'files',
                        name:'myjob.files',
                        component:require('./views/myjobs/files.vue'),
                        meta: { 
                            display: "Job Documents",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './views/error'
                        }
                    },  {
                        path: 'links', 
                        name:'myjob.links',
                        component:require('./views/myjobs/doclinks.vue'),
                        meta: { 
                            display: "Storage Links",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './views/error'
                        }
                    }, {
                        path: 'quantity',
                        name: 'myjob.quantity',
                        component: require('./views/myjobs/job/quantity'),
                        meta: { 
                            display: "Package Quantity",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './views/error'
                        }
                    }, {
                        path: 'summary',
                        name: 'myjob.summary',
                        component: require('./views/myjobs/job/summary'),
                        meta: { 
                            display: "Section Summary",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './views/error'
                        }
                    }, {
                        path: 'packages',
                        name: 'myjob.packages',
                        component: require('./views/myjobs/job/packages'),
                        meta: { 
                            display: "Section's Packages",
                            permission: 'superuser|qto_controller|project_manager',
                            fail: './views/error'
                        }
                    },  {
                        path: 'packages/:sid',
                        name: 'myjob.package',
                        component: require('./views/myjobs/job/packages/package'),
                        meta: { 
                            display: "Package Quantity Audit",
                            permission: 'superuser|qto_controller|project_manager',
                            fail: './views/error'
                        }
                    }, {
                        path: 'sections',
                        name: 'myjob.sections',
                        component: require('./views/myjobs/job/sections'),
                        meta: { 
                            display: "Project Sections",
                            permission: 'superuser|qto_controller|project_manager',
                            fail: './views/error'
                        }
                    },  {
                        
                        path: 'sections/:jid1',
                        name: 'myjob.section',
                        component: require('./views/myjobs/job/sections/section'),
                        meta: { 
                            display: "Section",
                            permission: 'superuser|qto_controller|project_manager',
                            fail: './views/error'
                        }
                    }, {
                        path: 'psum',
                        name: 'myjob.psum',
                        component: require('./views/myjobs/job/psum'),
                        meta: { 
                            display: "Project Summary",
                            permission: 'superuser|project_manager',
                            fail: './views/error'
                        }
                    }, {
                        path: 'reports',
                        name: 'myjob.reports',
                        component: require('./views/myjobs/job/reports'),
                        meta: { 
                            display: "Quantity Progressive Reports",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './views/error'
                        }
                    }, {
                        path: 'issues',
                        component: require('./views/myjobs/job/issues'),
                        children: [
                            {
                                path: '',
                                name: 'myjob.issues',
                                component: require('./views/issues/list'),
                                meta: { 
                                    display: "Issues",
                                    permission: 'superuser|surveyor|qto_controller|project_manager',
                                    fail: './views/error'
                               }
                            },{
                                path:'new',
                                name: 'myjob.issues.new',
                                component: require('./views/issues/new'),
                                meta: {
                                    display: "New Issues",
                                    parentName: 'myjob.issues',
                                    permission: 'superuser|surveyor|qto_controller|project_manager',
                                    fail: './views/error'
                                }
                               
                            }, {
                                path:':iid',
                                name: 'myjob.issues.issue',
                                component: require('./views/issues/issue'),
                                meta: {
                                    display: "Issue",
                                    parentName: 'myjob.issues',
                                    permission: 'superuser|surveyor|qto_controller|project_manager',
                                    fail: './views/error'
                                }
                            }, {
                                path: ':iid/edit',
                                name: 'myjob.issues.issue.edit',
                                component: require('./views/issues/edit'),
                                 meta: {
                                    display: "Edit Issue",
                                    parentName: 'myjob.issues',
                                    permission: 'superuser|surveyor|qto_controller|project_manager',
                                    fail: './views/error'
                                }
                            }
                        ]
                    }

                ]
            }, 
                {
                path: '/jobs',
                name: 'jobs',
                component: require('./views/jobs/jobs'),
                meta: { 
                    display: "Available Jobs",
                    permission: 'superuser|surveyor|qto_controller|project_manager',
                    fail: './views/error'
                
                },
                
            }, {
                path: '/jobs/:id',            
                component: require('./views/jobs/job'),
                meta: { 
                    display: "Job",
                    permission: 'superuser|surveyor|qto_controller|project_manager',
                    fail: './views/error'
                
                },
                children: [
                    {
                        path:'',
                        name:'job',
                        components: {
                            info:  require('./views/jobs/job/info'),
                            jwbs:  require('./views/jobs/job/jwbs')
                        },
                        meta: { 
                            display: "Job Information",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './views/error'
                        },
                    }, 
                    
                ]
            }, 
      
            {
                path: '/admin',
                component: require('./views/admin/admin'),
                meta: {display: 'Admin Dashboard'},
                children: [
                        {
                            path: 'roles',
                            name: 'roles',
                            component: require('./views/admin/roles/roles'),
                            meta: {
                                display: 'Roles',
                                permission: 'superuser|admin',
                                fail: './views/error'
                            },
                        },{
                            path: 'roles/:rid',
                            name: 'role.permissions',
                            component: require('./views/admin/roles/role'),
                            meta: {
                                display: "Role's Permissions",
                                permission: 'superuser|admin',
                                fail: './views/error'
                            },
                        }, {
                            path: 'users',
                            name: 'users',
                            component: require('./views/admin/users/users'),
                            meta: {
                                display: 'Users',
                                permission: 'superuser|admin',
                                fail: './views/error'
                            },
                        }, {
                            path: 'users/new',
                            name: 'users.new',
                            component: require('./views/admin/users/new'),
                            meta: {
                                display: 'New User',
                                permission: 'superuser|admin',
                                fail: './views/error'
                            },
                        },{
                            path: 'users/:uid',                           
                            component: require('./views/admin/users/user'),
                            children: [
                                 {
                                    path: '',
                                    redirect: 'info',
                                    meta: {
                                        display: 'Infomation',
                                        permission: 'superuser|admin',
                                        fail: './views/error'
                                    }
                                },
                                {
                                    path: 'info',
                                    name: 'users.user.info',
                                    component: require('./views/admin/users/user/info'),
                                    meta: {
                                        display: 'Infomation',
                                        permission: 'superuser|admin',
                                        fail: './views/error'
                                    }
                                },
                                {
                                    path: 'roles',
                                    name: 'users.user.roles',
                                    component: require('./views/admin/users/user/roles'),
                                    meta: {
                                        display: 'Roles',
                                        permission: 'superuser|admin',
                                        fail: './views/error'
                                    }
                                },
                                {
                                    path: 'jobs',
                                    name: 'users.user.jobs',
                                    component: require('./views/admin/users/user/jobs'),
                                    meta: {
                                        display: 'Jobs',
                                        permission: 'superuser|admin',
                                        fail: './views/error'
                                    }
                                },
                            ]
                        },  {
                            path: 'permissions',
                            name: 'admin.permissions',
                            component: require('./views/admin/permissions/permissions'),
                            meta: {
                                display: 'Permissions',
                                permission: 'superuser|admin',
                                fail: './views/error'
                            },
                        },  {
                            path: 'nations',
                            name: 'admin.nations',
                            component: require('./views/admin/nations'),
                            meta: {
                                display: 'Nations',
                                permission: 'superuser|admin',
                                fail: './views/error'
                            },
                        },   {
                            path: 'forms',
                            name: 'admin.forms',
                            component: require('./views/admin/forms/forms'),
                            meta: { 
                                display: "Forms",
                                permission: 'superuser|admin|surveyor|qto_controller, project_manager|director',
                                fail: './views/error'
                            },
                        },


                ]
            },
            { 
                path: '/desk',
                component: require('./views/desk/desk'),
                meta: { 
                    display: "Desk Management",
                    permission: 'superuser|project_director|sale_manager',
                    fail: './views/error'
                },
                children: [
                
                    {
                        path: 'clients',
                        name: 'desk.clients',
                        component: require('./views/desk/clients/clients'),
                        meta: { 
                            display: "Clients",                            
                            permission: 'superuser|project_director|sale_manager',
                            fail: './views/error'
                        },
                    }, {
                        path: 'clients/:uid',                        
                        component: require('./views/desk/clients/client'),
                        meta: { 
                            display: "Information",                            
                            permission: 'superuser|project_director|sale_manager',
                            fail: './views/error'
                        },
                        children: [
                            {
                                path: '',
                                name: 'desk.client',
                                redirect: 'info',
                            },
                            {
                                path: 'info',
                                name: 'desk.client.info',
                                component: require('./views/desk/clients/client/info'),
                                meta: {
                                     display: "Information",                            
                                     permission: 'superuser|project_director|sale_manager',
                                     fail: './views/error'
                                }
                            },

                            {
                                path: 'projects',
                                name: 'desk.client.projects',                                
                                component: require('./views/desk/clients/client/projects'),
                                meta: {
                                     display: "Projects",                            
                                     permission: 'superuser|project_director|sale_manager',
                                     fail: './views/error'
                                }
                            },
                            

                        ]
                    
                    } , {
                        path: 'wbs',
                        name: 'desk.wbs',
                        component: require('./views/desk/wbs/wbs'),
                        meta: { 
                            display: "Global WBS",
                            permission: 'superuser|project_director|sale_manager',
                            fail: './views/error'
                        },
                    }, {
                        path: 'jobs',
                        name: 'desk.jobs',
                        component: require('./views/desk/jobs/jobs'),
                        meta: { 
                            display : "Jobs",
                            permission: 'superuser|project_director|sale_manager',
                            fail: './views/error'
                        },
                        
                    },{
                        path: 'jobs/:id',                        
                        component: require('./views/desk/jobs/job'),
                        meta: { 
                            display : "Job Information",
                            permission: 'superuser|project_director|sale_manager',
                            fail: './views/error'
                        },
                        children: [
                            {
                                path: '',
                                name: 'desk.job',
                                redirect: 'info',
                                meta: { 
                                    display : "Job Information",
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './views/error'
                                },
                            },
                             {
                                path: 'info',
                                name: 'desk.job.info',
                                component: require('./views/desk/jobs/job/info'),
                                meta: { 
                                    display : "Job Infomation",
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './views/error'
                                },
                            },
                            {
                                path: 'Jwbs',
                                name: 'desk.job.jwbs',
                                component: require('./views/desk/jobs/job/jwbs'),
                                meta: { 
                                    display : "Jwbs",
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './views/error'
                                },
                            },
                             {
                                path: 'bids',
                                name: 'desk.job.bids',
                                component: require('./views/desk/jobs/job/bids'),
                                meta: { 
                                    display : "Bids",
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './views/error'
                                },
                            },
                        ]
                    }, {
                        path: 'projects',   
                        name: 'desk.projects',   
                        component: require('./views/desk/projects/projects.vue'),
                        meta: {
                            display: 'Projects',
                            permission: 'superuser|project_director|sale_manager',
                            fail: './views/error'
                        }
                    },{
                        path: 'projects/new',
                        name: 'desk.projects.new',
                        component: require('./views/desk/projects/new'),
                        meta: {
                            display: 'New Project',
                            permission: 'superuser|project_director|sale_manager',
                            fail: './views/error'
                        }
                    }, {
                        path: 'projects/:pid',
                        component: require('./views/desk/projects/project'),
                        meta: {
                            display: 'Project',
                            permission: 'superuser|project_director|sale_manager',
                            fail: './views/error'
                        },
                        children: [
                            {
                                path: '',
                                name: 'desk.project',
                                redirect: 'info',
                                meta: {
                                    display: 'Project Overview',
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './views/error'

                                }
                            },
                                
                            {
                                path: 'info',
                                name: 'desk.project.info',
                                component: require('./views/desk/projects/project/info'),
                                meta: {
                                    display: 'Project Information',
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './views/error'

                                }
                            }, {
                                path: 'pwbs',
                                name: 'desk.project.pwbs',
                                component: require('./views/desk/projects/project/pwbs'),
                                meta: {
                                    display: 'PWBS',
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './views/error'
                                }
                            }, {
                                path: 'units',
                                name: 'desk.project.units',
                                component:require('./views/desk/projects/project/unitify.vue'),
                                meta: { 
                                    display: "Units",
                                    permission: 'superuser|project_manager|project_director',
                                    fail: './views/error'
                                }
                            }, {
                                path: 'files',
                                name: 'desk.project.files',
                                component: require('./views/desk/projects/project/docs'),
                                meta: {
                                    display: 'Project Documents',
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './views/error'
                                }
                            }, {
                                path: 'links',
                                name: 'desk.project.links',
                                component: require('./views/desk/projects/project/doclinks'),
                                meta: {
                                    display: 'Cloud Storage Links',
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './views/error'

                                }
                            }, {
                                path: 'sections', 
                                name: 'desk.project.sections',     
                                component: require('./views/desk/projects/project/sections'),
                                meta: {
                                    display: 'Sections',
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './views/error'

                                }
                              
                            }, {
                                path: 'sections/:sid',               
                                component: require('./views/desk/projects/project/section'),
                                meta: {
                                    
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './views/error'
                                },
                                children: [
                                       {
                                                path: '',
                                                redirect:'packages'
                                        },
                                        {
                                                path: 'packages',
                                                name: 'desk.project.section.packages',
                                                component: require('./views/desk/projects/project/section/packages'),
                                                meta: {
                                                    display: "Packages",
                                                    permission: 'superuser|project_director|sale_manager',
                                                    fail: './views/error'
                                                }
                                        }, {
                                                path: 'swbs',
                                                name: 'desk.project.section.gwbs',
                                                component: require('./views/desk/projects/project/section/swbs'),
                                                meta: {
                                                    display: "Swbs",
                                                    permission: 'superuser|project_director|sale_manager',
                                                    fail: './views/error'
                                                }
                                            }, 
                                            
                                ]
                            },{
                                path: 'org',
                                name: 'desk.project.org',
                                component: require('./views/desk/projects/project/org'),
                                meta: {
                                    display: "Project Organization",
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './views/error'
                                }
                            }, {
                                path: 'reports',
                                name: 'desk.project.reports',
                                component: require('./views/desk/projects/project/reports'),
                                meta: {
                                    display: "Reports",
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './views/error'
                                }
                            }, {
                                path: 'quantity',
                                name: 'desk.project.quantity',
                                component: require('./views/desk/projects/project/quantity'),
                                meta: {
                                    display: "Quantity",
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './views/error'
                                }
                            }
                        ]
                    }, {
                        path: 'leads',
                        name: 'desk.leads',
                        component: require('./views/desk/leads/leads'),
                        meta: {
                            display: 'Leads',
                            permission: 'superuser|sale_manager',
                            fail: './views/error'
                        }
                    }
                ]
            }, 
            {
            
                path: '/clients',
                component: require('./views/clients/client'),
                meta: {
                    display: "Dashboard",
                    permission: 'superuser|client',
                    fail: './views/error'                    
                },
                children: [            
                            {
                                    name: 'client.projects',
                                    path: '/clients/projects',
                                    component: require('./views/clients/client/projects'),
                                    meta: {
                                        display: "Projects",
                                        permission: 'superuser|client',
                                        fail: './views/error' 
                                    }
                                                
                            }, {
                                    name: 'client.projects.new',
                                    path: '/clients/projects/new',
                                    component: require('./views/clients/client/new'),
                                    meta: {
                                        display: "New Projects",
                                        permission: 'superuser|client',
                                        fail: './views/error' 
                                    }
                                                
                            }, {
                                    path:'/clients/projects/:pid', 
                                    component: require('./views/clients/client/project'),                                                            
                                    children: [
                                        {
                                            path: '',
                                            redirect: 'info',
                                            meta: {
                                                display: "Project Information",
                                                permission: 'superuser|client',
                                                fail: './views/error' 
                                           }
                                        }, {
                                            path: 'info',
                                            name: 'client.project.info',
                                            component: require('./views/desk/projects/project/info'),
                                            meta: {
                                                display: "Information",
                                                permission: 'superuser|client',
                                                fail: './views/error' 
                                            }
                                        }, {
                                            path: 'pwbs',
                                            name: 'client.project.pwbs',
                                            component: require('./views/clients/client/pwbs'),
                                            meta: {
                                                display: "PWBS",
                                                permission: 'superuser|client',
                                                fail: './views/error' 
                                            }
                                        }, {
                                            path: 'files',
                                            name: 'client.project.files',
                                            component: require('./views/desk/projects/project/docs'),
                                            meta: {
                                                display: "Documents",
                                                permission: 'superuser|client',
                                                fail: './views/error' 
                                            }
                                        }, {
                                            path: 'links',
                                            name: 'client.project.links',
                                            component: require('./views/desk/projects/project/doclinks'),
                                            meta: {
                                                display: "Cloud Storage Links",
                                                permission: 'superuser|client',
                                                fail: './views/error' 
                                           }
                                        }, {
                                            path: 'reports',
                                            name: 'client.project.reports',
                                            component: require('./views/desk/projects/project/reports'),
                                            meta: {
                                                display: "Quantity Reports",
                                                permission: 'superuser|client',
                                                fail: './views/error' 
                                            }
                                        }, {
                                            path: 'quantity',
                                            name: 'client.project.quantity',
                                            component: require('./views/clients/client/project/quantity'),
                                            meta: {
                                                display: "Quantity",
                                                permission: 'superuser|client',
                                                fail: './views/error' 
                                            }
                                        },{
                                            path:'issues',                                                    
                                            component: require('./views/clients/client/issues'),
                                            meta: {
                                                display: "Issues",
                                                permission: 'superuser|client',
                                                fail: './views/error' 
                                            },
                                            children: [
                                                {
                                                    path: '',
                                                    name: 'client.project.issues',
                                                    component: require('./views/issues/list'),
                                                    meta: {
                                                        display: "Project Issues",
                                                        permission: 'superuser|client',
                                                        fail: './views/error' 
                                                    }
                                                }, {
                                                    path: 'new',
                                                    name: 'client.project.issues.new',
                                                    component: require('./views/issues/new'),
                                                    meta: {
                                                        display: "Open New Issue",
                                                        permission: 'superuser|client',
                                                        fail: './views/error' 
                                                    }
                                                },{
                                                    path: ':iid',
                                                    name: 'client.project.issues.issue',
                                                    component: require('./views/issues/issue'),
                                                    meta: {
                                                        display: "Issue",
                                                        parentName: 'client.project.issues',
                                                        permission: 'superuser|client',
                                                        fail: './views/error' 
                                                    }
                                                }, {
                                                    path: ':iid/edit',
                                                    name: 'client.project.issues.issue.edit',
                                                    component: require('./views/issues/edit'),
                                                    meta: {
                                                        display: "Edit Issue",                                                      
                                                        permission: 'superuser|client',
                                                        fail: './views/error'
                                                    }
                                                }
                                            ]
                                        }                        

                                    ]
                            }, 
                        ]
            },
            
        ]
    }       
   
];

export default new VueRouter({
    mode: 'history',
    linkActiveClass: 'relative-active',
    routes  
    
   
});

// export default Router;