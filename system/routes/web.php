<?php

use system\Http\Controllers\UsersController;


/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
/*
|--------------------------------------------------------------------------
| Login, Logout
|--------------------------------------------------------------------------
*/

// Route::get('/login', ['uses'=>'Auth\LoginController@create'])->name('login');
// Route::post('/login', ['uses'=>'Auth\SessionController@store']);

Auth::routes();




// Route::get('/logout', ['uses'=>'Auth\SessionController@destroy']);
/*
|--------------------------------------------------------------------------
| Registration 
|--------------------------------------------------------------------------
*/

// Route::get('/register', ['uses'=>'Auth\RegistrationController@index'])->name('register');
// Route::post('/register/store', ['uses'=>'Auth\RegistrationController@store']);
/*
|--------------------------------------------------------------------------
| Dashboard Routes
|--------------------------------------------------------------------------
*/



// Route::get('/password/reset/sendmail', function () {
//     return view('auth.password.emailsuccess');
// })->name('resetmail');
Route::get('/registrations', function(){
    return view('registrations.registration');
});
Route::post('registration', 'LeadsController@store');

Route::group(['middleware' => 'auth'], function () {        
    Route::get('/loggedInUser','UsersController@loggedInUser' );

    // Route::get('/changeRole/{id}', function($id){
    //     $user = new UsersController;
    //     $user->activateRole($id);
    //     return redirect('/');
    // }); 

    // Route::post('broadcasting/auth', function() {
       
    //    response('OK', 200); //  Auth::check();
    // });

  
Route::get('{all}', function () {
        $user = new UsersController;
        $user = $user->loggedInUser();
        return view('index')->with('user', $user); 
    })->where('all', '^(?!api).*$');
 
Route::group(['prefix' => 'api',  'middleware' => 'ajax'], function () { 

    Route::get('/desk/works', 'JobsController@index');
    Route::get('/desk/works/{id}/bids', ['uses'=>'BidsController@jobBids']);
    Route::post('/desk/works/{id}/bids', ['uses'=>'BidsController@store']);

    Route::post('users/status/online', 'UserStatusController@online');
    Route::post('users/status/offline', 'UserStatusController@offline');
    Route::get('users/status/offline', 'UserStatusController@offline');

    Route::get('/works', ['uses'=>'JobsController@availJobs']);
    Route::get('/works/{id}', ['uses'=>'JobsController@info']);
    Route::get('/works/{id}/bids', ['uses'=>'BidsController@jobBids']);
    Route::post('/works/{id}/bids', ['uses'=>'BidsController@store']);

    Route::get('/bids', 'BidsController@userBids');

    Route::get('/jobs', ['uses'=>'JobsController@jobs']);
    Route::get('/jobs/{id}', ['uses'=>'JobsController@awardedInfo']);
    Route::get('/jobs/{id}/jwbs', ['uses'=>'JobsController@jwbs']);
    Route::get('/jobs/{id}/quantity', ['uses'=>'QuantityController@index']);
    Route::post('/jobs/{id}/quantity', ['uses'=>'QuantityController@store']);
    Route::post('/jobs/{id}/quantity/files', ['uses'=>'QuantityController@upload']);    
    Route::get('/jobs/{id}/stacks', ['uses'=>'QuantityController@stack']);
    Route::post('/jobs/rate', 'JobsController@rateJob');    

  
    Route::get('/jobs/{id}/audit', ['uses'=>'AuditsController@index']);
    Route::post('/jobs/{id}/audit', ['uses'=>'AuditsController@store']);
    Route::post('/jobs/{id}/audit/files', ['uses'=>'AuditsController@upload']);  

    Route::get('/projects/{id}/pwbs', ['uses'=>'PwbsController@index']); // Get the Pwbs by id
    Route::get('/desk/wbs', ['uses'=>'WbsController@index']); // Get the global wbs
    Route::post('/desk/wbs', ['uses'=>'WbsController@store']); 
    Route::post('/desk/wbs/delete', ['uses'=>'WbsController@delete']); 

    Route::get('/desk/clients', ['uses'=>'ClientsController@index']);
    Route::get('/desk/clients/{uid}', ['uses'=>'ClientsController@show']);
    
    Route::get('/desk/leads', 'LeadsController@index');
    // Route::get('/api/{pid}/links', ['uses'=>'ApiController@links']);
    Route::get('/projects/{pid}/folders', ['uses'=>'FoldersController@index']);

    Route::get('/projects', ['uses'=>'ProjectsController@index']); // show all projects
    Route::get('/projects/{id}', ['uses'=>'ProjectsController@show']);  // show existing project
    Route::post('/projects', ['uses'=>'ProjectsController@store']); // store new project


    Route::get('/projects/{id}/sections', ['uses'=>'SectionsController@index']);
    Route::get('/projects/sections/{gid}', ['uses'=>'SectionsController@show']);
    Route::post('/projects/{id}/sections', ['uses'=>'SectionsController@store']);
    Route::post('/projects/{id}/sections/delete', ['uses'=>'SectionsController@delete']);
    Route::get('/projects/sections/{gid}/packages', ['uses'=>'PackagesController@showByGroup']);
    Route::post('/projects/{pid}/packages', ['uses'=>'PackagesController@store']);
    Route::post('/projects/{pid}/packages/delete', ['uses'=>'PackagesController@delete']);


    Route::get('/projects/sections/{gid}/gwbs', ['uses'=>'SwbsController@index']);
    Route::get('/projects/{pid}/sections/{gid}', ['uses'=>'SwbsController@swbsCodesByGroupId']);
    Route::post('/projects/sections/{gid}/gwbs/pass', ['uses'=>'SwbsController@pass']);
    Route::post('/projects/sections/{gid}/gwbs/delete', ['uses'=>'SwbsController@delete']);
    Route::get('/projects/{pid}/gwbs', ['uses'=>'SwbsController@swbsCodesByProjectId']);
   



    // Route::get('/projects/{id}/pwbs', ['uses'=>'PwbsController@show']);  // show existing project pwbs
    Route::post('/projects/{id}/pwbs/update', ['uses'=>'PwbsController@update']);  // update
    Route::post('/projects/{id}/pwbs/pass', ['uses'=>'PwbsController@pass']);  // pass from WBS
    Route::post('/projects/{id}/pwbs/create', ['uses'=>'PwbsController@create']);  // new Pwbs element
    Route::post('/projects/{id}/pwbs/delete', ['uses'=>'PwbsController@delete']);  // Remove codes from pwbs 
    Route::get('/projects/{id}/pwbs/leaves', ['uses'=>'PwbsController@leaves']);  // Remove codes from pwbs 
    Route::post('/projects/{pid}/pwbs/unitify', ['uses'=>'PwbsController@unitify']); 
    Route::post('/projects/pwbs/commit', ['uses'=>'PwbsController@commit']); 
    
    Route::get('/projects/sections/{gid}/packages', ['uses'=>'PackagesController@index']);// Show packages with group id



    Route::get('/projects/{pid}/files', ['uses'=>'FilesController@index']);

    Route::post('/desk/projects/files', ['uses'=>'FilesController@store']);

    Route::get('/projects/{pid}/links', ['uses'=>'LinksController@index']);
    Route::post('/projects/{pid}/links', ['uses'=>'LinksController@store']);
    Route::post('/projects/{pid}/links/update', ['uses'=>'LinksController@store']);
    Route::post('/projects/{pid}/links/delete', ['uses'=>'LinksController@delete']);

    Route::post('/projects/{pid}/folders', ['uses'=>'FoldersController@store']);
    Route::post('/projects/{pid}/folders/delete', ['uses'=>'FoldersController@delete']);
    Route::get('/projects/folders/files', ['uses'=>'FilesController@index']);
    Route::post('/projects/folders/{fid}/files/post', ['uses'=>'FilesController@upload']);
    Route::post('/projects/folders/{fid}/files/delete', ['uses'=>'FilesController@delete']);

    Route::get('/clients/projects', ['uses'=>'ProjectsController@getProjectsByClient']); 
    
    Route::get('admin/users', 'UsersController@store');
    Route::get('admin/users', ['uses'=>'UsersController@index']);
    Route::get('admin/users/{uid}', ['uses'=>'UsersController@show']);

    Route::get('admin/users/{uid}/jobs', ['uses'=>'JobsController@jobsByUser']);
    
    Route::post('admin/users', ['uses'=>'UsersController@store']);
    Route::post('admin/users/attachrole', ['uses'=>'UsersController@assignRole']);
    Route::post('admin/users/{uid}/roles/detach', ['uses'=>'UsersController@detachRole']);
/*
|--------------------------------------------------------------------------
| Admin / Role Routes
|--------------------------------------------------------------------------
*/

    Route::get('admin/roles', ['uses'=>'RolesController@index']);
    Route::get('admin/roles/{rid}', ['uses'=>'RolesController@show']);
    Route::post('admin/roles/', ['uses'=>'RolesController@store']);
    Route::post('admin/roles/permissions', ['uses'=>'RolesController@assignPermission']);
    Route::post('admin/roles/permissions/detachPermission', ['uses'=>'RolesController@detachPermission']);
    Route::post('admin/roles/delete', ['uses'=>'RolesController@delete']);

/*
|--------------------------------------------------------------------------
| Admin / Permission Routes
|--------------------------------------------------------------------------
*/

    Route::get('admin/permissions', ['uses'=>'PermissionsController@index']);
    Route::post('admin/permissions/', ['uses'=>'PermissionsController@store']);
    Route::post('admin/permissions/delete', ['uses'=>'PermissionsController@delete']);
    Route::get('admin/nations', ['uses' => 'NationsController@index']);
    Route::get('admin/nations/{nid}', ['uses' => 'NationsController@show']);
    Route::post('admin/nations', ['uses' => 'NationsController@store']);
    Route::post('admin/nations/delete', ['uses' => 'NationsController@delete']);

    Route::get('/reports/{id}', ['uses'=>'ReportsController@index']);

    Route::get('/messages', 'MessageController@getPrivateMessages');

    Route::post('/messages', ['uses'=>'MessageController@store']);
    Route::post('/messages/read', 'MessageController@readMessages');
    Route::get('/messages/address', 'ChatAddressController@index');
    Route::get('/messages/countunreads', 'MessageController@count');
    Route::get('/messages/countallunreads', 'MessageController@countAllUnreads');
    Route::post('/messages/address/loadcontacts', 'ChatAddressController@addressAutomate'); 

    Route::post('/messages/files', ['uses'=>'MessagesController@uploadFile']);

    Route::get('/jobs/{id}/issues', ['uses'=>'IssuesController@index']);
    Route::get('/jobs/issues/{id}', ['uses'=>'IssuesController@show']);
    Route::post('/issues', ['uses'=>'IssuesController@store']);

    Route::post('/jobs/issues/{id}/reply', ['uses'=>'IssueReplyController@store']);
    Route::post('/jobs/issues/image/delete', ['uses'=>'IssuesController@deleteFile']); 
   
    Route::get('/widgets/clients/{uid}/projects', [
        'uses' => 'WidgetsController@clientProjects'
    ]);

    Route::post('/forms', ['uses' => 'FormsController@store']);
    Route::get('/forms', ['uses' => 'FormsController@index']);
    Route::get('/forms/{id}', ['uses' => 'FormsController@show']);
    Route::post('/forms/delete', ['uses' => 'FormsController@delete']);

    //Dashboard
    Route::get('/dashboard/countprojects', 'DashBoardController@countProjects');
    Route::get('/dashboard/countjobs', 'DashBoardController@countJobs');
    Route::get('/dashboard/countleads', 'DashBoardController@countLeads');
    Route::get('/dashboard/countclients', 'DashBoardController@countClients');
    Route::get('/dashboard/countissues', 'DashBoardController@countIssues');
    Route::get('/dashboard/newjobs', 'DashBoardController@newJobs');
    Route::get('/dashboard/newprojects', 'DashBoardController@newProjects');
   //Notifications
    Route::get('/notifications', 'NotificationController@index');
    
    });
    
 });
    
    Route::post('/api/jobs/issues/{id}/reply/file', ['uses'=>'IssueReplyController@upload']);    
    Route::get('/api/downloads/jobs/qfiles/{id}/{c}', 'QuantityController@downloadQFile');
    Route::get('/api/downloads/jobs/afiles/{id}/{c}', ['uses'=>'QuantityController@downloadAFile']);
    Route::get('/api/downloads/jobs/mrkd/{id}/{c}', ['uses'=>'QuantityController@downloadMrkd']);
    Route::get('/api/downloads/jobs/amrkd/{id}/{c}', ['uses'=>'QuantityController@downloadAMrkd']);


  