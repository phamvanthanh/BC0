<?php

namespace system\Http\Controllers;
use system\Models\Bid;
use Illuminate\Http\Request;
use system\Http\Requests\BidForm;
use DB;

class BidsController extends Controller
{
    public function userBids(Request $request) {
  
        extract($request->only(['query', 'limit', 'page', 'ascending', 'orderBy']));
        $ascending = $ascending == 1? 'ASC' : 'DESC';

        $user_id = $request->user()->id;
        
        $dropTempTables = DB::unprepared(
            DB::raw("
                DROP TABLE IF EXISTS vjobs; 
                DROP TABLE IF EXISTS vpackages;   
                           
            ")
        );
        $vjobs = DB::unprepared( DB::raw(
                        'CREATE TEMPORARY TABLE vjobs
                            AS (select
                                jobs.id,                                 
                                jobs.jobable_type,
                                jobs.jobable_id,
                                jobs.from_date,
                                jobs.to_date, 
                                jobs.status,
                                bids.created_at,
                                bids.updated_at
                            from bids                               
                            JOIN jobs
                            ON bids.job_id = jobs.id
                            where bids.user_id = "'.$user_id.'" ); 

                          CREATE TEMPORARY TABLE vpackages
                            AS (select packages.id, packages.name, sections.project_id from packages
                            JOIN sections
                            ON packages.section_id = sections.id);
                        
                        ') 
                     ); 

        return DB::table('vjobs')
           ->LeftJoin('projects', function($join){
               $join->on('vjobs.jobable_id', '=', 'projects.id')
                    ->where('vjobs.jobable_type', '=', 'project');
           })
           ->LeftJoin('sections', function($join){
               $join->on('vjobs.jobable_id', '=', 'sections.id')
                    ->where('vjobs.jobable_type', '=', 'section');
           })      
           ->leftJoin('vpackages' , function($join){
               return $join->on('vjobs.jobable_id', '=', 'vpackages.id')
                           ->where('vjobs.jobable_type', '=', 'package');
           })
           ->Join('projects as p', function($join) {
               $join->on('projects.id', '=', 'p.id')
                    ->orOn('sections.project_id', '=', 'p.id')
                    ->orOn('vpackages.project_id', '=', 'p.id');                  
            })
         
            ->select(DB::raw('
                vjobs.id,
                vjobs.jobable_type,               
                vjobs.from_date,
                vjobs.to_date,
                vjobs.status,
                vjobs.created_at,
                vjobs.updated_at,
                    IF(vjobs.jobable_type = "project", projects.name,
                    IF(vjobs.jobable_type = "section", sections.name, vpackages.name) 
                ) as name,
                p.name as project,
                p.nation_abbr as nation_abbr
             
             
             '               
           ))
           ->where('vjobs.status', '=', 'active')
          
           
           ->where(function($q) use($query){
                    return $q->where('vjobs.id', 'LIKE', "%{$query}%")
                    ->orWhere('vjobs.jobable_type', 'LIKE', "%{$query}%")
                    ->orWhere('vjobs.from_date', 'LIKE', "%{$query}%")
                    ->orWhere('vjobs.to_date', 'LIKE', "%{$query}%")
                    ->orWhere('p.name', 'LIKE', "%{$query}%")
                    ->orWhere('projects.name', 'LIKE', "%{$query}%")
                    ->orWhere('sections.name', 'LIKE', "%{$query}%")
                    ->orWhere('vpackages.name', 'LIKE', "%{$query}%");
            })   
                   
           ->orderBy($orderBy, $ascending)
           ->paginate($limit);            

        
    }

    public function jobBids($jid)  {
        return Bid::where('job_id', $jid)->with('user')->with('awards')->get();    
    }
    public function store(BidForm $form) {
       
      return  $form->persist(); 
    }
}

