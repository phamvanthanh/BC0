import VueRouter from 'vue-router';
Vue.use(VueRouter);

let routes = [
    {
        path: '/api',
        redirect: 'error',

    },
    {
        path: '',     
        component: require('./core/index.vue'),
        meta: { 
            display: "Dashboard",
            permission: 'any|superuser|project_manager|qto_controller|surveyor|client', 
            fail: './error'
        }, 
             

        children: [
            {
                path: '',
                name: 'dashboard',
                component: require('./views/home.vue'),
                meta: { 
                    display: "Dash board",
                    permission: 'any|superuser|project_manager|qto_controller|surveyor|client', 
                    fail: './error'
                }

            },
             
            {
                path: '/error',
                name: 'error',
                component: require('./views/error.vue'),
                meta: { 
                    display: "Access Error ",
                    permission: 'any|superuser|project_manager|qto_controller|surveyor|client', 
                    fail: './error'
                },

            },
             {
                path: '/settings',
                name: 'settings',
                component: require('./views/mysettings/mysettings.vue'),
                meta: { 
                    display: "Account Setting",
                    permission: 'superuser|project_manager|qto_controller|surveyor|client', 
                    fail: './error'
                },

            },
            {
                path: '/messenger',
                name: 'messenger',
                component: require('./views/chat/chat'),
                meta: { 
                    display: "Messsages",
                    permission: 'superuser|client|surveyor|qto_controller|project_manager', 
                    fail: './error'
                },
            }, 
            {
                path: '/forms',
                name: 'forms',
                component: require('./views/forms/forms'),
                meta: { 
                    display: "Forms",
                    permission: 'superuser|surveyor|qto_controller|project_manager', 
                    fail: './error'
                
                },
            },
            {
                path: '/my_jobs',
                name: 'my_jobs',
                component:require('./views/my_jobs/jobs.vue'),
                meta: { 
                    display: "My Jobs",
                    permission: 'superuser|surveyor|qto_controller|project_manager',
                    fail: './error'
                }
                           
            }, 
            {
                path: '/bids',
                name: 'bids',
                component:require('./views/mybids/bids.vue'),
                meta: { 
                    display: "My Bids",
                    permission: 'superuser|surveyor|qto_controller|project_manager',
                    fail: './error'
                }
                           
            }, 
            {
                path: '/my_jobs/:id',
                component: require('./views/my_jobs/job.vue'),
                meta: { 
                    displa: 'Job',
                    permission: 'superuser|surveyor|qto_controller|project_manager',
                    fail: './error'},        
                    children: [
                    {
                        path: '',
                        name: 'my_job',
                        redirect: 'info',
                        meta: { 
                            display: "Job Information",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './error'
                        }
                    },
                    {
                        path:'info',
                        name:'my_job.info',
                        component:require('./views/my_jobs/job/info.vue'),
                        meta: { 
                            display: "Job Information",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './error'
                        }
                    }, {
                        path: 'jwbs',
                        name:'my_job.jwbs',
                        component:require('./views/my_jobs/job/jwbs.vue'),
                        meta: { 
                            display: "JWBS",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './error'
                        }
                    },  {
                        path: 'unitify',
                        name:'my_job.units',
                        component:require('./views/desk/projects/project/unitify.vue'),
                        meta: { 
                            display: "Units",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './error'
                        }
                    },  {
                        path: 'files',
                        name:'my_job.files',
                        component:require('./views/my_jobs/files.vue'),
                        meta: { 
                            display: "Job Documents",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './error'
                        }
                    },  {
                        path: 'links', 
                        name:'my_job.links',
                        component:require('./views/my_jobs/doclinks.vue'),
                        meta: { 
                            display: "Storage Links",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './error'
                        }
                    }, {
                        path: 'org',
                        name: 'my_job.org',
                        component: require('./views/desk/projects/project/org'),
                        meta: {
                            display: "Project Tree Map",
                            permission: 'project_manager',
                            fail: './error'
                        },
                    },{
                        path: 'quantity',
                        name: 'my_job.quantity',
                        component: require('./views/my_jobs/job/quantity'),
                        meta: { 
                            display: "Package Quantity",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './error'
                        }
                    }, {
                        path: 'summary',
                        name: 'my_job.summary',
                        component: require('./views/my_jobs/job/summary'),
                        meta: { 
                            display: "Section Summary",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './error'
                        }
                    }, {
                        path: 'packages',
                        name: 'my_job.packages',
                        component: require('./views/my_jobs/job/packages'),
                        meta: { 
                            display: "Section's Packages",
                            permission: 'superuser|qto_controller|project_manager',
                            fail: './error'
                        }
                    },  {
                        path: 'packages/:sid',
                        name: 'my_job.package',
                        component: require('./views/my_jobs/job/packages/package'),
                        meta: { 
                            display: "Package Quantity Audit",
                            permission: 'superuser|qto_controller|project_manager',
                            fail: './error'
                        }
                    }, {
                        path: 'sections',
                        name: 'my_job.sections',
                        component: require('./views/my_jobs/job/sections'),
                        meta: { 
                            display: "Project Sections",
                            permission: 'superuser|qto_controller|project_manager',
                            fail: './error'
                        }
                    },  {
                        
                        path: 'sections/:jid1',
                        name: 'my_job.section',
                        component: require('./views/my_jobs/job/sections/section'),
                        meta: { 
                            display: "Section",
                            permission: 'superuser|qto_controller|project_manager',
                            fail: './error'
                        }
                    }, {
                        path: 'psum',
                        name: 'my_job.psum',
                        component: require('./views/my_jobs/job/psum'),
                        meta: { 
                            display: "Project Summary",
                            permission: 'superuser|project_manager',
                            fail: './error'
                        }
                    }, {
                        path: 'reports',
                        name: 'my_job.reports',
                        component: require('./views/my_jobs/job/reports'),
                        meta: { 
                            display: "Quantity Reports",
                            permission: 'superuser|surveyor|qto_controller|project_manager',
                            fail: './error'
                        }
                    }, {
                        path: 'issues',
                        component: require('./views/my_jobs/job/issues'),
                        children: [
                            {
                                path: '',
                                name: 'my_job.issues',
                                component: require('./views/issues/list'),
                                meta: { 
                                    display: "Issues",
                                    permission: 'superuser|surveyor|qto_controller|project_manager',
                                    fail: './error'
                               }
                            },{
                                path:'new',
                                name: 'my_job.issues.new',
                                component: require('./views/issues/new'),
                                meta: {
                                    display: "New Issues",
                                    parentName: 'my_job.issues',
                                    permission: 'superuser|surveyor|qto_controller|project_manager',
                                    fail: './error'
                                }
                               
                            }, {
                                path:':iid',
                                name: 'my_job.issues.issue',
                                component: require('./views/issues/issue'),
                                meta: {
                                    display: "Issue",
                                    parentName: 'my_job.issues',
                                    permission: 'superuser|surveyor|qto_controller|project_manager',
                                    fail: './error'
                                }
                            }, {
                                path: ':iid/edit',
                                name: 'my_job.issues.issue.edit',
                                component: require('./views/issues/edit'),
                                 meta: {
                                    display: "Edit Issue",
                                    parentName: 'my_job.issues',
                                    permission: 'superuser|surveyor|qto_controller|project_manager',
                                    fail: './error'
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
                    fail: './error'
                
                },
                
            }, {
                path: '/jobs/:id',            
                component: require('./views/jobs/job'),
                meta: { 
                    display: "Job",
                    permission: 'superuser|surveyor|qto_controller|project_manager',
                    fail: './error'
                
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
                            fail: './error'
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
                                fail: './error'
                            },
                        },{
                            path: 'roles/:rid',
                            name: 'role.permissions',
                            component: require('./views/admin/roles/role'),
                            meta: {
                                display: "Role's Permissions",
                                permission: 'superuser|admin',
                                fail: './error'
                            },
                        }, {
                            path: 'users',
                            name: 'users',
                            component: require('./views/admin/users/users'),
                            meta: {
                                display: 'Users',
                                permission: 'superuser|admin',
                                fail: './error'
                            },
                        }, {
                            path: 'users/new',
                            name: 'users.new',
                            component: require('./views/admin/users/new'),
                            meta: {
                                display: 'New User',
                                permission: 'superuser|admin',
                                fail: './error'
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
                                        fail: './error'
                                    }
                                },
                                {
                                    path: 'info',
                                    name: 'users.user.info',
                                    component: require('./views/admin/users/user/info'),
                                    meta: {
                                        display: 'Infomation',
                                        permission: 'superuser|admin',
                                        fail: './error'
                                    }
                                },
                                {
                                    path: 'roles',
                                    name: 'users.user.roles',
                                    component: require('./views/admin/users/user/roles'),
                                    meta: {
                                        display: 'Roles',
                                        permission: 'superuser|admin',
                                        fail: './error'
                                    }
                                },
                                {
                                    path: 'jobs',
                                    name: 'users.user.jobs',
                                    component: require('./views/admin/users/user/jobs'),
                                    meta: {
                                        display: 'Jobs',
                                        permission: 'superuser|admin',
                                        fail: './error'
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
                                fail: './error'
                            },
                        },  {
                            path: 'nations',
                            name: 'admin.nations',
                            component: require('./views/admin/nations'),
                            meta: {
                                display: 'Nations',
                                permission: 'superuser|admin',
                                fail: './error'
                            },
                        },   {
                            path: 'forms',
                            name: 'admin.forms',
                            component: require('./views/admin/forms/forms'),
                            meta: { 
                                display: "Forms",
                                permission: 'superuser|admin|surveyor|qto_controller, project_manager|director',
                                fail: './error'
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
                    fail: './error'
                },
                children: [
                
                    {
                        path: 'clients',
                        name: 'desk.clients',
                        component: require('./views/desk/clients/clients'),
                        meta: { 
                            display: "Clients",                            
                            permission: 'superuser|project_director|sale_manager',
                            fail: './error'
                        },
                    }, {
                        path: 'clients/:uid',                        
                        component: require('./views/desk/clients/client'),
                        meta: { 
                            display: "Information",                            
                            permission: 'superuser|project_director|sale_manager',
                            fail: './error'
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
                                     fail: './error'
                                }
                            },

                            {
                                path: 'projects',
                                name: 'desk.client.projects',                                
                                component: require('./views/desk/clients/client/projects'),
                                meta: {
                                     display: "Projects",                            
                                     permission: 'superuser|project_director|sale_manager',
                                     fail: './error'
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
                            fail: './error'
                        },
                    }, {
                        path: 'jobs',
                        name: 'desk.jobs',
                        component: require('./views/desk/jobs/jobs'),
                        meta: { 
                            display : "Jobs",
                            permission: 'superuser|project_director|sale_manager',
                            fail: './error'
                        },
                        
                    },{
                        path: 'jobs/:id',                        
                        component: require('./views/desk/jobs/job'),
                        meta: { 
                            display : "Job Information",
                            permission: 'superuser|project_director|sale_manager',
                            fail: './error'
                        },
                        children: [
                            {
                                path: '',
                                name: 'desk.job',
                                redirect: 'info',
                                meta: { 
                                    display : "Job Information",
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './error'
                                },
                            },
                             {
                                path: 'info',
                                name: 'desk.job.info',
                                component: require('./views/desk/jobs/job/info'),
                                meta: { 
                                    display : "Job Infomation",
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './error'
                                },
                            },
                            {
                                path: 'Jwbs',
                                name: 'desk.job.jwbs',
                                component: require('./views/desk/jobs/job/jwbs'),
                                meta: { 
                                    display : "Jwbs",
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './error'
                                },
                            },
                             {
                                path: 'bids',
                                name: 'desk.job.bids',
                                component: require('./views/desk/jobs/job/bids'),
                                meta: { 
                                    display : "Bids",
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './error'
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
                            fail: './error'
                        }
                    },{
                        path: 'projects/new',
                        name: 'desk.projects.new',
                        component: require('./views/desk/projects/new'),
                        meta: {
                            display: 'New Project',
                            permission: 'superuser|project_director|sale_manager',
                            fail: './error'
                        }
                    }, {
                        path: 'projects/:pid',
                        component: require('./views/desk/projects/project'),
                        meta: {
                            display: 'Project',
                            permission: 'superuser|project_director|sale_manager',
                            fail: './error'
                        },
                        children: [
                            {
                                path: '',
                                name: 'desk.project',
                                redirect: 'info',
                                meta: {
                                    display: 'Project Overview',
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './error'

                                }
                            },
                                
                            {
                                path: 'info',
                                name: 'desk.project.info',
                                component: require('./views/desk/projects/project/info'),
                                meta: {
                                    display: 'Project Information',
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './error'

                                }
                            }, {
                                path: 'pwbs',
                                name: 'desk.project.pwbs',
                                component: require('./views/desk/projects/project/pwbs'),
                                meta: {
                                    display: 'PWBS',
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './error'
                                }
                            }, {
                                path: 'units',
                                name: 'desk.project.units',
                                component:require('./views/desk/projects/project/unitify.vue'),
                                meta: { 
                                    display: "Units",
                                    permission: 'superuser|project_manager|project_director',
                                    fail: './error'
                                }
                            }, {
                                path: 'files',
                                name: 'desk.project.files',
                                component: require('./views/desk/projects/project/docs'),
                                meta: {
                                    display: 'Project Documents',
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './error'
                                }
                            }, {
                                path: 'links',
                                name: 'desk.project.links',
                                component: require('./views/desk/projects/project/doclinks'),
                                meta: {
                                    display: 'Storage Links',
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './error'

                                }
                            }, {
                                path: 'sections', 
                                name: 'desk.project.sections',     
                                component: require('./views/desk/projects/project/sections'),
                                meta: {
                                    display: 'Sections',
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './error'

                                }
                              
                            }, {
                                path: 'sections/:sid',               
                                component: require('./views/desk/projects/project/section'),
                                meta: {
                                    
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './error'
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
                                                    fail: './error'
                                                }
                                        }, {
                                                path: 'swbs',
                                                name: 'desk.project.section.gwbs',
                                                component: require('./views/desk/projects/project/section/swbs'),
                                                meta: {
                                                    display: "Swbs",
                                                    permission: 'superuser|project_director|sale_manager',
                                                    fail: './error'
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
                                    fail: './error'
                                }
                            }, {
                                path: 'reports',
                                name: 'desk.project.reports',
                                component: require('./views/desk/projects/project/reports'),
                                meta: {
                                    display: "Reports",
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './error'
                                }
                            }, {
                                path: 'quantity',
                                name: 'desk.project.quantity',
                                component: require('./views/desk/projects/project/quantity'),
                                meta: {
                                    display: "Quantity",
                                    permission: 'superuser|project_director|sale_manager',
                                    fail: './error'
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
                            fail: './error'
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
                    fail: './error'                    
                },
                children: [            
                            {
                                    name: 'client.projects',
                                    path: '/clients/projects',
                                    component: require('./views/clients/client/projects'),
                                    meta: {
                                        display: "Projects",
                                        permission: 'superuser|client',
                                        fail: './error' 
                                    }
                                                
                            }, {
                                    name: 'client.projects.new',
                                    path: '/clients/projects/new',
                                    component: require('./views/clients/client/new'),
                                    meta: {
                                        display: "New Projects",
                                        permission: 'superuser|client',
                                        fail: './error' 
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
                                                fail: './error' 
                                           }
                                        }, {
                                            path: 'info',
                                            name: 'client.project.info',
                                            component: require('./views/desk/projects/project/info'),
                                            meta: {
                                                display: "Information",
                                                permission: 'superuser|client',
                                                fail: './error' 
                                            }
                                        }, {
                                            path: 'pwbs',
                                            name: 'client.project.pwbs',
                                            component: require('./views/clients/client/pwbs'),
                                            meta: {
                                                display: "PWBS",
                                                permission: 'superuser|client',
                                                fail: './error' 
                                            }
                                        }, {
                                            path: 'files',
                                            name: 'client.project.files',
                                            component: require('./views/desk/projects/project/docs'),
                                            meta: {
                                                display: "Documents",
                                                permission: 'superuser|client',
                                                fail: './error' 
                                            }
                                        }, {
                                            path: 'links',
                                            name: 'client.project.links',
                                            component: require('./views/desk/projects/project/doclinks'),
                                            meta: {
                                                display: "Cloud Storage Links",
                                                permission: 'superuser|client',
                                                fail: './error' 
                                           }
                                        }, {
                                            path: 'reports',
                                            name: 'client.project.reports',
                                            component: require('./views/desk/projects/project/reports'),
                                            meta: {
                                                display: "Quantity Reports",
                                                permission: 'superuser|client',
                                                fail: './error' 
                                            }
                                        }, {
                                            path: 'quantity',
                                            name: 'client.project.quantity',
                                            component: require('./views/clients/client/project/quantity'),
                                            meta: {
                                                display: "Quantity",
                                                permission: 'superuser|client',
                                                fail: './error' 
                                            }
                                        },{
                                            path:'issues',                                                    
                                            component: require('./views/clients/client/issues'),
                                            meta: {
                                                display: "Issues",
                                                permission: 'superuser|client',
                                                fail: './error' 
                                            },
                                            children: [
                                                {
                                                    path: '',
                                                    name: 'client.project.issues',
                                                    component: require('./views/issues/list'),
                                                    meta: {
                                                        display: "Project Issues",
                                                        permission: 'superuser|client',
                                                        fail: './error' 
                                                    }
                                                }, {
                                                    path: 'new',
                                                    name: 'client.project.issues.new',
                                                    component: require('./views/issues/new'),
                                                    meta: {
                                                        display: "Open New Issue",
                                                        permission: 'superuser|client',
                                                        fail: './error' 
                                                    }
                                                },{
                                                    path: ':iid',
                                                    name: 'client.project.issues.issue',
                                                    component: require('./views/issues/issue'),
                                                    meta: {
                                                        display: "Issue",
                                                        parentName: 'client.project.issues',
                                                        permission: 'superuser|client',
                                                        fail: './error' 
                                                    }
                                                }, {
                                                    path: ':iid/edit',
                                                    name: 'client.project.issues.issue.edit',
                                                    component: require('./views/issues/edit'),
                                                    meta: {
                                                        display: "Edit Issue",                                                      
                                                        permission: 'superuser|client',
                                                        fail: './error'
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