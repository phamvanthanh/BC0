<?php
use Snail\Mail\QMail;
use Snail\Http\Controllers\UsersController;

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

Route::get('/unauthorized', function() {
    return view('unauthorized');
})->name('unauthorized');

Route::group(['middleware' => 'auth'], function () { 
    Route::get('/loggedInUser',['uses'=>'UsersController@loggedInUser'] );

    Route::get('/changeRole/{id}', function($id){
        $user = new UsersController;
        $user->activateRole($id);
        return redirect('/');
    }); 

    Route::get('/logout', function () {
        Auth::logout();
        return redirect('/login');
    }); 

    Route::get('/', function () {
        $user = new UsersController;
        $user = $user->loggedInUser();
        return view('index')->with('user', $user); 
    });

    Route::get('/jobs', ['uses'=>'JobsController@jobs']);
    Route::get('/jobs/{id}', ['uses'=>'JobsController@jobInfo']);

// Route::get('/',['uses'=>'PagesController@dash'])->name('dash');

Route::group(['middleware' => 'role:project_manager'], function () { 

 Route::get('/pm', function () {
        $user = new UsersController;
        $user = $user->loggedInUser();
        return view('pm.index')->with('user', $user);

    });
/*
|--------------------------------------------------------------------------
| Projects Routes
|--------------------------------------------------------------------------
*/

Route::get('/projects', ['uses'=>'ProjectsController@index']); // show all projects
// Route::get('/projects/new', ['uses'=>'ProjectsController@create']); // show create a project form
Route::post('/projects', ['uses'=>'ProjectsController@post']); // store new project
Route::get('/projects/{id}', ['uses'=>'ProjectsController@show']);  // show existing project

/*
|--------------------------------------------------------------------------
| Link, Files, Folders Routes
|--------------------------------------------------------------------------
*/
Route::get('/projects/{pid}/files', ['uses'=>'FilesController@index']);

Route::post('/projects/{pid}/links', ['uses'=>'LinksController@store']);
Route::post('/projects/{pid}/links/update', ['uses'=>'LinksController@store']);
Route::post('/projects/{pid}/links/delete', ['uses'=>'LinksController@delete']);

Route::post('/projects/{pid}/folders', ['uses'=>'FoldersController@store']);
Route::post('/projects/{pid}/folders/delete', ['uses'=>'FoldersController@delete']);
Route::get('/projects/folders/{fid}/files', ['uses'=>'FilesController@showByFolder']);
Route::post('/projects/folders/{fid}/files/post', ['uses'=>'FilesController@upload']);
Route::post('/projects/folders/{fid}/files/delete', ['uses'=>'FilesController@delete']);

/*
|--------------------------------------------------------------------------
| Pwbs Routes
|--------------------------------------------------------------------------
*/

Route::get('/projects/{id}/pwbs', ['uses'=>'PwbsController@show']);  // show existing project pwbs
Route::post('/projects/{id}/pwbs/update', ['uses'=>'PwbsController@update']);  // update
Route::post('/projects/{id}/pwbs/pass', ['uses'=>'PwbsController@pass']);  // pass from WBS
Route::post('/projects/{id}/pwbs/create', ['uses'=>'PwbsController@create']);  // new Pwbs element
Route::post('/projects/{id}/pwbs/delete', ['uses'=>'PwbsController@delete']);  // Remove codes from pwbs 
Route::get('/projects/{id}/pwbs/leaves', ['uses'=>'PwbsController@leaves']);  // Remove codes from pwbs 
Route::post('/projects/{pid}/pwbs/unitify', ['uses'=>'PwbsController@unitify']); 

Route::get('/projects/{id}/schedule', ['uses'=>'ScheduleController@show']);
Route::get('/projects/{id}/markdowns', ['uses'=>'MarkdownsController@show']);
Route::get('/projects/{id}/team', ['uses'=>'TeamController@show']);

Route::get('/projects/{id}/reports', ['uses'=>'ReportsController@show']);


/*
|--------------------------------------------------------------------------
| Groups Routes
|--------------------------------------------------------------------------
*/

Route::get('/projects/{id}/groups', ['uses'=>'GroupsController@index']);
Route::get('/projects/groups/{gid}', ['uses'=>'GroupsController@show']);
Route::post('/projects/{id}/groups', ['uses'=>'GroupsController@store']);
Route::post('/projects/{id}/groups/delete', ['uses'=>'GroupsController@delete']);

/*
|--------------------------------------------------------------------------
| Packages Routes
|--------------------------------------------------------------------------
*/

Route::get('/projects/{pid}/packages', ['uses'=>'PackagesController@index']);
Route::get('/projects/{pid}/packages/{pkid}', ['uses'=>'PackagesController@show']);
Route::get('/projects/groups/{gid}/packages', ['uses'=>'PackagesController@showByGroup']);
Route::post('/projects/{pid}/packages', ['uses'=>'PackagesController@store']);
Route::post('/projects/{pid}/packages/delete', ['uses'=>'PackagesController@delete']);


/*
|--------------------------------------------------------------------------
| Gwbs Routes
|--------------------------------------------------------------------------
*/

Route::get('/projects/groups/{gid}/gwbs', ['uses'=>'GwbsController@index']);
Route::post('/projects/groups/{gid}/gwbs/pass', ['uses'=>'GwbsController@pass']);
Route::post('/projects/groups/{gid}/gwbs/delete', ['uses'=>'GwbsController@delete']);
Route::get('/projects/{pid}/gwbs', ['uses'=>'GwbsController@gwbsCodesByProjectId']);
Route::get('/projects/{pid}/groups/{gid}', ['uses'=>'GwbsController@gwbsCodesByGroupId']);

});
/*
|--------------------------------------------------------------------------
| Jobs Routes
|--------------------------------------------------------------------------
*/


// Route::get('/jobs', ['uses'=>'JobsController@index']);


// /*
// |--------------------------------------------------------------------------
// | Bids Routes
// |--------------------------------------------------------------------------
// */
// Route::get('/bids', ['uses'=>'BidsController@index']);
Route::get('/jobs/{id}/bids', ['uses'=>'BidsController@index']);
Route::post('/jobs/{id}/bids', ['uses'=>'BidsController@store']);

/*
|--------------------------------------------------------------------------
| Quantity Routes
|--------------------------------------------------------------------------
*/
// Route::group(["middleware"=>"role:surveyor"], function(){
    Route::get('/jobs/{id}/quantity', ['uses'=>'QuantityController@index']);
    Route::post('/jobs/{id}/quantity', ['uses'=>'QuantityController@store']);
    Route::post('/jobs/{id}/quantity/files', ['uses'=>'QuantityController@upload']);

// });
// /*
// |--------------------------------------------------------------------------
// | Audit Routes
// |--------------------------------------------------------------------------
// */
Route::get('/jobs/{id}/audit', ['uses'=>'AuditsController@index']);
Route::post('/jobs/{id}/audit', ['uses'=>'AuditsController@store']);
Route::post('/jobs/{id}/audit/files', ['uses'=>'AuditsController@upload']);



/*
|--------------------------------------------------------------------------
| Sales Routes
|--------------------------------------------------------------------------
*/

Route::get('/quotation-wizard/{id}', ['uses'=>'QuotationController@wizard']);


/*
|--------------------------------------------------------------------------
| Admin / User Routes
|--------------------------------------------------------------------------
*/



// Route::prefix('admin')->group( function(){

 Route::group(["middleware"=>"role:admin"], function() {
    Route::get('admin', function () {
        $user = new UsersController;
        $user = $user->loggedInUser();
        return view('admin.index')->with('user', $user);

    });



    Route::get('admin/users', ['uses'=>'UsersController@index']);
    Route::get('admin/users/{uid}', ['uses'=>'UsersController@show']);
    Route::post('admin/users', ['uses'=>'UsersController@store']);
    Route::post('admin/users/attachrole', ['uses'=>'UsersController@assignRole']);
    Route::post('admin/users/{uid}/roles/detach', ['uses'=>'UsersController@removeRole']);
/*
|--------------------------------------------------------------------------
| Admin / Role Routes
|--------------------------------------------------------------------------
*/

    Route::get('admin/roles', ['uses'=>'RolesController@index']);
    Route::post('admin/roles/', ['uses'=>'RolesController@store']);
    Route::post('admin/roles/delete', ['uses'=>'RolesController@delete']);

/*
|--------------------------------------------------------------------------
| Admin / Permission Routes
|--------------------------------------------------------------------------
*/

    Route::get('admin/permissions', ['uses'=>'PermissionsController@index']);
    Route::post('admin/permissions/', ['uses'=>'PermissionsController@store']);
    Route::post('admin/permissions/delete', ['uses'=>'PermissionsController@delete']);
});


/*
|--------------------------------------------------------------------------
| Jobs Routes
|--------------------------------------------------------------------------
*/

Route::get('/jobs', ['uses'=>'JobsController@index']);
Route::post('/jobs', ['uses'=>'JobsController@store']);
Route::get('/jobs/{jid}', ['uses'=>'JobsController@show']);






/*
|--------------------------------------------------------------------------
| Email Routes
|--------------------------------------------------------------------------
*/
Route::get('/mail', function () {
    $data = array();

    Mail::send('mails.mail', $data, function ($message) {

        $message->from('thanhpv@nomail.com', "TEST LETTER SEND FROM  NO MAIL");

        $message->to('mindung.nguyen86@gmail.com', null)->subject('Please click accept so i have a real mail to test.');

    });
    

});
/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
*/

Route::get('/api/{id}/pwbs', ['uses'=>'ApiController@pwbs']); // Get the Pwbs by id
Route::get('/api/wbs', ['uses'=>'ApiController@wbs']); // Get the global wbs
Route::get('/api/{id}/project', ['uses'=>'ApiController@project']); // Get a project
Route::get('/api/clients', ['uses'=>'ApiController@clients']);
Route::get('/api/{pid}/links', ['uses'=>'ApiController@links']);
Route::get('/api/{pid}/folders', ['uses'=>'ApiController@folders']);
 
// else
//     redirect('/login');
 

// // Auth::routes();

// Route::get('/home', 'HomeController@index')->name('home');

});