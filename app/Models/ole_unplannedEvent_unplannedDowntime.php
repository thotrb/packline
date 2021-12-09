<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ole_unplannedEvent_unplannedDowntime extends Model
{

    use HasFactory;
    public $timestamps = true;
    protected $fillable = ['OLE', 'productionline', 'implicated_machine', 'total_duration', 'component', 'comment'];

}


