<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;


class ole_unplanned_event_cip extends Model
{
    use HasFactory;
    public $timestamps = true;
    protected $fillable = ['OLE', 'productionline', 'previous_bulk', 'predicted_duration', 'total_duration', 'comment'];


}
