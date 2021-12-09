<?php


namespace App\Models;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;



class ole_unplanned_event_changing_client extends Model
{

    use HasFactory;
    public $timestamps = true;
    protected $fillable = ['OLE', 'productionline', 'predicted_duration', 'total_duration', 'lot_number', 'comment'];
}
