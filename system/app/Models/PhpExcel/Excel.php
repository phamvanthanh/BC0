<?php

namespace system\Models\PhpExcel;

use Maatwebsite\Excel\Facades\Excel;

class SpreadSheet extends \Maatwebsite\Excel\Files\ExcelFile {

    protected $delimiter  = ',';
    protected $enclosure  = '"';
    protected $lineEnding = '\r\n';

   
    public function getFile()
    {
        return storage_path('quantities') . '/4_31100.xlsx';
    }

    public function getFilters()
    {
        return [
            'chunk'
        ];
    }

}